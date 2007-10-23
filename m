Subject: Re: trouble with ssh in today's rawhide + refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <471DFC97.6040303@redhat.com>
References: <471D1596.8070900@tycho.nsa.gov> <1193144985.9466.53.camel@gorn>
	 <1193145799.2179.18.camel@moss-spartans.epoch.ncsc.mil>
	 <1193146797.9466.64.camel@gorn>  <471DFC97.6040303@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 13:18:47 -0400
Message-Id: <1193159927.2179.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-23 at 09:52 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Christopher J. PeBenito wrote:
> > On Tue, 2007-10-23 at 09:23 -0400, Stephen Smalley wrote:
> >> On Tue, 2007-10-23 at 13:09 +0000, Christopher J. PeBenito wrote:
> >>> On Mon, 2007-10-22 at 17:26 -0400, Eamon Walsh wrote:
> >>>> On a rawhide box updated this afternoon, running refpolicy trunk in mcs 
> >>>> mode, I get the following after rebooting the box and logging in over ssh:
> >>>>
> >>>> $ id -Z
> >>>> sysadm_u:sysadm_r:system_chkpwd_t:s0
> >>> Do you have ssh_sysadm_login on?  Also, it seems odd that this would
> >>> happen, since this combination doesn't show up in default_contexts, and
> >>> the only auto transition to system_chkpwd_t from sshd_t is via
> >>> chkpwd_exec_t.
> >> We've seen this kind of behavior before when the
> >> get_ordered_context_list() logic fails to get any contexts from
> >> security_compute_user() that correspond with any of the partial contexts
> >> in default_contexts - it then falls back to just returning the entire
> >> reachable list.
> > 
> > Ok.  For some reason I always thought it would just fail if nothing
> > worked from default_contexts.
> > 
> I think that is what should happen, but it does not.

Well, two observations:
- originally default_contexts was only supposed to specify defaults, not
everything, so the system was supposed to work even if it was empty (but
we have already migrated away from that to some degree),
- if we fail entirely in that case, then we'll fail even in permissive
mode, unless the caller is also checking for permissive mode and has
some fallback behavior in that case.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
