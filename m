Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAUG6WIi018485
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 11:06:32 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAUG6Y0N010427
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 16:06:34 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
In-Reply-To: <41AC8E57.9000103@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	 <20041112184232.GK15243@golconda.mitre.org>
	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
	 <nhau0rm54ra.fsf@malabar.mitre.org>
	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
	 <419E1F76.9080803@trustedcs.com>
	 <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>
	 <41A4A921.9060105@trustedcs.com>
	 <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>
	 <41AB383B.3020006@trustedcs.com>
	 <1101763456.2630.67.camel@moss-spartans.epoch.ncsc.mil>
	 <41ABB3C2.2090809@trustedcs.com>
	 <1101819480.4401.9.camel@moss-spartans.epoch.ncsc.mil>
	 <41AC8E57.9000103@trustedcs.com>
Content-Type: text/plain
Message-Id: <1101830525.4401.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 30 Nov 2004 11:02:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-30 at 10:14, Darrel Goeddel wrote:
> 		if (atomic_read(&p->mm->mm_users) != 1) {
> 			struct task_struct *g, *t;
> 			struct mm_struct mm = p->mm;
> 			read_lock(&tasklist_lock);
> 			do_each_thread(g, t)
> 				if (t->mm == mm) {

Should be if (t->mm == mm && t != p), right?  Otherwise, you'll always
have a match.

> 					read_unlock(&tasklist_lock);
> 					return -EPERM;
> 				}
> 			while_each_thread(g, t);
> 			read_unlock(&tasklist_lock);
> 		}

I think that this will work (and parallels the logic in zap_threads()
for coredumps).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
