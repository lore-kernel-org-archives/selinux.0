Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA22878
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 21:01:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0L21nI09602
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 02:01:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0L21mf09598 for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 02:01:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: forrest whitcher <fw@fwsystems.com>, selinux@tycho.nsa.gov
Subject: Re: selinux afs domain v 0.2
Date: Tue, 21 Jan 2003 03:01:38 +0100
Cc: openafs-info@openafs.org
References: <20030120200718.57f30b5f.fw@fwsystems.com>
In-Reply-To: <20030120200718.57f30b5f.fw@fwsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301210301.38254.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Jan 2003 02:07, forrest whitcher wrote:
> types/file.te:                              #afsd needs to write
> /usr/etc/openafs/AFSLog
>
> # usr_etc_log_t is created primarily for afsd which
> # wants to keep a log in /usr/etc/openafs
>
> type usr_etc_log_t, file_type, sysadmfile;

This is a really bad name.

Firstly your AFS package is broken.  It should not put logs under an "etc" 
directory, and even having /usr/etc is bad enough.  I suggest recompiling 
your AFS to put the logs in /var/log/afs* .

Then just do:
log_domain(afsd)

Also look at the rw_dir_create_file() macro and the use of { type types ... } 
for specifying the types of files and directories, using those methods you 
can significantly reduce the size of your policy file without changing the 
result.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
