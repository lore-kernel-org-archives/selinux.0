Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <20070620210835.GA21869@sergelap.austin.ibm.com>
References: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil>
	 <1182365766.15064.199.camel@moss-spartans.epoch.ncsc.mil>
	 <20070620201333.GC32520@sergelap.austin.ibm.com>
	 <1182372732.15064.268.camel@moss-spartans.epoch.ncsc.mil>
	 <20070620210835.GA21869@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 08:24:52 -0400
Message-Id: <1182428692.15064.277.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-20 at 16:08 -0500, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > On Wed, 2007-06-20 at 15:13 -0500, Serge E. Hallyn wrote:
> > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > > An alternative approach to implementing this support for authoritative
> > > > granting of capabilities by SELinux would be to compute the full
> > > > cap_override access vector upon exec and cap_combine it with the base
> > > > capability sets, such that the task's capability bitmasks would reflect
> > > > the combined capabilities authorized by the base logic and by SELinux
> > > > policy.  Then the capable() hook itself would remain unchanged from the
> > > > current (unpatched) code, just checking the task's capability bitmask
> > > > and then checking the SELinux capability access vector as a further
> > > > restriction on use.
> > > > 
> > > > There are two places where that computation and combination could be
> > > > done: before the usual capability evolution logic is applied (by
> > > > cap_bprm_apply_creds) or after it.  If before, we'd be manipulating the
> > > > bprm capability bitmasks (similar to file capabilities) and then letting
> > > > the usual capability evolution occur; if after, we'd be manipulating the
> > > > task capability bitmasks after they have been updated by the capability
> > > > module.
> > > > 
> > > > Observations:
> > > > - This approach would make the granting of such capabilities visible in
> > > > the task's capability bitmasks as returned by capget
> > > > or /proc/self/status.
> > > 
> > > That's kind of cool, but I guess it would also lead to policy
> > > reloads not fully affecting the capabilities granted to already
> > > running programs.  So if you remove CAP_NET_RAW from ping_t,
> > > some long-running ping (haha, insert your own better example here)
> > > would continue to run with CAP_NET_RAW, right?
> > 
> > Suppose that you granted ping_t net_raw authoritatively via the
> > following pair of rules (both required):
> > # Allow ping_t to use net_raw capability; checked-on-use.
> > allow ping_t self:capability net_raw;
> > # Grant ping_t net_raw capability even if not suid; checked-on-exec.
> > allow ping_t self:cap_override net_raw;
> > 
> > Now you want to revoke net_raw from ping_t (or possibly both allow rules
> > were under a boolean in the first place, and you are toggling the
> > boolean).  You can still remove/disable the first rule and thus revoke
> > any further use of the capability.
> 
> But you can't have that take effect for non-root users (who would not
> otherwise have the capability) while letting root users use it, right?

True.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
