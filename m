From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "R N" <rnmj44@hotmail.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux and SystemImager
Date: Sat, 14 Feb 2004 12:21:48 +1100
References: <BAY9-F378aZRhQdOgl400022bb7@hotmail.com>
In-Reply-To: <BAY9-F378aZRhQdOgl400022bb7@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402141221.48970.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Feb 2004 09:19, "R N" <rnmj44@hotmail.com> wrote:
> what do you mean by xattr's, could you please elaborate.
> As we understand the SI is just doing a copy (using rsync) of the files,
> and SE Linux uses inode info along with context of the files.

The context of each file is stored in it's security.selinux xattr.

> Once we have
> the SELinux copy we want to avoid the relabel after rebooting. If there is
> a way to relabel the copy thru SI or some other system command without the
> reboot??

Rebooting is necessary.  I suggest making a custom boot disk for relabeling to 
avoid booting in permissive mode for a relabel.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
