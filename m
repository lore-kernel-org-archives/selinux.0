Date: Thu, 16 Oct 2003 10:46:08 -0700
From: Michael Reilly <michaelr@cisco.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
Subject: Re: Yet another question - newrole and xterm's
Message-Id: <20031016104608.3730023e.michaelr@cisco.com>
In-Reply-To: <1066321310.25279.39.camel@moss-spartans.epoch.ncsc.mil>
References: <20031015191716.5478c74b.michaelr@cisco.com>
	<1066307222.24561.7.camel@moss-spartans.epoch.ncsc.mil>
	<200310170216.37933.russell@coker.com.au>
	<1066321310.25279.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Exactly - I am using Russells' policy with the OLD_SELINUX variable on a
2.4.21 kernel patched using the August (old API) release of SElinux.

On two of my machines I use reiserfs on all of my partitions except for
swap.  I use jfs on the other machine (except for swap).  I read that the
backport of the new API to 2.4 kernels does not have extended attributes for
reiserfs nor jfs.  Since it would be difficult to switch to ext3 I stick
with the old API until someone conforms that I can use the new API with my
filesystems and have everything work.  (more than you wanted to knwo, right?
:-)).

thanks,

michael
On 16 Oct 2003 12:21:50 -0400
Stephen Smalley <sds@epoch.ncsc.mil> wrote:

> On Thu, 2003-10-16 at 12:16, Russell Coker wrote:
> > Yes, the idea is that you can use the same policy on old or new SE
> > Linux.  If you use it on the old SE Linux then /proc is unavailable.  If
> > you use it on the new SE Linux then can_setexec() covers it.
> > 
> > Michael, are you running old or new SE Linux?
> 
> I understand now - he is using the old SELinux, based on his original
> posting to the selinux list (Slackware base with Russell's policy and
> the old 2.4-based SELinux from the August release).
> 
> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency


-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
