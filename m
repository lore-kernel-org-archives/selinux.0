Subject: Re: Genfscon and cramfs issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: k.tymur@samsung.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1224074989.15903.11.camel@moss-spartans.epoch.ncsc.mil>
References: <26901264.215431224035436346.JavaMail.weblogic@epml03>
	 <1224074989.15903.11.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 08:58:50 -0400
Message-Id: <1224075530.15903.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
program that creates the cramfs image originally or the kernel's cramfs
filesystem implementation itself?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
