Subject: Re: FUSE and SELinux labeling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: Dominick Grift <domg472@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <BANLkTinbr02afo-ZdJy4GfCGXV_ZC0tv9w@mail.gmail.com>
References: <BANLkTim-1VFJHg1BdSjbWH-6RrfMHVBx3A@mail.gmail.com>
	 <4DCFF2FD.6060704@gmail.com>
	 <BANLkTinbr02afo-ZdJy4GfCGXV_ZC0tv9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 May 2011 09:12:33 -0400
Message-ID: <1305637953.6498.1.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2011-05-15 at 17:47 -0700, Sam Gandhi wrote:
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

If you run it under strace -s 1024, you can look at the mount system
call and see whether it passed the context= mount option to the kernel
or not.  I suspect that it didn't pass it along and that is why it
didn't work.  Is there a way to directly mount your fuse fs via the
regular mount command (ala ntfs-3g) so that mount options are preserved
properly?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
