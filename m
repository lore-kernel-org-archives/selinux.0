Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8N05m2H008466
	for <selinux@tycho.nsa.gov>; Sat, 22 Sep 2007 20:05:48 -0400
Received: from dmzmta101.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8N05l5D011598
	for <selinux@tycho.nsa.gov>; Sun, 23 Sep 2007 00:05:47 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l8N04OOC007380
	for <selinux@tycho.nsa.gov>; Sat, 22 Sep 2007 20:04:24 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta002.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l8N05YM7027637
	for <selinux@tycho.nsa.gov>; Sat, 22 Sep 2007 20:05:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: chcon -l permission
Date: Sat, 22 Sep 2007 17:05:43 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD49A287@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a java process running in a domain named frontgate_t, which reads
files and determines the correct classification/compartment level of the
file based upon its contents. The java process then relabels the file to
the correct level using "chcon -l ...". It can both upgrade or downgrade
the level of the file

I'm getting file relabelfrom and relabelto denials in the audit log that
I can't get past. I've provided the allow rule indicated by audit2allow.
At first I thought this was an mls constraint issue. I expect that the
following mls privileges would be required:
	mls_file_upgrade(frontgate_t)
	mls_file_downgrade(frontgate_t)
	mls_context_translate_all_levels(frontgate_t) (maybe needed??)

I provided all of these, and then progressively added more and more mls
privileges until I had provided them all. Next, I gutted the mls file
that contains all of the mls constraints to once and for all convince
myself that this wasn't an mls constraint issue.

The only way that I've been able to get the frontgate_t domain to be
allowed to do the "chcon -l ..." command is to make the frontgate_t
domain unconfined by calling "unconfined_domain_noaudit(frontgate_t)"

Here is what audit2allow is outputting:
allow frontgate_t import_datasources_t:file { relabelfrom relabelto };
	#TYPE=AVC  MSG=audit(1190503839.442:60265):  COMM="chcon"
NAME="3V031123P0000207731A0100001001810_01029670.txt"   : relabelfrom
	#TYPE=AVC  MSG=audit(1190503840.856:60266):  COMM="chcon"
NAME="3V031123P0000207731A0100001001810_01029670.txt"   : relabelfrom
	#TYPE=AVC  MSG=audit(1190503839.442:60265):  COMM="chcon"
NAME="3V031123P0000207731A0100001001810_01029670.txt"   : relabelto
	#TYPE=AVC  MSG=audit(1190503840.856:60266):  COMM="chcon"
NAME="3V031123P0000207731A0100001001810_01029670.txt"   : relabelto

I have provided that exact rule in the frontgate.te module.

Here are the corresponding denials from /var/log/audit/audit.log:

type=AVC msg=audit(1190503839.442:60265): avc:  denied  { relabelfrom }
for  pid=8201 comm="chcon"
name="3V031123P0000207731A0100001001810_01029670.txt" dev=sda1
ino=12222486 scontext=m252_u:system_r:frontgate_t:s4:c0.c255
tcontext=root:object_r:import_datasources_t:s4:c10 tclass=file
type=AVC msg=audit(1190503839.442:60265): avc:  denied  { relabelto }
for  pid=8201 comm="chcon"
name="3V031123P0000207731A0100001001810_01029670.txt" dev=sda1
ino=12222486 scontext=m252_u:system_r:frontgate_t:s4:c0.c255
tcontext=root:object_r:import_datasources_t:s4:c0.c255 tclass=file
type=SYSCALL msg=audit(1190503839.442:60265): arch=c000003e syscall=188
per=400000 success=yes exit=0 a0=7fffc6d15b3b a1=39dde120d3 a2=5e40850
a3=2e items=0 ppid=8185 pid=8201 auid=10999 uid=10999 gid=4500
euid=10999 suid=10999 fsuid=10999 egid=4500 sgid=4500 fsgid=4500
tty=pts2 comm="chcon" exe="/usr/bin/chcon"
subj=m252_u:system_r:frontgate_t:s4:c0.c255 key=(null)
type=AVC msg=audit(1190503840.856:60266): avc:  denied  { relabelfrom }
for  pid=8211 comm="chcon"
name="3V031123P0000207731A0100001001810_01029670.txt" dev=sda1
ino=12222486 scontext=m252_u:system_r:frontgate_t:s4:c0.c255
tcontext=root:object_r:import_datasources_t:s4:c0.c255 tclass=file
type=AVC msg=audit(1190503840.856:60266): avc:  denied  { relabelto }
for  pid=8211 comm="chcon"
name="3V031123P0000207731A0100001001810_01029670.txt" dev=sda1
ino=12222486 scontext=m252_u:system_r:frontgate_t:s4:c0.c255
tcontext=root:object_r:import_datasources_t:s4:c10 tclass=file
type=SYSCALL msg=audit(1190503840.856:60266): arch=c000003e syscall=188
per=400000 success=yes exit=0 a0=7fff5f4efb36 a1=39dde120d3 a2=d7c0860
a3=2a items=0 ppid=8185 pid=8211 auid=10999 uid=10999 gid=4500
euid=10999 suid=10999 fsuid=10999 egid=4500 sgid=4500 fsgid=4500
tty=pts2 comm="chcon" exe="/usr/bin/chcon"
subj=m252_u:system_r:frontgate_t:s4:c0.c255 key=(null)

Any ideas would be greatly appreciated!

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
