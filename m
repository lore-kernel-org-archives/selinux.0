Subject: Re: run_init, and benchmarking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F6D03603069FF329A71681AF1B0@phx.gbl>
References: <BAY114-F6D03603069FF329A71681AF1B0@phx.gbl>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 14:12:33 -0400
Message-Id: <1159467153.13131.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-28 at 17:21 +0200, Salvo Giuffrida wrote:
> Why is there such a command like run_init? I mean, even if I directly start 
> a service through /etc/init.d/nameservice start, shouldn't there be a domain 
> transition (automatic, through type_transition statements) that places the 
> process in the right security context?

That works for the domain, but is more problematic for the user identity
and role, both in terms of making it transparent and in terms of not
wanting to allow it to happen arbitrarily.  run_init was a way to
address those issues, and later also incorporated a way to address the
tty issue (open_init_pty).

However, because of the usability issues (both for users and for e.g.
rpm scriptlets), support for automatic role transitions was enabled in
Fedora, and run_init is not used there, at least not under targeted
policy.  It is being used under MLS, but I'm not sure they have fully
resolved the usability issues.

Hardened Gentoo integrated run_init functionality directly into their
init script system, such that users continue to just run the init
scripts directly, but are now presented with the authentication dialogue
upon doing so, and the context transition is handled for them.

> Another thing: what is the impact on performance of the Security Server-AVC 
> control? What is the percentage in comparison on a "normal" Linux? Is there 
> such a site with benchmarks on this?

There isn't anything really up-to-date, although there are various
benchmark results posted previously, e.g. see
http://marc.theaimsgroup.com/?l=linux-kernel&m=112843656610915&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
