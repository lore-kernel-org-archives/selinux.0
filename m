Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21168
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 08:28:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA29535
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:27:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA29528
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:27:50 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Debian User <rogelio@evoworks.evoserve.com>
Subject: Re: selinux cramfs
Date: Fri, 21 Jun 2002 14:28:02 +0200
Cc: selinux@tycho.nsa.gov
References: <20020621044822.DF718814D1@coffeesaur2.evoserve.com> <20020621110031.9420219B5@lyta.coker.com.au> <3D1312C0.6060602@evoworks.evoserve.com>
In-Reply-To: <3D1312C0.6060602@evoworks.evoserve.com>
MIME-Version: 1.0
Message-Id: <20020621122802.D259312E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 Jun 2002 13:49, Debian User wrote:
> >A final option is to compile your kernel such that an initrd is not
> > needed, but that is not possible for a cryptoapi root file system...
>
> Im using cramfs for a read only root filesystem.
> How does selinux do the labeling then? Is it just an integer associated
> with inodes? Maybe I have to read the white papers all over again.

It basically ends up as an integer associated with each Inode.

SE Linux in it's current form can't work with a root file system such as 
cramfs or NFS.

You can use ext2 in a ram disk mounted read-only for a read-only root file 
system.  Or you could use Ext2 with compression patches and a read-only block 
device to get the same results as you seem to be aiming for (compression and 
impossibility of writing).

Of course if unix permissions and SE permissions both fail and someone gets 
access to /dev/kmem then nothing will save you...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
