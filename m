Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A55@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: root login with enforcing on
Date: Fri, 24 Oct 2003 15:55:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

When I login as root with enforce set to 1, root does not have permission to
access the "/root/.bash_profile" file.  What rule should I add to allow root
access to that file?  Thanks.

login: root
Password:
Last Login: Fri Oct 24 on tty1
You have new mail.
-bash: /root/.bash_profile: Permisson denied
-bash-2.05b#


James Kratzer
Software Engineer
 (513) 881-3338



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
