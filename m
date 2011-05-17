Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4H72MAL015085
	for <selinux@tycho.nsa.gov>; Tue, 17 May 2011 03:02:22 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4H72LBW024823
	for <selinux@tycho.nsa.gov>; Tue, 17 May 2011 07:02:21 GMT
Message-ID: <4DD21D68.8080700@redhat.com>
Date: Tue, 17 May 2011 09:02:00 +0200
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sam Gandhi <samgandhi9@gmail.com>
CC: Dominick Grift <domg472@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: FUSE and SELinux labeling
References: <BANLkTim-1VFJHg1BdSjbWH-6RrfMHVBx3A@mail.gmail.com>	<4DCFF2FD.6060704@gmail.com> <BANLkTinbr02afo-ZdJy4GfCGXV_ZC0tv9w@mail.gmail.com>
In-Reply-To: <BANLkTinbr02afo-ZdJy4GfCGXV_ZC0tv9w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/16/2011 02:47 AM, Sam Gandhi wrote:
> Hello Dominick,
> 
> 
> On Sun, May 15, 2011 at 8:36 AM, Dominick Grift <domg472@gmail.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 05/15/2011 04:40 PM, Sam Gandhi wrote:
>>> Hi
>>>
>>>
>>> Is there a FAQ or some description on what one needs to do to enable
>>> labeling on files created under a fuse filesystem?
>>
>> fusefs does not support extended attributes, and so you cannot label
>> files on it.
>>
>> You can however, probably, mount fusefs filesystems with a security context.
>>
>> See man mount for information as to how to mount partitions with a
>> security context (context="security context here")
> 
> I am running latest fuse 2.8.5 and I have tried several options of
> using context=..
> I haven't been successful in mounting file system with label that I
> know exists. Have been successful in doing so?
> 
> I have tried using hello program from fuse example to mount directory
> as shown below:
> 
> hello -o context=user_u:object_r:tmpfs_t /mn/tmp/
> and that doesn't work.
> 
> Only option fuse mount seems to support are:
> 
>     -d   -o debug          enable debug output (implies -f)
>     -f                     foreground operation
>     -s                     disable multi-threaded operation
> 
>     -o allow_other         allow access to other users
>     -o allow_root          allow access to root
>     -o nonempty            allow mounts over non-empty file/dir
>     -o default_permissions enable permission checking by kernel
>     -o fsname=NAME         set filesystem name
>     -o subtype=NAME        set filesystem type
>     -o large_read          issue large read requests (2.4 only)
>     -o max_read=N          set maximum size of read requests
> 
>     -o hard_remove         immediate removal (don't hide files)
>     -o use_ino             let filesystem set inode numbers
>     -o readdir_ino         try to fill in d_ino in readdir
>     -o direct_io           use direct I/O
>     -o kernel_cache        cache files in kernel
>     -o [no]auto_cache      enable caching based on modification times (off)
>     -o umask=M             set file permissions (octal)
>     -o uid=N               set file owner
>     -o gid=N               set file group
>     -o entry_timeout=T     cache timeout for names (1.0s)
>     -o negative_timeout=T  cache timeout for deleted names (0.0s)
>     -o attr_timeout=T      cache timeout for attributes (1.0s)
>     -o ac_attr_timeout=T   auto cache timeout for attributes (attr_timeout)
>     -o intr                allow requests to be interrupted
>     -o intr_signal=NUM     signal to send on interrupt (10)
>     -o modules=M1[:M2...]  names of modules to push onto filesystem stack
> 
>     -o max_write=N         set maximum size of write requests
>     -o max_readahead=N     set maximum readahead
>     -o async_read          perform reads asynchronously (default)
>     -o sync_read           perform reads synchronously
>     -o atomic_o_trunc      enable atomic open+truncate support
>     -o big_writes          enable larger than 4kB writes
>     -o no_remote_lock      disable remote file locking
> 
> 
> -Sam
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


You probably just need to add the allow rules using audit2allow -M myfuse

What domain are you trying to allow access to fuse?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3SHWgACgkQrlYvE4MpobM/HwCgyWyT7ut5CLTnrzImIYfIu5vN
IhsAoOXUyEn3uC1jNKPixRqnE50goEtw
=yMrK
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
