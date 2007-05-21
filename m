Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LHIJnc008039
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 13:18:19 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4LHII9R025188
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 17:18:18 GMT
Date: Mon, 21 May 2007 13:18:16 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
cc: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 4/4] selinux: add selinuxfs structure for object class
 discovery
In-Reply-To: <11797619233926-git-send-email-cpebenito@tresys.com>
Message-ID: <Line.LNX.4.64.0705211306480.17008@d.namei>
References: <11797619161088-git-send-email-cpebenito@tresys.com>
 <11797619172804-git-send-email-cpebenito@tresys.com>
 <1179761918482-git-send-email-cpebenito@tresys.com>
 <1179761920707-git-send-email-cpebenito@tresys.com>
 <11797619233926-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 May 2007, Christopher J. PeBenito wrote:

> From: Christopher J. PeBenito <cpebenito@tresys.com>
> 
> The structure is as follows (relative to selinuxfs root):
> 
> /class/file/index
> /class/file/perms/read
> /class/file/perms/write
> ...
> 
> Each class is allocated 33 inodes, 1 for the class index and 32 for
> permissions.  Relative to SEL_CLASS_INO_OFFSET, the inode of the index file
> DIV 33 is the class number.  The inode of the permission file % 33 is the
> index of the permission for that class.

Keep in mind that any of these may need to be 64-bit at some point, so be 
careful about hard-coding any 32-bit assumptions into the kernel/user API.


> +#define NVECTORS 32

Macro name is too generic.

> +#define DIV(a, b) ((a) / (b) - ((a) % (b) < 0))

Also too generic, and should be a static inline.

I think you should also make static inline wrappers:

sel_ino_to_class()
sel_ino_to_perm()

to make it all clearer to others.


> +		inode->i_ino = (classindex * (NVECTORS+1) + i + 1) | SEL_CLASS_INO_OFFSET;

> +	inode->i_ino = (index * (NVECTORS+1)) | SEL_CLASS_INO_OFFSET;

Add wrappers for these, too.

> +static void sel_remove_classes(void)
> +{
> +	struct list_head *class_node;
> +
> +	list_for_each(class_node, &class_dir->d_subdirs) {
> +		struct dentry *class_subdir = list_entry(class_node, struct dentry, d_u.d_child);
> +		struct list_head *class_subdir_node;

Coding style: max. 80 columns for body of function (similar issue 
elsewhere in the patches).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
