Date: Wed, 23 Jan 2002 10:14:26 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: forrest whitcher <fw@fwsystems.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: switching between SE Linux utils - kernel versions ? ... also
 ntp
In-Reply-To: <20020123100507.5af64cc5.fw@fwsystems.com>
Message-ID: <Pine.GSO.4.33.0201231006570.12859-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 23 Jan 2002, forrest whitcher wrote:

> That's not it. Ntpd was startd from the commandline -
> sysadm_r:sysadm_t role/domain

sysadm_t is likewise a domain that has many permissions, so it isn't
surprising that you aren't encountering denials.  You need to put ntpd
into its own domain.

> Syslog messages indicate that ntpd is choosing kernel/pll (I have systems on which
> ntpd uses tickadj() is the pll a kernel function that's not hooked?
>
>  hermes ntpd[3099]: using kernel phase-lock loop 0041

I'm not sure what you mean.  I would expect that ntpd would use
adjtimex().  That call, like other time-related calls, requires the
CAP_SYS_TIME capability to modify the time.  LSM hooks capable, and
SELinux performs a parallel permission check for each Linux capability.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
