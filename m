Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4G0lRwD028183
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 20:47:27 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4G0lQRV007038
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2011 00:47:26 GMT
Received: by iwn38 with SMTP id 38so4362080iwn.12
        for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 17:47:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DCFF2FD.6060704@gmail.com>
References: <BANLkTim-1VFJHg1BdSjbWH-6RrfMHVBx3A@mail.gmail.com>
	<4DCFF2FD.6060704@gmail.com>
Date: Sun, 15 May 2011 17:47:25 -0700
Message-ID: <BANLkTinbr02afo-ZdJy4GfCGXV_ZC0tv9w@mail.gmail.com>
Subject: Re: FUSE and SELinux labeling
From: Sam Gandhi <samgandhi9@gmail.com>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Dominick,


On Sun, May 15, 2011 at 8:36 AM, Dominick Grift <domg472@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/15/2011 04:40 PM, Sam Gandhi wrote:
>> Hi
>>
>>
>> Is there a FAQ or some description on what one needs to do to enable
>> labeling on files created under a fuse filesystem?
>
> fusefs does not support extended attributes, and so you cannot label
> files on it.
>
> You can however, probably, mount fusefs filesystems with a security context.
>
> See man mount for information as to how to mount partitions with a
> security context (context="security context here")

I am running latest fuse 2.8.5 and I have tried several options of
using context=..
I haven't been successful in mounting file system with label that I
know exists. Have been successful in doing so?

I have tried using hello program from fuse example to mount directory
as shown below:

hello -o context=user_u:object_r:tmpfs_t /mn/tmp/
and that doesn't work.

Only option fuse mount seems to support are:

    -d   -o debug          enable debug output (implies -f)
    -f                     foreground operation
    -s                     disable multi-threaded operation

    -o allow_other         allow access to other users
    -o allow_root          allow access to root
    -o nonempty            allow mounts over non-empty file/dir
    -o default_permissions enable permission checking by kernel
    -o fsname=NAME         set filesystem name
    -o subtype=NAME        set filesystem type
    -o large_read          issue large read requests (2.4 only)
    -o max_read=N          set maximum size of read requests

    -o hard_remove         immediate removal (don't hide files)
    -o use_ino             let filesystem set inode numbers
    -o readdir_ino         try to fill in d_ino in readdir
    -o direct_io           use direct I/O
    -o kernel_cache        cache files in kernel
    -o [no]auto_cache      enable caching based on modification times (off)
    -o umask=M             set file permissions (octal)
    -o uid=N               set file owner
    -o gid=N               set file group
    -o entry_timeout=T     cache timeout for names (1.0s)
    -o negative_timeout=T  cache timeout for deleted names (0.0s)
    -o attr_timeout=T      cache timeout for attributes (1.0s)
    -o ac_attr_timeout=T   auto cache timeout for attributes (attr_timeout)
    -o intr                allow requests to be interrupted
    -o intr_signal=NUM     signal to send on interrupt (10)
    -o modules=M1[:M2...]  names of modules to push onto filesystem stack

    -o max_write=N         set maximum size of write requests
    -o max_readahead=N     set maximum readahead
    -o async_read          perform reads asynchronously (default)
    -o sync_read           perform reads synchronously
    -o atomic_o_trunc      enable atomic open+truncate support
    -o big_writes          enable larger than 4kB writes
    -o no_remote_lock      disable remote file locking


-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
