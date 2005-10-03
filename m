Subject: Re: getseuserbyname patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1128028887.27495.184.camel@moss-spartans.epoch.ncsc.mil>
References: <43398EB2.1050100@redhat.com>
	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
	 <433BEB18.7000703@redhat.com>
	 <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>
	 <433C06F0.3020804@redhat.com>  <433C3C5A.4000104@redhat.com>
	 <1128028887.27495.184.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 11:52:09 -0400
Message-Id: <1128354729.26285.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-29 at 17:21 -0400, Stephen Smalley wrote:
> On Thu, 2005-09-29 at 15:11 -0400, Daniel J Walsh wrote:
> > Ok lets try again.
> > 
> > getseuserbyname(const char *username, char **seuser, char **level);
> 
> I think this interface is good to go, so you can proceed to work with
> it.  I still need to go through the implementation carefully prior to
> merging it upstream.

I merged a revised implementation of this interface into libselinux
1.27.2, as you know.  However, it occurred to me that if you are going
to rework pam_selinux and the SELinux patches for sshd, crond, etc to
use this interface along with either get_ordered_context_list_with_level
or get_default_context_with_level, then we need to make sure this also
works when using a non-MLS policy.  The simplest approach would be to
have getseuserbyname not require (but allow) a MLS field in the config
file if MLS is disabled (!is_selinux_mls_enabled()), and just set *level
to NULL in that case.  get_ordered_context_list_with_level and
get_default_context_with_level will handle that correctly already.  The
caller can still unconditionally free the level afterward as free (NULL)
is perfectly valid and harmless.

This will ensure that the same code will work regardless of whether MLS
is enabled or not, and that people can still use seusers.conf to map
Linux users to SELinux users (and thus to role sets) even in the non-MLS
case.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
