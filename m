Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CAqZIi014052
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 05:52:35 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CAoc8I005176
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 10:50:38 GMT
Date: Wed, 12 Jan 2005 11:03:03 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jaspreet Singh <jsingh@ensim.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, nsa <SELinux@tycho.nsa.gov>,
   Erez Zadok <ezk@cs.sunysb.edu>, Unionfs <unionfs@filesystems.org>
Subject: Re: Unionfs and Selinux
Message-ID: <20050112110303.GQ26175@lkcl.net>
References: <1105522661.6597.14.camel@jsingh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105522661.6597.14.camel@jsingh>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i came across the same problem when implementing xattrs in
fuse.

i have a vague recollection of using -o fscontext=somethingappropriate
in order to over-ride the problem, although this is not ideal.

also - you _are_ returning xattrs "immediately", aren't you?

i.e. you're not doing what fuse does which is to send a -512 error code
the name of which i forget but the effect of which is to tell the
kernel to "come back later", are you?

selinux on lookup of xattrs cannot cope if you tell it to
"come back later".

[the reason why fuse does that is to gain an opportunity to tell the
 userspace program to wake up, query it, receive results, and
 when the kernel does "come back later", fuse has the answer]

On Wed, Jan 12, 2005 at 03:07:40PM +0530, Jaspreet Singh wrote:
> Hi,
> 
> I am facing some problem using unionfs with selinux. Unionfs is
> available for linux from ftp://ftp.fsl.cs.sunysb.edu/pub/unionfs/
> 
> Unionfs redirects the listxattr /getxattr calls to underlying branches
> (of filesystems).
> 
> It works somewhat like this -
> 
> mount -t unionfs -o dirs=/a=rw:/b=ro none /n
> 
> ls -Z /a /b .. displays correct security contexts but ls -Z on the mount
> point /n .. displays none. Although the mount point /n has security
> context.
> 
> When I mentioned the following entry in fs_use.
> fs_use_xattr unionfs system_u:object_r:fs_t;
> 
> It said :- mount: Operation not supported ,and audit says -
> SELinux: (dev unionfs, type unionfs) has no xattr support
> 
> But IHMO it implements .. listxattr and getxattrs ... correctly.
> 
> A quick strace on mount .. showed that the kernel returned -EOPNOTSUPP
> 
> any clues ???
> 
> Regards,
> Jaspreet
> 
> -- 
> 
> 

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
