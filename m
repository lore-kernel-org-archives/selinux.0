Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i38DWURb017472
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 09:32:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i38DUUUZ013642
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:30:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i38DUTmT013639
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:30:30 GMT
Subject: Re: strange labeling problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1081376404.9215.13.camel@nexus.verbum.private>
References: <1081376404.9215.13.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1081431133.6379.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 09:32:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-04-07 at 18:20, Colin Walters wrote:
> Hi,
> 
> I encountered this issue earlier today.  It had me totally stumped:
> 
> root@optimus-prime:/home/walters$ ls -alZ /usr/libexec/gconfd-2
> -rwxr-xr-x+ root     root     system_u:object_r:gconfd_exec_t  /usr/libexec/gconfd-2
> walters@optimus-prime:~$ ls -alZ /usr/libexec/gconfd-2
> ls: /usr/libexec/gconfd-2: Permission denied
> audit(1081374706.094:0): avc:  denied  { getattr } for  pid=13695 exe=/bin/ls 
>   path=/usr/libexec/gconfd-2 dev=hda2 ino=683045 scontext=user_u:user_r:user_t 
>   tcontext=system_u:object_r:unlabeled_t tclass=file

This typically means that the type wasn't defined in the policy when the
inode was last brought in-core.  So ls -Z (or getfilecon or getfattr)
will continue to report the actual attribute value from the disk, but
SELinux is handling it as unlabeled_t since it had no definition for the
type when the inode was brought in-core.

> I had tried rerunning chcon -t gconfd_exec_t /usr/libexec/gconfd-2
> several times.  I verified that the stored xattr was correct; i.e. a
> getfattr -d -m . /usr/libexec/gconfd-2 showed gconfd_exec_t.

chcon likely never called setfilecon at all, since getfilecon would have
told it that the file already had the right context.  Try setfilecon
instead.  If it had called setfilecon -> setxattr, then SELinux would
have updated the inode SID accordingly.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
