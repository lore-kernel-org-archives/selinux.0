Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7ND6YrT017800
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 09:06:34 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7ND5nAS028377
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 13:05:49 GMT
Subject: Re: Fedora and udev
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com, James Morris <jmorris@redhat.com>
In-Reply-To: <4128BBE6.6050207@tresys.com>
References: <200408222125.38169.russell@coker.com.au>
	 <20040822144016.GA13842@lkcl.net>  <4128BBE6.6050207@tresys.com>
Content-Type: text/plain
Message-Id: <1093266284.27211.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Aug 2004 09:04:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-08-22 at 11:29, Joshua Brindle wrote:
> When we were experimenting with udev it only took ramfs xattr support, 
> add ramfs to fs_use as an xattr filesystem and set up udev with selinux 
> support. When it runs it creates the nodes and then labels them via the 
> libselinux api which reads file_contexts. Aside from the problems I've 
> already mentioned there should be no problems running udev.
> 
> If the tmpfs context support is something different from this then it 
> should not be used (I have not looked at tmpfs support at all but have 
> personal experience that ramfs xattr works as expected).

tmpfs is preferable to ramfs, as tmpfs uses swap and honors resource
limits.  But separate tmpfs instances can be used for diverse purposes
by userspace (/tmp, /dev, /dev/shm) and a tmpfs instance is always used
internally by the kernel for shared memory, so we want to be able to
assign different filesystem security contexts to different tmpfs
instances.  That requires extending fscontext= support to it, so that we
can specify the context on a per-mount basis.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
