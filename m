Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7DL7LrT026651
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 17:07:21 -0400 (EDT)
Received: from mail.mvalent.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7DL7JRl025040
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 21:07:19 GMT
Subject: RE: vsftpd and security labels
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 13 Aug 2004 17:07:20 -0400
Message-ID: <E6E16A6D4277CD459BBDE6713766033CA50DFA@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Still fails
ftp policy # make clean
rm -f policy.16
rm -f policy.conf
rm -fR tmp
rm -f file_contexts/file_contexts
ftp policy # make reload
 * Creating policy.conf
 * Policy version: 16
 * Kernel version: 17
 * WARNING: Policy version mismatch
 * Compiling and installing policy.16
/usr/bin/checkpolicy:  loading policy configuration from
/etc/security/selinux/src/policy.conf
security:  3 users, 5 roles, 374 types, 1 bools
security:  31 classes, 25165 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 16) to
/etc/security/selinux/policy.16
 * Building file_contexts
 * Installing file_contexts
 * Loading policy.16
ftp policy # make relabel
 * Relabeling filesystem types: ext2 ext3 xfs
/usr/sbin/setfiles:  read 570 specifications
/usr/sbin/setfiles:  labeling files under /
/usr/sbin/setfiles:  conflicting specifications for
/usr/share/terminfo/v/vt100-am and /etc/terminfo/v/vt100, using
system_u:object_r:usr_t.
/usr/sbin/setfiles:  conflicting specifications for
/usr/share/terminfo/v/vt200 and /etc/terminfo/v/vt220, using
system_u:object_r:usr_t.
/usr/sbin/setfiles:  conflicting specifications for
/usr/share/terminfo/s/sun1 and /etc/terminfo/s/sun, using
system_u:object_r:usr_t.
/usr/sbin/setfiles:  hash table stats: 155021 elements, 55502/65536
buckets used, longest chain length 6
/usr/sbin/setfiles:  Done.
ftp policy #

ftp policy # /etc/init.d/vsftpd restart
Authenticating root.
Password: 
 * Stopping vsftpd...
[ ok ]
 * Starting vsftpd...
[ ok ]
ftp policy #

C:\Documents and Settings\jmarcus>ftp ftp
Connected to ftp.mvalent.local.
220 (vsFTPd 1.2.2)
User (ftp.mvalent.local:(none)): jmarcus
331 Please specify the password.
Password:
230 Login successful.
ftp> ls
500 OOPS: capset
200 PORT command successful. Consider using PASV.
500 OOPS: vsf_sysutil_recv_peek
Connection closed by remote host.
ftp>




-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Stephen Smalley
Sent: Friday, August 13, 2004 1:51 PM
To: James R. Marcus
Cc: selinux@tycho.nsa.gov
Subject: Re: vsftpd and security labels

On Fri, 2004-08-13 at 11:23, James R. Marcus wrote:
> /usr/sbin/setfiles:  read 570 specifications
> /usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_exec_t on
> line number 596

This means that the new policy wasn't loaded into the kernel, so it
doesn't recognize the new types defined by the ftpd policy.  Reload your
policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
