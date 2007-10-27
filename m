Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9UC2bgr015101
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2007 08:02:37 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9UC2b7u003922
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2007 12:02:37 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l9UBwN9d014757
	for <selinux@tycho.nsa.gov>; Tue, 30 Oct 2007 07:58:23 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l9UBwNNV014756
	for selinux@tycho.nsa.gov; Tue, 30 Oct 2007 07:58:23 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9R4HJWs024872
	for <selinux@tycho.nsa.gov>; Sat, 27 Oct 2007 00:17:21 -0400
Received: from cirrus.av8.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9R4HInA023091
	for <selinux@tycho.nsa.gov>; Sat, 27 Oct 2007 04:17:19 GMT
Received: from [130.105.12.10] ([130.105.12.10])
	(authenticated bits=0)
	by cirrus.av8.net (8.12.11/8.12.11) with ESMTP id l9R4HEb8030644
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <selinux@tycho.nsa.gov>; Sat, 27 Oct 2007 00:17:17 -0400
Date: Sat, 27 Oct 2007 00:17:13 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: selinux@tycho.nsa.gov
Subject: Decoder for log messages???
Message-ID: <Pine.LNX.4.44.0710262329300.30215-100000@citation2.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I removed and reinstalled httpd, and got a bunch of these messages.  
I'm guessing that dm-0 refers to a devicemapper device (which on my
system doesn't seem to actually be in use, so I'm left wondering what
the heck...perhaps a shared device number)  I had to disable selinux
because I couldn't figure out how to fix the problem within a couple
minutes and needed to put the server back online.  

I think some directory was searched, but have no idea exactly what
directory. It caused httpd to terminate:

messages:Oct 26 21:35:03 mallard kernel: audit(1193448902.933:56): avc:  
denied  { search } for  pid=
11594 comm="httpd" name="sparc" dev=dm-0 ino=15699715 
scontext=root:system_r:httpd_t:s0 tcontext=system_u:object_r:src_t:s0 tclass=dir

So can anyone decode this to a full pathname?

Can you decode it in 6 months with only a filesystem dump? Because by
then one no longer has the file-to-inode-number association and has also
lost the device mapper mappings.


Comment: A log file entry may be reviewed long after the entry was made
and after the system that made the entry was destroyed. The destruction
of said system may be the reason for reviewing the logs. Since inode
numbers change across filesystem restoration, the inode number isn't a
permanent identifier. Device numbers and names are also dynamic.  So,
once this filesystem is destroyed, the log information is useless.  
This is a crack into selinux; the attacker merely has to tamper with a
file, and anticipating the log entry, compensates by destroying the
filesystem (after a backup).  The log entry is then useless.  The admin
knows some file was tampered with, but not which file.  The admin
probably has to use the backup because they can't dump months of work
and they don't have time to examine each file in a filesystem.


Comment: Putting a device basename and inode number in a log message
does not uniquely identify the file.  Nor is this helpful.  However, if
you think that full file names are too long to log (a questionable
assumption, but I won't question it now), then one must still uniquely
identify the file some other way.  That requires the FULL device path
name, and the inode number. (but as above, that isn't permanent 
identifier)


Comment: This problem is in the same nature of problem that backup
software often has; they also never seem to fully anticipate the
situation of a failure of some sort and what needs to be recovered to
make the backup system work well enough to perform a restore.  This
makes those systems fragile, and tedious during a failure when such
systems are needed most.  Likewise, SELinux was very fragile in this
case, because it was impossible or tediously difficult to find the cause
of the problem from the log entry.  But we have logs to keep track of
history and to identify problems.  Security is generally not improved by
obscurity. Obscure and ambiguous messages are harmful in every way
possible. Forensic evidence is also harmed.  When there is a security
problem, the problem needs to be made plain and permanently,
unambiguously described.

		--Dean


-- 
Av8 Internet   Prepared to pay a premium for better service?
www.av8.net         faster, more reliable, better service
617 344 9000   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
