Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <200507262117.j6QLHVB2005226@turing-police.cc.vt.edu>
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
	 <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
	 <1122411830.4470.134.camel@moss-spartans.epoch.ncsc.mil>
	 <200507262117.j6QLHVB2005226@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 17:26:12 -0400
Message-Id: <1122413172.19989.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-26 at 17:17 -0400, Valdis.Kletnieks@vt.edu wrote:
> Stock FC4-devel from fairly recent, I have *not* put the userspace patches
> on.  Possibly an issue with the kernel read-legacy-policy code?

Yes, I meant to run the patched checkpolicy against it, as that would
reproduce the same logic in userspace (the libsepol/checkpolicy patches
have the same compatibility code as the kernel for reading old
policies).

Actually, looking at the code, I think I see the problem; we can have a
false conflict there due to enabled flags.  Have to also look into why
it doesn't recover gracefully, as it should just reject the policy in
that case, not die, of course.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
