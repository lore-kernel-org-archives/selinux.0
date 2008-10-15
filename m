Date: Wed, 15 Oct 2008 22:58:49 +0000 (GMT)
From: korkishko Tymur <k.tymur@samsung.com>
Subject: Re: Re: Genfscon and cramfs issue
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Reply-to: k.tymur@samsung.com
Message-id: <32447155.268781224111529824.JavaMail.weblogic@epml11>
MIME-version: 1.0
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Two files might belong do different applications with different security context. 

In my opinion, it is hard to guarantee to have cramfs filesystem free from identical files:
- we can do a check for same files on cramfs image making stage (there might be more than 2 same files);
- same files should become diferent by adding some data into them;
- applications that use those files should be modified to deal with added data (that is not always possible).

Tymur Korkishko
Samsung Electronics

------- Original Message -------
Sender : Stephen Smalley<sds@tycho.nsa.gov>
Date   : Oct 15, 2008 21:49 (GMT+09:00)
Title  : Re: Genfscon and cramfs issue

On Wed, 2008-10-15 at 01:50 +0000, korkishko Tymur wrote:
> I have discovered an issue with using genfscon for labeling cramfs filesystem.
> 
> I have Linux kernel 2.6.26 with a patch from NSA that allows genfscon support of security contexts for directories/files (others than/ ). 
> I use genfscon to label files/directories on cramfsfilesystem(read-only filesystem) that does not support xattr.  
> 
> Cramfs filesystem has following behavior: for two files with different names but with the same file content it assigns single inode.  
> Example:
> genfscon cramfs /usr/file_one       user_u:system_r:file_one_t
> genfscon cramfs /usr/file_two       user_u:system_r:file_two_t 
> 
> file-one and file-two have the same content (e.g. Hello world).
> file-one and file-two share the same inode on cramfs. 
> 
> As a result, two files might have the _same_ security context  - either ...:file_one_t or ...:file_two_t.
> If file  /usr/file_one is accessed first, user_u:system_r:file_one_t is used for both files.
> If file  /usr/file_two is accessed first, user_u:system_r:file_two_t is used for both files. 
> 
> Any ideas how to fix/deal with that issue are welcomed. 

Why use two different security context for files that have the same
content?

-- 
Stephen Smalley
National Security Agency


 
 
 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
