Date: Wed, 15 Oct 2008 23:26:57 +0000 (GMT)
From: korkishko Tymur <k.tymur@samsung.com>
Subject: Re: Re: Genfscon and cramfs issue
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: korkishko Tymur <k.tymur@samsung.com>,
        "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Reply-to: k.tymur@samsung.com
Message-id: <32740110.270851224113217282.JavaMail.weblogic@epml11>
MIME-version: 1.0
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

According to my understanding, on the step of creating cramfs image, all files that will go into that image are analyzed by mkcramfs software. 
If identical files are found, only single copy of the file is compressed and preserved in the image. Filesystem entry point (inode) on cramfs image has information about path names of the same files. I suspect that cramfs implementation in kernel dynamically searches for file names and provides them from the single inode.

If I type ls -i command in Linux (to list inodes for files) for cramfs filesystem that contains identical files file_one and file_two located in different directories (dir_one and dir_two) I will get output like that:
#ls -li dir_one
756 -r--r--r-- 1 user user 1234 date time file_one
#ls -li dir_two
756 -r--r--r-- 1 user user 1234 date time file_two
So, inode number is the same for the two files. Same is applied to the case if two files are within the same directory.

Tymur Korkishko
Samsung Electronics
 
 

------- Original Message -------
Sender : Stephen Smalley<sds@tycho.nsa.gov>
Date   : Oct 15, 2008 21:58 (GMT+09:00)
Title  : Re: Genfscon and cramfs issue

On Wed, 2008-10-15 at 08:49 -0400, Stephen Smalley wrote:
> On Wed, 2008-10-15 at 01:50 +0000, korkishko Tymur wrote:
> > I have discovered an issue with using genfscon for labeling cramfs filesystem.
> > 
> > I have Linux kernel 2.6.26 with a patch from NSA that allows genfscon support of security contexts for directories/files (others than/ ). 
> > I use genfscon to label files/directories on cramfsfilesystem(read-only filesystem) that does not support xattr.  
> > 
> > Cramfs filesystem has following behavior: for two files with different names but with the same file content it assigns single inode.  
> > Example:
> > genfscon cramfs /usr/file_one       user_u:system_r:file_one_t
> > genfscon cramfs /usr/file_two       user_u:system_r:file_two_t 
> > 
> > file-one and file-two have the same content (e.g. Hello world).
> > file-one and file-two share the same inode on cramfs. 
> > 
> > As a result, two files might have the _same_ security context  - either ...:file_one_t or ...:file_two_t.
> > If file  /usr/file_one is accessed first, user_u:system_r:file_one_t is used for both files.
> > If file  /usr/file_two is accessed first, user_u:system_r:file_two_t is used for both files. 
> > 
> > Any ideas how to fix/deal with that issue are welcomed. 
> 
> Why use two different security context for files that have the same
> content?

Oh, and what is responsible for the aliasing of the files here - the
program that creates the cramfs image originally or the kernel&#39;s cramfs
filesystem implementation itself?

-- 
Stephen Smalley
National Security Agency


 
 
 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
