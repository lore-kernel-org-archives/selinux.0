Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQ0ZKRb017271
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 19:35:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAQ0Ykp5012789
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 00:34:46 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAQ0Yit0012780
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 00:34:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio=20Monteiro?= <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: genfs_contexts file
Date: Wed, 26 Nov 2003 11:35:09 +1100
References: <3FC3CE10.8020307@ipen.br>
In-Reply-To: <3FC3CE10.8020307@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311261135.09128.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Nov 2003 08:48, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
> I have a doubt about *genfs_contexts* file. For example, the statement
> below:
>
> *genfscon vfat /                system_u:object_r:dosfs_t*
>
> I mounted the windows filesystem with: *mount -t vfat /dev/hda1 /mnt/win*
> I access with: *cd /mnt/win* and run *ls --context*
> The print out of the *ls --context* is:
> *-rwxr--r--  root     root     (null)                           130700.htm

Files/directories that are assigned contexts with genfscon do not have an 
xattr, so "ls --context" can not show their context.

This is a known issue.  I don't know if there are plans to change it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
