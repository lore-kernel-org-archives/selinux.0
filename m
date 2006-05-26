Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4QIux33028735
	for <selinux@tycho.nsa.gov>; Fri, 26 May 2006 14:56:59 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4QIuvGA000300
	for <selinux@tycho.nsa.gov>; Fri, 26 May 2006 18:56:58 GMT
Date: Fri, 26 May 2006 14:56:54 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC 0/4] NetLabel
In-Reply-To: <44772E19.5030907@hp.com>
Message-ID: <Pine.LNX.4.64.0605261455490.4386@d.namei>
References: <44760E29.4070407@hp.com> <Pine.LNX.4.64.0605251938360.27473@d.namei>
 <44771EFB.6030203@hp.com> <Pine.LNX.4.64.0605261156030.3103@d.namei>
 <44772E19.5030907@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 26 May 2006, Paul Moore wrote:

> The NetLabel netlink protocol does have a "version" message which can be
> used to get the version.  My main reason for doing this is not to signal
> changes to existing messages, i.e. break backward compatability, but to
> signal to user space applications that the kernel supports a newer protocol.
> 
> The printk() above is just informative, if that is your main concern I
> can yank it.

Yes, please do.  Linux kernel subsystems don't have versions, use the main 
kernel version if you need to.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
