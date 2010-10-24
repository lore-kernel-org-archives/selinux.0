Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9PCfMj2024789
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 08:41:23 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9ONe1We023970
	for <selinux@tycho.nsa.gov>; Sun, 24 Oct 2010 23:40:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: Re: [refpolicy] load_policy() with upstart on mint 9 fluxbox
Date: Mon, 25 Oct 2010 10:39:58 +1100
Cc: Shaz <shazalive@gmail.com>, "Justin P. Mattock" <justinmattock@gmail.com>
References: <4CBE21ED.4050706@gmail.com> <4CC042CD.4000501@gmail.com> <AANLkTinSFCbxNP9Ps=0rMsgR5idqvdyJ1t_pVUVG5N00@mail.gmail.com>
In-Reply-To: <AANLkTinSFCbxNP9Ps=0rMsgR5idqvdyJ1t_pVUVG5N00@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201010251039.58440.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Oct 2010, Shaz <shazalive@gmail.com> wrote:
> Why do you expect Upstart or init to know if initrd was used or not? Is
> this a feature that upstart should handle? I guess not because initrd is
> used for early drivers and configuration before the rootfs can be utilized
> properly.

/sbin/init can easily determine whether policy was already loaded, whether an 
initrd/initramfs was used isn't the relevant issue.

It's easy to load policy from /sbin/init, and as Systemd will have to have SE 
Linux support (it can't do any of it's advanced features without it) it 
wouldn't make sense to have anything other than /sbin/init load policy on a 
Systemd system.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
