MIME-Version: 1.0
Date: Tue, 3 Feb 2009 08:15:07 +0900
Message-ID: <a5e2b64d0902021515q18b61935q829abc2bc1772a7e@mail.gmail.com>
Subject: Security context of symbolic links on ubifs
From: Tim <timasyk@gmail.com>
To: SELinux mailing list <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello!

For an embedded project I'm trying to set security context of symbolic
links located on ubifs to files located on ubifs as well.
The result is as following:
- after setting security context using setfiles or restorecon for
links, ls -Z reports correct links labeling;
- after rebooting computer I see that ALL symbolic links got default
label for files for that filesystem (which is incorrect);
Security context labeling for normal files/directories/devices works
just fine and can survive reboot.
I've tried same security context labels for link and linked file,
different security contexts for link and linked file - results are the
same as described.
Any ideas why this is happening?

Tim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
