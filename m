Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA20754
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 07:00:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA25830
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 11:00:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA25826
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 11:00:21 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Debian User <rogelio@evoworks.evoserve.com>, selinux@tycho.nsa.gov
Subject: Re: selinux cramfs
Date: Fri, 21 Jun 2002 13:00:31 +0200
References: <20020621044822.DF718814D1@coffeesaur2.evoserve.com>
In-Reply-To: <20020621044822.DF718814D1@coffeesaur2.evoserve.com>
MIME-Version: 1.0
Message-Id: <20020621110031.9420219B5@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 Jun 2002 06:48, Debian User wrote:
> how do we make selinux work on cramfs?

To have full support for a file system (as with Ext2, Ext3, and ReiserFS) you 
need to have persistant Inode numbers, and the Inode numbers need to be known 
by the kernel (or setfiles) some time after the files were created.

This is not possible on cramfs.

The solution for a cramfs initrd is to have CONFIG_SECURITY_SELINUX_DEVELOP=y 
in your kernel config and then use avc_toggle to enable enforcing mode in 
your init scripts.  Then you get some avc errors at boot up from your cramfs 
but it's not a big deal.

Another option is to use ext2 for an initrd.

A final option is to compile your kernel such that an initrd is not needed, 
but that is not possible for a cryptoapi root file system...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
