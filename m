Date: Wed, 20 Jun 2007 16:08:35 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of capabilities
Message-ID: <20070620210835.GA21869@sergelap.austin.ibm.com>
References: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil> <1182365766.15064.199.camel@moss-spartans.epoch.ncsc.mil> <20070620201333.GC32520@sergelap.austin.ibm.com> <1182372732.15064.268.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1182372732.15064.268.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Wed, 2007-06-20 at 15:13 -0500, Serge E. Hallyn wrote:
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > An alternative approach to implementing this support for authoritative
> > > granting of capabilities by SELinux would be to compute the full
> > > cap_override access vector upon exec and cap_combine it with the base
> > > capability sets, such that the task's capability bitmasks would reflect
> > > the combined capabilities authorized by the base logic and by SELinux
> > > policy.  Then the capable() hook itself would remain unchanged from the
> > > current (unpatched) code, just checking the task's capability bitmask
> > > and then checking the SELinux capability access vector as a further
> > > restriction on use.
> > > 
> > > There are two places where that computation and combination could be
> > > done: before the usual capability evolution logic is applied (by
> > > cap_bprm_apply_creds) or after it.  If before, we'd be manipulating the
> > > bprm capability bitmasks (similar to file capabilities) and then letting
> > > the usual capability evolution occur; if after, we'd be manipulating the
> > > task capability bitmasks after they have been updated by the capability
> > > module.
> > > 
> > > Observations:
> > > - This approach would make the granting of such capabilities visible in
> > > the task's capability bitmasks as returned by capget
> > > or /proc/self/status.
> > 
> > That's kind of cool, but I guess it would also lead to policy
> > reloads not fully affecting the capabilities granted to already
> > running programs.  So if you remove CAP_NET_RAW from ping_t,
> > some long-running ping (haha, insert your own better example here)
> > would continue to run with CAP_NET_RAW, right?
> 
> Suppose that you granted ping_t net_raw authoritatively via the
> following pair of rules (both required):
> # Allow ping_t to use net_raw capability; checked-on-use.
> allow ping_t self:capability net_raw;
> # Grant ping_t net_raw capability even if not suid; checked-on-exec.
> allow ping_t self:cap_override net_raw;
> 
> Now you want to revoke net_raw from ping_t (or possibly both allow rules
> were under a boolean in the first place, and you are toggling the
> boolean).  You can still remove/disable the first rule and thus revoke
> any further use of the capability.

But you can't have that take effect for non-root users (who would not
otherwise have the capability) while letting root users use it, right?

> > Was there ever any mention of just stopping the stacking with
> > capability, and just letting selinux handle all it's own capability
> > logic?  Oh, yes, (vaguely recalling) the argument was about turning
> > selinux off?  But with the authoritative capabilities logic being
> > added to selinux that would be a problem anyway, right?
> 
> That approach has several disadvantages:
> - it changes the semantic meaning of existing policies:  allow a_t
> self:capability { a b c }; changes from being an upper bound on what
> capabilities a_t can ever exercise to being a direct grant of those
> capabilities to all a_t processes.  Note for example that SELinux policy
> allows all capabilities to unconfined_t, yet ordinary user processes in
> unconfined_t can only exercise capabilities via setuid root programs
> under the current scheme, and we wouldn't want that to change wholesale.
> - it removes a protection boundary on which existing policies were
> relying:  the need to change uids or at least capability bitmasks
> provided an orthogonal protection check between processes, so it was ok
> for e.g. processes with differing capability sets to run in the same
> domain formerly (again as in unconfined_t).
> - it applies the behavior change globally rather than selectively on a
> per-domain per-capability basis (vs. having separate allow a_t
> self:cap_override rules that can specify any subset of the ones allowed
> by the capability rule).

Ok, makes sense, thanks.

> > > Those bitmasks would however still not reflect
> > > the further restrictions imposed by the SELinux capability access vector
> > > check.
> > > - This approach would enable the existing capability-based tests to
> > > provide some protection of the privileged process even apart from the
> > > SELinux checks, although such protection will still be incomplete
> > > without the SELinux checks (e.g. we'd gain separate ptrace checking
> > > based on capabilities, but still depend on selinux control over
> > > creating/relabeling-to the entrypoint type for the domain).  The extent
> > > of additional checking depends on whether we do the manipulation before
> > > or after the usual evolution logic as well; if before, we pick up the
> > > usual checking on exec; if after, we don't.
> > > - Doing the computation and combination first and then applying the
> > > usual evolution logic has a cost in flexibility as it won't support
> > > orthogonal changes in capabilities.
> > 
> > What do you mean by orthogonal changes in capabilities?  Do you mean
> > selinux interpreting some caps differently from the capability module?
> 
> No, just the fact that under TE, you can define the capabilities
> assigned to the caller domain and to the callee domain independently and
> separately, and then set up the domain transition between them.  Versus
> following a fixed evolution computation based on the caller's capability
> bitmasks and the file's capability bitmasks.

Ok, I see.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
