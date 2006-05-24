Subject: Re: Gentoo SELinux problem in enforcing mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
Cc: method@gentoo.org, selinux@tycho.nsa.gov
In-Reply-To: <4474A024.5010103@gmail.com>
References: <4474A024.5010103@gmail.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 14:33:09 -0400
Message-Id: <1148495589.24463.507.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 03:04 +0900, Tetsuji Maverick Rai wrote:
> I installed SELinux on one of my Gentoo box but it doesn't work in
> enforcing mode at all.   It looks like almost anything is denied even
> with the base policy as provided in Gentoo's package.  For example, if
> enforcing mode is enabled during an X Window session, all inputs from
> the mouse or keyboard is denied.   On commandline console,
> "ctrl+alt+del" gives "reboot not permitted"-like error...

That's a question for the Hardened Gentoo folks, assuming you are just
using their packages for SELinux and not trying to mix them with
upstream ones.  But last I looked, Hardened Gentoo was limited to server
systems, not desktops, so they omit the X-related policy and are also
strict policy-based rather than targeted policy-based.

> I have tried SELinux with old Redhat some years ago, and didn't find
> such a problem and now I feel this is very unusual.  What wrong do you
> think I am doing?   I have tried with generic 2.6.16.16, but now I'm
> installing 2.6.16-rc6 plus nsa's patch at
> http://www.nsa.gov/selinux/code/download5.cfm (but other file, policy,
> libselinux etc are from Gentoo's package).  What's the difference in
> this patch from the generic kernel?

I don't think that will help, and it isn't a good idea to mix and match.
We only periodically make updated releases on nsa.gov, and they are
primarily targeted at the distro package maintainers, not at end users
(and in the case of Fedora, they actually track our bleeding edge from
the selinux sourceforge CVS/subversion tree for the SELinux userland and
the upstream kernel for the kernel code).  Most end users are using the
distro packages these days.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
