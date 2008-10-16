Subject: Re: Re: Genfscon and cramfs issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: k.tymur@samsung.com
Cc: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
In-Reply-To: <1224161404.9247.2.camel@moss-spartans.epoch.ncsc.mil>
References: <32740110.270851224113217282.JavaMail.weblogic@epml11>
	 <1224161404.9247.2.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 13:18:24 -0400
Message-Id: <1224177504.9247.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-10-16 at 08:50 -0400, Stephen Smalley wrote:
> On Wed, 2008-10-15 at 23:26 +0000, korkishko Tymur wrote:
> > According to my understanding, on the step of creating cramfs image, all files that will go into that image are analyzed by mkcramfs software. 
> > If identical files are found, only single copy of the file is
> > compressed and preserved in the image.
> 
> I suspect that mkcramfs is responsible for creating the two links as
> hard links to the same inode when it creates the image.  So I would
> suggest looking into mkcramfs and see if you can modify it or invoke it
> with options to not hard link the files you want to keep separate.

I looked at the mkfs.cramfs.c source code in util-linux-ng
(disk-utils/mkfs.cramfs.c) and it has an eliminate_doubles() function
that scans for duplicate files and coalesces them to save space in the
image.  So you could change or skip that function to avoid coalescing
files that you need to keep separate.  It appears to entirely be a
userland issue for saving space in the image, not a kernel issue.

> >  Filesystem entry point (inode) on cramfs image has information about
> > path names of the same files. I suspect that cramfs implementation in
> > kernel dynamically searches for file names and provides them from the
> > single inode.
> > 
> > If I type ls -i command in Linux (to list inodes for files) for cramfs filesystem that contains identical files file_one and file_two located in different directories (dir_one and dir_two) I will get output like that:
> > #ls -li dir_one
> > 756 -r--r--r-- 1 user user 1234 date time file_one
> > #ls -li dir_two
> > 756 -r--r--r-- 1 user user 1234 date time file_two
> > So, inode number is the same for the two files. Same is applied to the case if two files are within the same directory.
> > 
> > Tymur Korkishko
> > Samsung Electronics
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
