Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFDTpIi022628
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 08:29:51 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFDSPvq016129
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 13:28:25 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041114202332.GO5031@lkcl.net>
References: <20041114202332.GO5031@lkcl.net>
Content-Type: text/plain
Message-Id: <1100525144.31773.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Nov 2004 08:25:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-11-14 at 15:23, Luke Kenneth Casson Leighton wrote:
> i hope people don't mind me pointing out what may appear to be obvious:
> 
> q: how do you stop an attacker circumventing a program with this
> seteuid-like dynamic context transition capability, such that the
> attacker can make the program transition anywhere anytime to an
> arbitrarily chosen domain?
> 
> answer: by restricting the domains to which the transition may occur.
> 
> q: how would you do that?
> 
> answer: by providing something similar to domain_auto_trans() which is
> instead adding a level of indirection.  so, instead of the newly
> proposed function (let's call it selinux_change_domain) specifying the
> new domain as its argument, you instead specify an intermediate handle.
> 
> so you'd have in the policy:
> 
> dynamic_handle "samba_as_root" samba_root_t
> dynamic_handle "samba_as_user" samba_user_t
> 
> dynamic_auto_trans(samba_t, "samba_as_root")
> dynamic_auto_trans(samba_root_t, "samba_as_user")
> 
> then, inside smbd, you call, at the appropriate point:
> 
> 	selinux_change_domain("samba_as_user")
> 
> then, the job of the selinux_change_domain() function is to not only
> check that you have permission to make dynamic transitions, but
> also that you are in the samba_root_t domain - and to do a lookup
> onto the dynamic_handle to find out what domain to transition to.
> 
> 
> otherwise, you run the risk of a circumvented program being able to
> transition to unconfined_t - or anything that they damn well choose.
> 
> i trust that this has been considered in the design of the new dynamic
> transition function?

Luke,

As proposed, there are two permission checks applied upon a dynamic
domain transition operation from A to B:
1) In order to write to /proc/pid/attr/current at all, A must have
setcurrent permission to itself, i.e. allow A self:process setcurrent;
This parallels the setexec and setfscreate checks performed for setting
other attributes under /proc/pid/attr.
2) In order to dynamically transition from A to B, A must have
dyntransition permission to B, i.e. allow A B:process dyntransition;
This parallels the transition permission check applied upon exec-based
transitions, but is distinct so that we can control them separately.

domain_auto_trans() is merely a macro that expands to a set of allow
rules typically needed for an exec-based transition and a
type_transition rule to define the default type transition for a given
(calling domain, executable) pair.  In the case of dynamic transitions,
there is no such thing as a default transition; the application is
always explicitly requesting a transition, and can specify the desired
new context, just as some security-aware applications presently do for
exec-based transitions using setexeccon().  But there is no need for any
new policy construct to control this operation; you just need the new
permissions to be defined, and then you can control the reachability of
domains via dynamic transitions using allow rules.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
