Date: Wed, 20 Jun 2007 15:13:33 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of capabilities
Message-ID: <20070620201333.GC32520@sergelap.austin.ibm.com>
References: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil> <1182365766.15064.199.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1182365766.15064.199.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> An alternative approach to implementing this support for authoritative
> granting of capabilities by SELinux would be to compute the full
> cap_override access vector upon exec and cap_combine it with the base
> capability sets, such that the task's capability bitmasks would reflect
> the combined capabilities authorized by the base logic and by SELinux
> policy.  Then the capable() hook itself would remain unchanged from the
> current (unpatched) code, just checking the task's capability bitmask
> and then checking the SELinux capability access vector as a further
> restriction on use.
> 
> There are two places where that computation and combination could be
> done: before the usual capability evolution logic is applied (by
> cap_bprm_apply_creds) or after it.  If before, we'd be manipulating the
> bprm capability bitmasks (similar to file capabilities) and then letting
> the usual capability evolution occur; if after, we'd be manipulating the
> task capability bitmasks after they have been updated by the capability
> module.
> 
> Observations:
> - This approach would make the granting of such capabilities visible in
> the task's capability bitmasks as returned by capget
> or /proc/self/status.

That's kind of cool, but I guess it would also lead to policy
reloads not fully affecting the capabilities granted to already
running programs.  So if you remove CAP_NET_RAW from ping_t,
some long-running ping (haha, insert your own better example here)
would continue to run with CAP_NET_RAW, right?

Was there ever any mention of just stopping the stacking with
capability, and just letting selinux handle all it's own capability
logic?  Oh, yes, (vaguely recalling) the argument was about turning
selinux off?  But with the authoritative capabilities logic being
added to selinux that would be a problem anyway, right?

> Those bitmasks would however still not reflect
> the further restrictions imposed by the SELinux capability access vector
> check.
> - This approach would enable the existing capability-based tests to
> provide some protection of the privileged process even apart from the
> SELinux checks, although such protection will still be incomplete
> without the SELinux checks (e.g. we'd gain separate ptrace checking
> based on capabilities, but still depend on selinux control over
> creating/relabeling-to the entrypoint type for the domain).  The extent
> of additional checking depends on whether we do the manipulation before
> or after the usual evolution logic as well; if before, we pick up the
> usual checking on exec; if after, we don't.
> - Doing the computation and combination first and then applying the
> usual evolution logic has a cost in flexibility as it won't support
> orthogonal changes in capabilities.

What do you mean by orthogonal changes in capabilities?  Do you mean
selinux interpreting some caps differently from the capability module?

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
