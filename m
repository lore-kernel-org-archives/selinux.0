Subject: Re: Questions on SID, TYPE_CHANGE, and user transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Charles M. Schmidt" <cmschmidt@mitre.org>
Cc: SELinux@tycho.nsa.gov, Amy L Herzog <aherzog@mitre.org>,
   Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <001301c4553e$c7466830$6400a8c0@MITRE.ORG>
References: <001301c4553e$c7466830$6400a8c0@MITRE.ORG>
Content-Type: text/plain
Message-Id: <1087571025.27697.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 11:03:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-18 at 10:15, Charles M. Schmidt wrote:
> SIDs - My understanding of the SID directive is that it is used to associate
> "entities" with security contexts at startup. However, I am confused as to
> exactly what these "entities" are. Specificially, I am wondering about the
> meaning of the first argument to the SID directive. (Ie. in "sid unlabeled
> system_u:object_r:unlabeled_t" what does "unlabeled" refer to?) As far as I
> can tell, these identifiers do not map to anything else in the policy file.
> What entities are receiving these initial contexts? Do these directives have
> hardcoded meanings (like the CLASS directives)?

Yes.  A set of initial SIDs is declared in policy/flask/initial_sids; a
kernel header file is generated from this configuration file that
contains symbol definitions for each of the initial SIDs that can be
used in the SELinux module code when assigning SIDs for specific uses
where it is not feasible or desirable to dynamically look up a context. 
The policy/initial_sid_contexts file then maps each initial SID to a
security context in the policy.  The initial SID name is converted to
the symbol definition name.

> TYPE_CHANGE - I have read the documentation as well as a number of posts to
> this list regarding the TYPE_CHANGE directive, but have to admit that it
> still has me confused. I understand that it does not force type transitions
> (differing from  TYPE_TRANSITION directives) and does not grant any
> permissions to allow type (similar to TYPE_TRANSITION directives). I've also
> read that it is "used by security aware applications to define relabling
> behavior", but I guess I am not certain of what that means. If a security
> aware application wishes to transition  itself or a child to a new type, why
> doesn't it just do so on its own? Why would it need to look at the
> TYPE_CHANGE directives to do this? And why would an automatic transition be
> inappropriate? An example might be helpful here.

type_transition is for determining the type of a new subject or object,
and is used internally by the kernel as well as via the
security_compute_create API by userspace policy enforcers.  type_change
is for determining the new type when relabeling an existing object.
When programs such as login and newrole need to set the security context
on the tty/pty, they invoke the security_compute_relabel API to obtain
the new tty security context based on the user session security context
and the existing security context on the tty/pty.  The type_change rules
in the policy specify the new types, which are typically derived from a
combination of the user domain and the base tty/pty type, e.g.
user_tty_device_t for user_r:user_t and staff_tty_device_t for
staff_r:staff_t.  They then pass the context obtained via this API to
setfilecon to set the context on the tty/pty.  This avoids any policy
logic in the programs.

> USER - Actually, less of a question about the directive and more of a
> question as to how user identities are handled. My understanding is that,
> when a user logs into SELinux, the security kernel looks at the Linux
> username the user logged in under and checks to see if it has any USER
> directives with identities that match that name. If so, the matching SELinux
> identity is used. Otherwise, the user_u user identity is used. (Correct?)
> What processes/applications are allowed to change the user identity in this
> way?

Programs such as login and sshd invoke a function in libselinux to
obtain an appropriate security context for a given Unix username. 
libselinux queries the kernel for a set of contexts for that user that
are reachable from the current security context (i.e. the context of the
login or sshd process), and if it cannot find any such contexts at all,
it falls back to user_u.  policy/constraints controls the ability to set
the SELinux user identity.  In the example policy, login, sshd, sulogin,
[xgk]dm, run_init, su, userhelper, and crond are allowed to change their
SELinux user identity.  But note that this does not mean that they can
change to arbitrary domains; domain transitions are still governed by
the TE configuration.  

> If I am reading this right, this contradicts the behavior expected in the
> previous statement. Have I misunderstood what is happening here?

RedHat decided to integrate context changing functionality into su via
pam_selinux, including setting the user identity.  See
http://marc.theaimsgroup.com/?l=selinux&m=107757717110966&w=2 and
subsequent discussion.  This is answered in the Fedora SELinux FAQ, see 
http://people.redhat.com/kwade/fedora-docs/selinux-faq-en/index.html#id3004527.
Any reason you aren't running Fedora Core 2 final?

> My hope was that I could get
> the server running with the new Linux username, but keeping the
> system_u:system_r context (just like all the other servers).  Instead, the
> server gets transitioned to the user_u:user_r context. I imagine I could
> solve this problem by creating a new SELinux user identity that matched the
> Linux identity and then assigning it the system_r role (in which case I
> wouldn't run under system_u, but I could run under the system_r role, which
> would suffice).

Yes, see policy/serviceusers for examples.

>  However, I would prefer to understand what actions were
> going on and see if I could control them. I note that there are several
> other daemons running under separate Linux usernames but which keep the
> system_u identity. What is the difference here?

They likely are starting as root and then directly using setuid(2) to
switch to a different Linux user identity as opposed to using su(1).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
