Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA10486
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 11:23:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0QGNsI25032
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 16:23:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0QGNqf25028 for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 16:23:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: j.logsdon@lancaster.ac.uk, selinux@tycho.nsa.gov
Subject: Re: Getting closer all the time ...
Date: Sun, 26 Jan 2003 17:23:29 +0100
References: <Pine.LNX.4.10.10301261453530.8521-300000@mercury.quantex>
In-Reply-To: <Pine.LNX.4.10.10301261453530.8521-300000@mercury.quantex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301261723.29453.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 26 Jan 2003 16:50, j.logsdon@lancaster.ac.uk wrote:
> The symptoms are that on boot up and at various times during a shell,
> there are messages from the kernel thus:
>
> Jan 26 12:51:26 venus kernel: SELinux: initialized (dev 03:42, type
> reiserfs), uses PSIDs
> Jan 26 12:51:27 venus kernel: SELinux: initialized (dev 00:08, type
> tmpfs), uses transition SIDs

The above are normal boot messages.

> Jan 26 12:51:27 venus kernel: avc:  denied  { getattr } for  pid=136
> exe=/sbin/quotaon dev=16:41 ino=2 scontext=system_u:system_r:quota_t
> tcontext=system_u:object_r:file_t tclass=dir

The root directory (inode 2) of the file system on device 16:41 (goldstar 
CD-ROM) is mis-labelled as file_t.

> Jan 26 12:51:27 venus kernel: avc:  denied  { write } for  pid=138
> exe=/bin/rm path=/.autofsck dev=03:03 ino=3419
> scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:file_t
> tclass=file

The file /.autofsck on /dev/hda3 has got the wrong label.  But if you boot in 
permissive mode the first time then it should be gone.

> Jan 26 12:52:08 venus kernel: avc:  denied  { read } for  pid=849
> exe=/bin/bash path=/root dev=03:03 ino=21 scontext=root:user_r:user_t
> context=system_u:object_r:sysadm_home_dir_t tclass=dir

You are logging in as root with user_r role, as the root home directory is 
labelled for sysadm_t domain access only you get access denied.  This is 
desired behaviour.  Use "newrole -r sysadm_r" to get full access (or if 
logging in on the console select the sysadm_r:sysadm_t context).

> Jan 26 12:52:26 venus kernel: avc:  denied  { search } for  pid=897
> exe=/usr/X11R6/bin/xauth path=/root dev=03:03 ino=21
> scontext=root:user_r:user_xauth_t
> tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir

Same as above.  I guess you are doing a "ssh -X" login.  ssh is not permitted 
to start administrative shells due to the history of ssh...

> but when I try and start X the system hangs after giving the last few
> messages above and I have to resort to the hard reboot - blessing reiserfs
> at the same time!

Firstly you shouldn't be running X as root, with or without SE Linux.

Run X as a non-root account and it'll work.  If you relabel the root home 
directory to user_home_dir_t it'll work (but that is a really bad idea).  If 
you start X as sysadm_r:sysadm_t then it'll work (don't do that).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
