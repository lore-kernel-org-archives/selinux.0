Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0CLpLRb015960
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2004 16:51:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0CLoDxr024638
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2004 21:50:14 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0CLoDYc024635
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2004 21:50:13 GMT
Subject: Re: compilation queries
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: "kamal.r nair" <kamalrnair@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040111142238.95679.qmail@web41902.mail.yahoo.com>
References: <20040111142238.95679.qmail@web41902.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1073944278.13016.327.camel@moss-huskies>
Mime-Version: 1.0
Date: 12 Jan 2004 16:51:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-01-11 at 09:22, kamal.r nair wrote:
> dear howard holm

While I try to be helpful, I'm just one person and there are a lot of
other people on this list that might be able to help you more quickly.

> i have got the subscription from selinux.
>  can u help me out in compiling the SELINUX 2.4.21source code into
> redhat 2.4 linux kernels.i did download the source from the
> website(www.nsa.gov/selinux) and copied into my linux system (/root)
> and started compiling using the normal kernel compilation steps.The
> compilation got over and the next time when i booted my system using
> the SELINUX kernel newly configured, the initial process got loaded
> and then followed by the error "no socket drivers loaded" and "cannot
> load root" and finally "kernel panic".

This sounds like you have kernel configuration issues. Was the ext3 file
system enabled?  In your grub or lilo configuration are you using
root=LABEL= or a more standard definition?  Have you tried compiling and
installing a kernel without SELinux?  If this is a 2.6 kernel, you might
want to get the 2.6 kernel working on the system before dealing with
SELinux.  You might want to look at
http://www.codemonkey.org.uk/docs/post-halloween-2.5.txt for information
about moving from a 2.4 to 2.6 kernel.  If you don't want to compile
your own kernel you might want to look at the kernels available at
http://people.redhat.com/arjanv/2.6/  You also didn't say if you were
using Fedora, Red Hat Linux, or something else as your base.  While that
shouldn't matter for the kernel, it may make a difference later when
trying to get the non-kernel parts of SELinux running correctly.

>  I kindly request you to give the compilation steps involved in the
> above process and the errors i have made while compiling the kernel.

Other than enabling SELinux in the configuration, compiling an SELinux
kernel should not be very different from compiling any other kernel.

>  expecting your reply at the earliest.
>  
> Regds
>  
> Kamal.R.Nair

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Office of Defensive Computing Research
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
