import os
import email
from email import policy
from email.parser import BytesParser
import re
from datetime import datetime

# Path to the email file
input_file = "/home/jonas/mail/saved-messages"

# Output folder
output_dir = "/home/jonas/mail/plain_emails"
os.makedirs(output_dir, exist_ok=True)

def sanitize_filename(name):
    """Remove problematic characters for filenames"""
    return re.sub(r'[\\/*?:"<>|]', "", name)

def parse_email_datetime(date_str):
    """Try to parse the Date header into YYYY-MM-DD_HH-MM format"""
    try:
        parsed_date = email.utils.parsedate_to_datetime(date_str)
        return parsed_date.strftime('%Y-%m-%d_%H-%M')
    except Exception:
        return "unknown-date"

# Read the whole file
with open(input_file, "rb") as f:
    raw_data = f.read()

# Split raw emails (assuming mbox format with "From " separator)
emails = raw_data.split(b'\nFrom ')

# If first email doesn't start with "From ", fix it
if emails and not emails[0].startswith(b'From '):
    emails[0] = b'From ' + emails[0]

# Save the first email to keep
first_email = emails[0]

# Process the rest, ignoring the first
for raw_email in emails[1:]:
    if not raw_email.strip():
        continue

    raw_email = b'From ' + raw_email  # Add back separator if missing
    msg = BytesParser(policy=policy.default).parsebytes(raw_email)

    subject = msg['subject'] or "No Subject"
    sender = msg['from'] or "Unknown Sender"
    receiver = msg['to'] or "Unknown Receiver"
    date = msg['date'] or "Unknown Date"

    subject_clean = sanitize_filename(subject.strip())
    date_clean = parse_email_datetime(date)

    # Get the plain text part
    if msg.is_multipart():
        for part in msg.walk():
            if part.get_content_type() == "text/plain":
                body = part.get_payload(decode=True).decode(part.get_content_charset() or 'utf-8', errors='replace')
                break
        else:
            body = "(No plain text part found)"
    else:
        body = msg.get_payload(decode=True).decode(msg.get_content_charset() or 'utf-8', errors='replace')

    # Create the filename: Date_Time_Subject.txt
    filename = f"{date_clean}_{subject_clean}.txt"
    output_path = os.path.join(output_dir, filename)

    # Write to file
    with open(output_path, "w", encoding="utf-8") as out_f:
        out_f.write(f"Date: {date}\n")
        out_f.write(f"From: {sender}\n")
        out_f.write(f"To: {receiver}\n\n")
        out_f.write(body)

# After processing, overwrite the mailbox with only the first email
with open(input_file, "wb") as f:
    f.write(first_email)
