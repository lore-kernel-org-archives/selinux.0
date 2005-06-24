Subject: RE: Alternative user management approach
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Karl MacMillan <kmacmillan@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <1119639124.31852.69.camel@celtics.boston.redhat.com>
References: <200506241836.j5OIaJqc018526@gotham.columbia.tresys.com>
	 <1119639124.31852.69.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:23:09 -0400
Message-Id: <1119640989.12865.156.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 14:52 -0400, Ivan Gyurdiev wrote:
> How exactly would this be done.
> Currently there's a 1:1 maping from user to selinux user. I assumed this
> is hardcoded - is this not the case? I'm not sure what login utilities
> do..
> 
> If it is hardcoded, it needs to
> be made configurable, and integrated w/ useradd utilities.

It is handled by libselinux get_ordered_context_list(3), which first
attempts to obtain a list of reachable security contexts for the user,
and if that fails (due to the user not being defined in the policy), it
falls back to user_u as the default.  So you just need to implement the
user mapping logic in that function based on some new config file, and
adjust a few programs that explicitly try to use or manipulate SELinux
user identity.  The latter includes:
- newrole, run_init (try to re-authenticate the user based on the
SELinux user identity rather than the Linux uid, should be changed to
use the audit uid if possible),
- sudo, usermode (try to transition to a security context for "root").
In general, we need to reconsider how su/sudo/userhelper work in this
environment.  Original SELinux kept su and newrole as separate,
independent steps with su only dealing with Linux uid, not context, and
newrole preserving the user identity across role changes.  Fedora
integrated user context transitions into su (via pam_selinux), sudo, and
userhelper. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
