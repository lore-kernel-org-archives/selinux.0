Subject: Re: SELinux Policy Editor and CAP_SYS_BOOT
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick <nick-lists@austin.rr.com>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1105649868.32758.58.camel@hawaii.efficax.net>
References: <1105645034.32758.35.camel@hawaii.efficax.net>
	 <1105645883.24406.147.camel@moss-spartans.epoch.ncsc.mil>
	 <1105649868.32758.58.camel@hawaii.efficax.net>
Content-Type: text/plain
Message-Id: <1105650339.24406.173.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 16:05:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-13 at 15:57, Nick wrote:
> Console helper is new to me, but it sounds like it might perform the
> same function

No, I don't think it matches your goals based on your description, as it
is strictly focused on allowing console users to run system programs,
not remote shutdown.

> No, I don't think it is SELinux related per se, I was thinking that
> perhaps this had been addressed as part of SELinux since the
> capabilities are a security oriented feature that allow root accesses to
> ordinary users. It would be a good idea to wrap this in some sort of
> protection. I am not sure how widely used this is. If you do a man on
> "capabilities" you will find some info, but not really enough to get you
> going. There are a couple instructions which form a sort of API, but
> that is it. Apparently LinSec makes use of it.

At present, you have to pass both sets of checks, the ordinary Linux
capability check (which is presently tied to uid 0 in the absence of
filesystem capabilities) and the SELinux capability permission check. 
In order to safely drop the ordinary Linux capability check and use
SELinux to completely manage capabilities (based on roles and domains),
we would need to tighten the security policy further, going beyond even
what is in the strict policy today, and we would need to make sure that
all application assumptions about uid 0 have been replaced with
appropriate SELinux checks.  That may happen someday (and some people
are already experimenting with it on the outside), but we didn't want to
rush into it, as it can easily lead to a vulnerability.  Other systems
that have completely overridden the ordinary Linux check with their own
logic have been known to be vulnerable in the past.

> The problem with posting things to the fedora list is most users there
> are still trying to get their CD to work or solve a video card problem.
> The volume of traffic is so high that that you lose any response to a
> message within a day without a search. Since the level of competency is
> so much higher here, I think that security related issues, particularly
> the ones we would like to see addressed by SELinux would be appropriate
> to the list.

There is a fedora-selinux-list, which is focused on the Fedora SELinux
integration.  Not to chase you off to it, but it may be helpful.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
