Subject: Re: Re: Genfscon and cramfs issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: k.tymur@samsung.com
Cc: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
In-Reply-To: <32740110.270851224113217282.JavaMail.weblogic@epml11>
References: <32740110.270851224113217282.JavaMail.weblogic@epml11>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 08:50:04 -0400
Message-Id: <1224161404.9247.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-10-15 at 23:26 +0000, korkishko Tymur wrote:
> According to my understanding, on the step of creating cramfs image, all files that will go into that image are analyzed by mkcramfs software. 
> If identical files are found, only single copy of the file is
> compressed and preserved in the image.

I suspect that mkcramfs is responsible for creating the two links as
hard links to the same inode when it creates the image.  So I would
suggest looking into mkcramfs and see if you can modify it or invoke it
with options to not hard link the files you want to keep separate.

>  Filesystem entry point (inode) on cramfs image has information about
> path names of the same files. I suspect that cramfs implementation in
> kernel dynamically searches for file names and provides them from the
> single inode.
> 
> If I type ls -i command in Linux (to list inodes for files) for cramfs filesystem that contains identical files file_one and file_two located in different directories (dir_one and dir_two) I will get output like that:
> #ls -li dir_one
> 756 -r--r--r-- 1 user user 1234 date time file_one
> #ls -li dir_two
> 756 -r--r--r-- 1 user user 1234 date time file_two
> So, inode number is the same for the two files. Same is applied to the case if two files are within the same directory.
> 
> Tymur Korkishko
> Samsung Electronics

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
