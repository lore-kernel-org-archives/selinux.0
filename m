Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7LGgfCU031418
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 12:42:41 -0400
Received: from mail-fe.doubletake.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7LGg7eR014655
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 16:42:07 GMT
Message-ID: <4A8ECDBC.9060304@doubletake.com>
Date: Fri, 21 Aug 2009 12:39:24 -0400
From: Dan Teitsort <dteitsort@doubletake.com>
Reply-To: dteitsort@doubletake.com
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: xattr support for filesystem not in policy
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have developed a filesystem called DTFS that overlays a "regular" 
file system such as ext3. DTFS is a component of our data replication
product, Double-Take for Linux.

DTFS supports xattrs when the underlying regular filesystem supports
them. For our product to be used in an SELinux environment and fully
support xattrs, users must customize their SELinux policy to indicate
DTFS supports xattrs. We would like to find a less-invasive solution.

Searching this list's archive and the selinuxproject.org pages, I see
this sort of problem has come up before and a patch was in the works
that would have the kernel "check if the filesystem supports security
xattrs and if so will use those if there is no fs_use_* rule in
policy.". The latest info I see on this patch is that it was found to
cause deadlocks on ntfs-3g.

I'm wondering if anyone has done further development on this patch, or
sees another approach worth pursing.

I'm also wondering if we've overlooked a less-invasive work around, one
that would not require policy customization or require the development
of an SELinux/kernel patch.

I found the patch discussed at:
http://www.nsa.gov/research/selinux/list-archive/0806/thread_body30.shtml#26513.
I've appended a relevant excerpt below.


Thanks,

Dan Teitsort
Software Engineer
Double-Take Software, Inc.
www.doubletake.com




> From: Eric Paris <eparis_at_redhat.com> subject: Re: [PATCH-v3]
> SELinux: allow fstype unknown to policy to use xattrs if present 
> Date: Fri, 11 Jul 2008 13:13:56 -0400
> 
> •         In reply to: James Morris: "Re: [PATCH-v3] SELinux: allow
fstype unknown to policy to use xattrs if present"
> 
> On Thu, 2008-06-19 at 09:11 +1000, James Morris wrote: (> On Wed, 18 
> Jun 2008, Eric Paris wrote:
>> 
>>> Currently if a FS is mounted for which SELinux policy does not 
>>> define an fs_use_* that FS will either be genfs labeled or not
>>> labeled at all. This decision is based on the existence of a
>>> genfscon rule in policy and is irrespective of the capabilities
>>> of the filesystem itself. This patch allows the kernel to check
>>> if the filesystem supports security xattrs and if so will use
>>> those if there is no
fs_use_* rule in policy.
>>> An fstype with a no fs_use_* rule but with a genfs rule will use 
>>> xattrs if available and will follow the genfs rule. This can be
>>> particularly interesting for things like ecryptfs which actually
>>> overlays a real underlying FS. If we define excryptfs in policy
>>> to use xattrs we will likely get this wrong at times, so with
>>> this path we just don't need to define it! Overlay ecryptfs on
>>> top of NFS with no xattr support: SELinux: initialized (dev
>>> ecryptfs, type ecryptfs), uses genfs_contexts Overlay ecryptfs on
>>> top of ext4 with xattr support: SELinux: initialized (dev
>>> ecryptfs, type ecryptfs), uses xattr It is also useful as the
>>> kernel adds new FS we don't need to add them in policy if they
>>> support xattrs and that is how we want to handle
them.
>>> Signed-off-by: Eric Paris <eparis@redhat.com>
>>> 
>>> Applied to for-akpm.
> Please drop this patch for now. It deadlocks on ntfs-3g. I need to 
> rework it to handle fuse filesystems better. (casey was right) -Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
