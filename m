Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n023Mc3x004065
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2009 22:22:43 -0500
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n023JtiK020146
	for <selinux@tycho.nsa.gov>; Fri, 2 Jan 2009 03:20:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "xing li" <lixing.1006@gmail.com>
Subject: Re: Where can i find the source code of Userspace Packages with modifications for SELinux?
Date: Fri, 2 Jan 2009 14:22:21 +1100
Cc: selinux@tycho.nsa.gov
References: <707f057d0812270525t1f6fa095i9ace0cc6e4d3bd6e@mail.gmail.com> <5aebb9fb0812270551g49c21fdm9bc7dd156182cf53@mail.gmail.com> <707f057d0812282312r19e324a8y4ace684ed1646812@mail.gmail.com>
In-Reply-To: <707f057d0812282312r19e324a8y4ace684ed1646812@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901021422.22782.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 29 December 2008 18:12, "xing li" <lixing.1006@gmail.com> wrote:
> I have download the upstart source code from ubuntu
> http://packages.ubuntu.com/,  (hardy)
> but i have't found the selinux relevant code in it. I am so  confused that
> how the /sbin/init invoke
> the "load_policy" function during system initialization?

http://etbe.coker.com.au/2008/07/24/se-linux-policy-loading/

I have described all the issues at the above blog post.

Use SysVInit and the patch is there.  If you want to use Upstart then you 
could patch it yourself (it's just a matter of copying a couple of chunks of 
code from SysVInit).

Another option is to use the wrapper script hack that I used ages ago on 
Cobalt machines.  Just boot the kernel with init=/sbin/init-wrapper and then 
have /sbin/init-wrapper be a shell script like the following:
#!/bin/bash
/usr/sbin/load_policy
exec /sbin/init

Messing with the initrd is just a bad idea, such things are not going to 
happen in Debian.

In fact, why not just use Debian?  I think that overall the result you get 
will be a lot better if you use Debian instead of Ubuntu for running SE 
Linux.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
