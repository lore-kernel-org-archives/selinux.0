Date: Wed, 23 Jan 2002 10:05:07 -0500
From: forrest whitcher <fw@fwsystems.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: <SELinux@tycho.nsa.gov>
Subject: Re: switching between SE Linux utils - kernel versions ? ... also ntp
Message-Id: <20020123100507.5af64cc5.fw@fwsystems.com>
In-Reply-To: <Pine.GSO.4.33.0201230857580.12859-100000@raven>
References: <20020122171507.060a9821.fw@fwsystems.com>
	<Pine.GSO.4.33.0201230857580.12859-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 Jan 2002 09:24:39 -0500 (EST)
Stephen Smalley <sds@tislabs.com> wrote:

> 
> On Tue, 22 Jan 2002, forrest whitcher wrote:
> 
> > A note on NTP: ntpd / ntpdate on my selinux installation has (surprsingly) not
> > raised any AVC: messages in develop/permissive mode. Does this suggest that
> > setting system time is not LSM / SEL hooked?
> 
> No, it just means that ntpd is still running in the initrc_t domain.  You
> need to define a domain for it if you want to run it safely.
> 

That's not it. Ntpd was startd from the commandline - sysadm_r:sysadm_t role/domain

Syslog messages indicate that ntpd is choosing kernel/pll (I have systems on which
ntpd uses tickadj() is the pll a kernel function that's not hooked?

 hermes ntpd[3099]: using kernel phase-lock loop 0041

> > I'll be updating to 2.4.17 shortly, wondered what is the safe matrix for
> > mixing versions?
> >
> > If I need to still sometimes boot the .12 kernel will it be able to deal
> > with PSID's left by .17? and are the .17 version utils likely to cause
> > problems on .12 kernel?
> 
> The on-disk persistent label mapping format hasn't changed, so that isn't
> an issue.  However, the on-disk policydb format has changed, so the 2.4.12
> kernel won't be able to use the same policy, and some of the new system
> calls have undergone changes, so the newer utilities will not work on the
> 2.4.12 kernel.  So you can't easily swap back and forth.  Also, when you
> perform the build and install of the .17 release, remove
> /usr/local/selinux/bin from your path to avoid trying to use the modified
> utilities during the install.

Thanks, that's useful to know.

forrest

> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
