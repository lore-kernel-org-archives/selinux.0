Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: login messages
Date: Mon, 6 Oct 2003 10:35:39 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


When I login as my user, I get the following messages.   Is this normal and
can someone explain what they mean?  When I log in as root, I do not get
these messages.

Your default context is jamesk:user_r:user_t
Keymap 0: Permission denied
Keymap 1: Permission denied
Keymap 2: Permission denied
KDSKBENT: Operation not permitted
loadkeys: could not deallocate keymap 3


When I then try to switch to the sysadm role from the user role, I get the
following message.  In my policy "user" file, I have jamesk set for {
staff_r sysadm_r } roles.  Why can't I switch?

# newrole -r sysadm_r
jamesk:sysadm_r:sysadm_t is not a valid context

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
