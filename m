Subject: Unionfs and Selinux
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Stephen Smalley <sds@epoch.ncsc.mil>, nsa <SELinux@tycho.nsa.gov>,
   Erez Zadok <ezk@cs.sunysb.edu>, Unionfs <unionfs@filesystems.org>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 15:07:40 +0530
Message-Id: <1105522661.6597.14.camel@jsingh>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am facing some problem using unionfs with selinux. Unionfs is
available for linux from ftp://ftp.fsl.cs.sunysb.edu/pub/unionfs/

Unionfs redirects the listxattr /getxattr calls to underlying branches
(of filesystems).

It works somewhat like this -

mount -t unionfs -o dirs=/a=rw:/b=ro none /n

ls -Z /a /b .. displays correct security contexts but ls -Z on the mount
point /n .. displays none. Although the mount point /n has security
context.

When I mentioned the following entry in fs_use.
fs_use_xattr unionfs system_u:object_r:fs_t;

It said :- mount: Operation not supported ,and audit says -
SELinux: (dev unionfs, type unionfs) has no xattr support

But IHMO it implements .. listxattr and getxattrs ... correctly.

A quick strace on mount .. showed that the kernel returned -EOPNOTSUPP

any clues ???

Regards,
Jaspreet

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
