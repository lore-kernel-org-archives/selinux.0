Subject: Re: Proposed policy feature: $1_domain attribute
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
In-Reply-To: <20050301151205.GC5243@thorium.jmh.mhn.de>
References: <1109685518.764.9.camel@cobra.ivg2.net>
	 <20050301151205.GC5243@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 10:14:47 -0500
Message-Id: <1109690087.10589.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 16:12 +0100, Thomas Bleher wrote:
> I'd be more OK with
>  can_ps($1_t, $1_domain)
>  allow $1_t $1_domain:process signal;
> because the signal permission is very inconsistently used right now and
> is sometimes needed to kill misbehaving programs.

Even can_ps() is risky, as it exposes much of the /proc/pid state to
reading; to do that safely, we'd need to introduce finer-grained typing
of /proc/pid files (e.g. a derived type for different files
within /proc/pid).  And allowing the caller to kill the program at any
arbitrary point is potentially dangerous, e.g. leading to file
corruption or holding of a lock indefinitely.  Admittedly, signal
permission does not convey the ability to send SIGKILL or SIGSTOP, but
other signals may be sufficient to do harm (if the program isn't
explicitly handling them).
 
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
