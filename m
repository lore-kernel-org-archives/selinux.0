Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA20965
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 07:49:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA13029
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 11:48:11 GMT
Received: from mail.ispko.com ([210.16.10.89])
        by jazzband.ncsc.mil  with ESMTP id LAA13025 for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 11:48:10 GMT
Message-ID: <3D1312C0.6060602@evoworks.evoserve.com>
Date: Fri, 21 Jun 2002 19:49:20 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>
CC: selinux@tycho.nsa.gov
Subject: Re: selinux cramfs
References: <20020621044822.DF718814D1@coffeesaur2.evoserve.com> <20020621110031.9420219B5@lyta.coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Fri, 21 Jun 2002 06:48, Debian User wrote:
>
>>how do we make selinux work on cramfs?
>>
>
>To have full support for a file system (as with Ext2, Ext3, and ReiserFS) you 
>need to have persistant Inode numbers, and the Inode numbers need to be known 
>by the kernel (or setfiles) some time after the files were created.
>
>This is not possible on cramfs.
>
Hmm this might explain why everything has the unlabeled context when I 
run my system.

>
>
>The solution for a cramfs initrd is to have CONFIG_SECURITY_SELINUX_DEVELOP=y 
>in your kernel config and then use avc_toggle to enable enforcing mode in 
>your init scripts.  Then you get some avc errors at boot up from your cramfs 
>but it's not a big deal.
>
>Another option is to use ext2 for an initrd.
>
>A final option is to compile your kernel such that an initrd is not needed, 
>but that is not possible for a cryptoapi root file system...
>
Im using cramfs for a read only root filesystem.
How does selinux do the labeling then? Is it just an integer associated 
with inodes? Maybe I have to read the white papers all over again.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
