Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <200507262143.j6QLhBnd006410@turing-police.cc.vt.edu>
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
	 <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
	 <1122411830.4470.134.camel@moss-spartans.epoch.ncsc.mil>
	 <200507262117.j6QLHVB2005226@turing-police.cc.vt.edu>
	 <1122413172.19989.6.camel@moss-spartans.epoch.ncsc.mil>
	 <200507262143.j6QLhBnd006410@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 07:40:31 -0400
Message-Id: <1122464431.19989.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-26 at 17:43 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 26 Jul 2005 17:26:12 EDT, Stephen Smalley said:
> 
> > Actually, looking at the code, I think I see the problem; we can have a
> > false conflict there due to enabled flags.  Have to also look into why
> > it doesn't recover gracefully, as it should just reject the policy in
> > that case, not die, of course.
> 
> Glad you could find it on the sketchy info I gave you. :)
> 
> I assume "graceful recovery" means "issue a useful message, and then refuse
> to boot" as opposed to oopsing and panicing? I *want* my box to refuse to come
> up if it can't find the policy, just in a nicer manner.. ;)

Right.  This behavior is presently handled by /sbin/init - if the
initial policy load fails (i.e. SELinux module returns an error to it
upon the attempted load), then /sbin/init will halt if the system is in
enforcing mode (based on the enforcing= boot parameter if one was
specified or /etc/selinux/config otherwise).  Normally, an error during
the policy load causes the SELinux module to just free the partially
loaded policy and return an error to the caller (in this
case, /sbin/init), but obviously something is going wrong here in the
module's error handling path for a failed policy load.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
