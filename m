Date: Wed, 23 Jan 2002 09:24:39 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: forrest whitcher <fw@fwsystems.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: switching between SE Linux utils - kernel versions ? ... also
 ntp
In-Reply-To: <20020122171507.060a9821.fw@fwsystems.com>
Message-ID: <Pine.GSO.4.33.0201230857580.12859-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 22 Jan 2002, forrest whitcher wrote:

> A note on NTP: ntpd / ntpdate on my selinux installation has (surprsingly) not
> raised any AVC: messages in develop/permissive mode. Does this suggest that
> setting system time is not LSM / SEL hooked?

No, it just means that ntpd is still running in the initrc_t domain.  You
need to define a domain for it if you want to run it safely.

> I'll be updating to 2.4.17 shortly, wondered what is the safe matrix for
> mixing versions?
>
> If I need to still sometimes boot the .12 kernel will it be able to deal
> with PSID's left by .17? and are the .17 version utils likely to cause
> problems on .12 kernel?

The on-disk persistent label mapping format hasn't changed, so that isn't
an issue.  However, the on-disk policydb format has changed, so the 2.4.12
kernel won't be able to use the same policy, and some of the new system
calls have undergone changes, so the newer utilities will not work on the
2.4.12 kernel.  So you can't easily swap back and forth.  Also, when you
perform the build and install of the .17 release, remove
/usr/local/selinux/bin from your path to avoid trying to use the modified
utilities during the install.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
