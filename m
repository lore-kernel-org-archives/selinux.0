Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06616
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 07:48:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA23154
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 11:46:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA23150 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 11:46:49 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4831392466
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 21:48:24 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 239944BB
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 13:48:15 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: directory access
Date: Mon, 19 Aug 2002 13:48:14 +0200
MIME-Version: 1.0
Message-Id: <20020819114815.239944BB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have /var on a separate file system.

I have a bash shell script that does "cd /var/log/ntpstats" running in a 
domain that only allows search access to var_t:dir not getattr, this prevents 
the "cd" from succeeding.

So it seems that such scripts net getattr access to all mount points that are 
involved in a "cd".  For this reason I guess I will have to allow { search 
getattr } access for all directories.

Also many programs seem to do a getattr on all file system root's at their 
startup (some type of "df" operation I guess).  Below I have pasted the log 
output from Squid starting up, it's doing a getattr on the root directory of 
every mounted file system (the messages that are logged correspond to every 
file type of the root directory entry for a file system where Squid is denied 
getattr access).  As an aside I have no idea what Squid is trying to do 
searching /initrd (dev=01:00), but as it was only mounted due to a bug in an 
init script that I've just fixed I am not bothered.

It seems that Squid and a few other daemons like it don't seem to mind that 
the operations failed, so what I want to do is to put in an dontaudit rule 
for all the relevant types to stop my logs being filled with such junk.

I am thinking of writing a script that will search for the types of the root 
directories of all mounted file systems and add them to a macro.  Then this 
macro can be used in squid.te etc for dontaudit rules.

What do you think?


Aug 19 12:57:05 lyta kernel: avc:  denied  { getattr } for  pid=26428 
exe=/usr/sbin/squid dev=01:00 ino=32 scontext=system_u:system_r:squid_t 
tcontext=system_u:object_r:unlabeled_t tclass=dir
Aug 19 12:57:05 lyta kernel: avc:  denied  { search } for  pid=26428 
exe=/usr/sbin/squid dev=01:00 ino=32 scontext=system_u:system_r:squid_t 
tcontext=system_u:object_r:unlabeled_t tclass=dir
Aug 19 12:57:05 lyta kernel: avc:  denied  { getattr } for  pid=26428 
exe=/usr/sbin/squid dev=03:08 ino=2 scontext=system_u:system_r:squid_t 
tcontext=system_u:object_r:var_t tclass=dir
Aug 19 12:57:05 lyta kernel: avc:  denied  { getattr } for  pid=26428 
exe=/usr/sbin/squid dev=03:06 ino=2 scontext=system_u:system_r:squid_t 
tcontext=system_u:object_r:src_t tclass=dir
Aug 19 12:57:05 lyta kernel: avc:  denied  { getattr } for  pid=26428 
exe=/usr/sbin/squid dev=00:07 ino=1 scontext=system_u:system_r:squid_t 
tcontext=system_u:object_r:usbdevfs_t tclass=dir
Aug 19 12:57:05 lyta kernel: avc:  denied  { getattr } for  pid=26428 
exe=/usr/sbin/squid dev=00:08 ino=1323 scontext=system_u:system_r:squid_t 
tcontext=system_u:object_r:autofs_t tclass=dir

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
