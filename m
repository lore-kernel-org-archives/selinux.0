From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "R N" <rnmj44@hotmail.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux and SystemImager
Date: Sat, 14 Feb 2004 05:57:38 +1100
References: <BAY9-F60HnYHraK2yR000043ec3@hotmail.com>
In-Reply-To: <BAY9-F60HnYHraK2yR000043ec3@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402140557.38126.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Feb 2004 03:49, "R N" <rnmj44@hotmail.com> wrote:
> Has anyone tried creating multiple SELinux systems using SystemImager (or
> Symantec Ghost and like). We have been using SystemImager successfully to
> clone Linux based system for our cluster. SystemImager is based on rsync.
> Now I tried to clone a SELinux system, the initial steps of grabbing the
> golden-client image at the server are successful and I could create a new
> client using the same image from the server. But when I try to reboot the
> new client, it gives all kinds of avc_denied errors. and doesn't boot.

It sounds like SI doesn't support xattr's.

The easy way of working around this is to create a floppy disk that boots a SE 
Linux kernel and initrd that can relabel the file system.  After doing the SI 
work you just boot from the custom floppy to label it correctly, then it 
should be fully functional.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
