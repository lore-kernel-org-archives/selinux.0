Subject: Re: root login with enforcing on
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200310300910.10860.russell@coker.com.au>
References: <200310300910.10860.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1067532120.30233.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Oct 2003 11:42:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-29 at 17:10, Russell Coker wrote:
> The issue here is whether staff_r is a slightly priviledged role that can be 
> used for regular Unix tasks, or whether it is a cut-down administration role.
> 
> With the current policy it is a user role with the possibility of 
> transitioning to sysadm_r and it can also see more processes in "ps".  As 
> such a user who is authorised for staff_r may not be authorised for sysadm_r 
> even if they have the root password.

I viewed staff_r as simply an initial login role for administrators who
are also authorized for sysadm_r.  Not as a fully independent role that
would be separately granted.  Administrators can login (locally or
remotely) as staff_r, have access to their home directories and files
labeled in staff_home*_t, have their processes and files properly
protected against user_r since they exist in a separate domain and type,
and can newrole to sysadm_r to perform privileged operations.  Granting
staff_r to users who are not supposed to be granted access to sysadm_r
reintroduces the same issues, as they will be able to interfere with
initial logins and files of administrators (except in the special case
of a direct login as "root" and "sysadm_r" with a home directory labeled
with staff_home*_t, which is not the typical case and generally not
desirable).

> Many program domains need access to any home directory that is to be used for 
> general Unix access (IE reading email, running IRC, etc).  If we consider 
> staff_r to be a cut-down version of sysadm_r then we don't want to permit 
> such access.

A quick audit of the current policy shows a surprising set of program
domains that have _write_ access to the home directory types.  Might
want to review that set.  Policy tools are your friend here, as they can
expand attributes and can also do some data flow analysis, unlike a
simple grep of the policy.conf file.

> Maybe we should have an extra role, so we have one role for "more privs than 
> user_r and ability to newrole to sysadm_r" and another for "less privs than 
> sysadm_r and less access to general Unix stuff"?

Higher priorities are:
- Split administrator role, start with a naive decomposition of sysadm_r
and secadm_r, focusing on moving policy-related tasks to secadm_r.
- Migrate permissions from sysadm_t to specific program domains,
introducing program gates as necessary to prevent malicious invocation,
so that malicious code execution from an administrator shell is not
fatal.
- Reducing/eliminating use of "global" attributes in allow rules.
- Minimizing execute/entrypoint permissions.
- Separating related processes into separate domains, e.g.
cron jobs for the packages.
- Performing a thorough audit and reduction of permissions.

Again, policy tools are your friend.  Without them, as an example, it
can very difficult to discern that some unprivileged domain can
ultimately write to a sensitive file on which a privileged domain
depends.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
