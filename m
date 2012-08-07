Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q77MO0k7013817
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2012 18:24:00 -0400
Received: by ggmb6 with SMTP id b6so155162ggm.12
        for <selinux@tycho.nsa.gov>; Tue, 07 Aug 2012 15:23:59 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: John Stultz <john.stultz@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov
Subject: Re: NULL pointer dereference in selinux_ip_postroute_compat
Date: Tue, 07 Aug 2012 18:23:55 -0400
Message-ID: <1641293.WO3hAXq7Ps@sifl>
In-Reply-To: <20120807221731.GA25441@mail.hallyn.com>
References: <50215A7E.8000701@linaro.org> <CAHC9VhTd-d9NgWoU6_o9qw0bq4ZbuTEj8E_jRYyDXPWQaLLdog@mail.gmail.com> <20120807221731.GA25441@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, August 07, 2012 10:17:32 PM Serge E. Hallyn wrote:
> Quoting Paul Moore (paul@paul-moore.com):
> > On Tue, Aug 7, 2012 at 5:58 PM, John Stultz <john.stultz@linaro.org> 
wrote:
> > > On 08/07/2012 02:50 PM, Paul Moore wrote:
> > >> On Tue, Aug 7, 2012 at 2:12 PM, John Stultz <john.stultz@linaro.org>
> > >> 
> > >> wrote:
> > >>> Hi,
> > >>> 
> > >>>      With my kvm environment using 3.6-rc1+, I'm seeing NULL pointer
> > >>> 
> > >>> dereferences in selinux_ip_postroute_compat(). It looks like the sksec
> > >>> value
> > >>> 
> > >>> is null and we die in the following line:
> > >>>      if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
> > >>> 
> > >>> This triggers every time I shutdown the machine, but has also
> > >>> triggered
> > >>> randomly after a few hours.
> > >>> 
> > >>> This is on an ubuntu 12.04 image, not using selinux.
> > >> 
> > >> NOTE: Adding the SELinux list to the CC line
> > > 
> > > Thanks!
> > > 
> > >> Hi,
> > >> 
> > >> I'm trying to understand this and I was hoping you could you clarify a
> > >> few things for me:
> > >> 
> > >> * Is the panic in the Ubuntu 12.04 guest, or the host?  If the host,
> > >> could you share what distribution you are using?
> > > 
> > > Sorry, its a 12.04 guest.  I think the host is Ubuntu 12.04 as well.
> > > 
> > >> * When you say you are not using SELinux, could you be more specific?
> > >> It seems odd that you are not using SELinux but the panic is happening
> > >> in a SELinux hook.
> > > 
> > > I just mean that, being Ubuntu,  the system (userland) isn't configured
> > > to
> > > use selinux.  SELinux is just enabled in the kernel config.
> > 
> > Thanks for the quick response, I'll setup an Ubuntu guest and see if I
> > can reproduce this ... something is odd.  Anything non-standard about
> > your guest install or anything else you think might be helpful?
> 
> The problem seems to be that selinux_nf_ip_init() was called, which
> registers the selinux_ipv4_ops (and ipv6).  Those should not get registered
> if selinux ends up not being loaded (as in, if apparmor is loaded first),
> since as you've found here the selinux lsm hooks won't be called to set
> call selinux_sk_alloc_security().
> 
> I assume what's happening is that CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE
> was set to 1, but selinux ended up being set to disabled after the
> __initcall(selinux_nf_ip_init) ran?  Weird.

Yeah, nothing obvious is jumping out at me in the code except for some weird 
race condition like you mention above.  I'm downloading an Ubuntu ISO right 
now, it should be ready to play with tomorrow morning.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
