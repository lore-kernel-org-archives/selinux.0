Message-ID: <52015950.9010906@tycho.nsa.gov>
Date: Tue, 06 Aug 2013 16:15:12 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan Pou <danielp@sgi.com>
CC: SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: Re: Programmatic domain change to unprivileged role
References: <20130805190732.GT18909@localhost>
In-Reply-To: <20130805190732.GT18909@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/05/2013 03:07 PM, Dan Pou wrote:
> I have an existing daemon that I am working to enable in an MLS setting,
> but I am running into difficulties with calls to get a context of an
> unprivileged user from the daemon context
> (system_u:system_r:<name-of-service>_t:s0-s15:c0.c1023).
> The deamon will run an executable with ID of an authenticated user, so I
> looked at trying to replicate the method used by sshd.
> When sshd calls get_default_context, there is a transition defined to go
> to the user_u:user_r:user_t domain, but there is not one available from
> the daemon context I have developed.
> Is there a simpler example than ssh that I could look at to understand
> how to specify transitions?
> The daemon uses the fork+execve method, so I don't think that I need the
> dyntransition method, but it is not clear to me how to specify all the
> required transitions for executing any file available to an unprivileged
> user.

Are you looking for how to write the code to perform the context change,
or how to write the policy to permit it to happen?  Or both?

If your question has to do with policy, then the refpolicy list or
fedora selinux list may be better resources, as it will depend on the
specific policy interfaces provided by refpolicy and/or your distribution.

The result of get_default_context() is of course driven by the policy,
so your ability to use it effectively depends on having the right policy
in place first.  Your daemon's domain will presumably need several of
the interfaces defined in system/userdomain.if to permit the domain
transition, along with interfaces from kernel/domain.if to permit
switching user and role.  Possibly something like:
userdom_spec_domtrans_unpriv_users(X_t)
userdom_bin_spec_domtrans_unpriv_users(X_t)
userdom_entry_spec_domtrans_unpriv_users(X_t)
domain_subj_id_change_exemption(X_t)
domain_role_change_exemption(X_t)




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
