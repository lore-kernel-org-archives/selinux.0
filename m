Subject: Re: sys_admin cap breakup
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1081774708.22078.1.camel@nexus.verbum.private>
References: <407A001D.3010805@snu.edu>
	 <1081774708.22078.1.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1081784544.20135.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Apr 2004 11:42:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-04-12 at 08:58, Colin Walters wrote:
> On Sun, 2004-04-11 at 22:34, Joshua Brindle wrote:
> 
> > So this is a question for the guys that are doing kernel work and 
> > possibly interacting with linus and friends. How plausible would it be 
> > to suggest breaking up caps that give lots of access in the next major 
> > version, 2.7 or 2.8? do you think they'd go for it?
> 
> Maybe a better solution is to simply stop using capabilities entirely,
> and make the necessary changes to the policy.

Yes, although this still requires adding a LSM hook to abstract the new
security check and defining new classes and permissions as appropriate
for SELinux.  SELinux should eventually replace capabilities entirely
and provide complete privilege management using RBAC/TE.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
