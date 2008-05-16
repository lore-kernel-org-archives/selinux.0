Subject: Re: Differences between openssh and pam_selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tomas Mraz <tmraz@redhat.com>
Cc: fedora-selinux-list@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1210871514.20548.53.camel@vespa.frost.loc>
References: <1210871514.20548.53.camel@vespa.frost.loc>
Content-Type: text/plain
Date: Fri, 16 May 2008 11:08:50 -0400
Message-Id: <1210950530.28282.304.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-05-15 at 19:11 +0200, Tomas Mraz wrote:
> There are some differences in how openssh and pam_selinux get the user's
> context. As I want to replace part of the openssh's SELinux code with
> pam_selinux I'd like to know which one is more correct.
> 
> Here's the rough algorithm for both:
> 
> OpenSSH
> =======
> 
> 1. get selinux user & default level with getseuserbyname()
> 2. obtain default ctx with get_default_context_with_level()
> 3. obtain requested ctx for requested level with
> get_default_context_with_level()
> 4. set requested role to the requested ctx
> 5. set type for the requested role to the requested ctx (obtained from
> get_default_type(requested role))
> 6. copy the requested ctx and set the requested level in the copy
> 7. compare the requested ctx with the copy - if not equal -> fail
> 8. do the points 3. - 7. with the difference that the default level is
> used instead of requested level
> 9. do security_compute_av with CONTEXT__CONTAINS to check whether the
> context from 7. is allowed for context from 8. if not allowed -> fail
> 10. use the context from 7. as the user's context.
> 
> pam_selinux
> ===========
> 
> 1. get selinux user & default level with getseuserbyname()
> 2. use get_ordered_context_list_with_level() to obtain list of context
> for the user & level, as the default user's context is taken the first
> one on the list
> 3. if this fails:
> 3a.  the level and role is obtained from user and combined into a
> context with default type for the role and the selinux user
> 3b.  this ctx is checked with security_check_context() - if fails ->
> fail else we have the user's context -> end
> 4. if 2. succeeds and module is configured to allow asking user for
> role/level then user is asked for requested role and level
> 5. the requested ctx starts as copy of the default ctx
> 6. the requested role is set to requested ctx, requested level is set
> and the default type (get_default_type()) for the requested role is set
> 7. the requested ctx is checked with security_check_context() - if fails
> -> fail
> 8. do security_compute_av with CONTEXT__CONTAINS to check whether the
> context from 7. is allowed for default context if not allowed -> fail
> 9. use the context from 7. as the user's context.
> 
> So which one is correct if any?

(cc'ing selinux@tycho.nsa.gov as this is an upstream issue as well)

The logic has evolved or perhaps devolved over time (e.g. introduction
of seusers as a further level of indirection between Linux users and
SELinux users, introduction of support for requesting specific roles and
levels), and we really ought to try to encapsulate more of it within a
single libselinux helper function that can be used by all applications.

As I recall, openssh had special logic introduced to preserve the
desired LSPP behavior for labeled networking (ensuring that the client's
level is preserved across the entire session as otherwise data would be
downgraded from the server to the client).  That may explain the
difference.  In that scenario, as I recall, xinetd would launch sshd in
the level obtained for the client via getpeercon.

Abstractly, we want the final context (user:role:type:level) that is
used to:
1) use the SELinux user obtained from getseuserbyname(),
2) have valid user-role, role-type, and user-level pairs (this will in
fact be checked by the kernel upon attempted use to setexeccon(), but
we'd rather catch it early via security_check_context),
3) be bounded (via CONTEXT__CONTAINS check) by the MLS level or range
for the Linux user obtained from getseuserbyname() as this may be a
subset of the range authorized for the SELinux user, and
4) be bounded by the MLS range of the caller (this is especially for the
labeled networking case, but is generally true and could be useful even
for local logins e.g. to bind a specific range to one tty and a
different range to another).

get_default_context* internally just uses get_ordered_context* and then
selects the first item, so there is no difference between using them if
you are only selecting the first item.  The only reason to use
get_ordered_context* is if you want to present a list of options to the
user for selection, which pam_selinux did at one time.

Possibly we want a libselinux interface that takes the Linux username,
an optional requested role and an optional requested level argument, and
just returns an entire context that meets the criteria above.
getseuserbyname() can be used to obtain the default values of the
SELinux user and the range/level for the context.  If no role was
requested, it could be obtained via get_default_context although it
would be nice to just provide a simpler mechanism specialized for that
purpose, e.g. a policy config file that maps SELinux users to default
roles (Chris cc'd).  The type could always default to get_default_type()
for the role in that case, thereby eliminating any chance of incorrectly
getting any program types there.

Thoughts?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
