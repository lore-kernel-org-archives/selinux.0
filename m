Message-ID: <4A996106.4060604@martinorr.name>
Date: Sat, 29 Aug 2009 18:10:30 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: restorecon and symbolic links
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With policycoreutils 2.0.71, "restorecon /dev/stdin" fails if stdin is a pipe:
martin@caligula:~$ echo hi | sudo restorecon /dev/stdin
realpath(/dev/stdin) failed No such file or directory

Why would you want to do this?
The Debian udev init script does
ln -s /proc/self/fd/0 /dev/stdin
restorecon /dev/stdin
I am not sure why stdin is a pipe here but it is some consequence of the
boot process.

The intention here (and what happened with policycoreutils 2.0.69) is to
relabel the symbolic link.  But the recent realpath patch changed this, and
I don't think there is a way now to ask restorecon to relabel an individual
symlink.

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
