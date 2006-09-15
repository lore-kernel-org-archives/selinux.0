Subject: Re: Question on type_member rule
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Cc: Janak Desai <jdesai@us.ibm.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
        LSPP <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <p06002037c130476cd8d9@[192.168.50.32]>
References: <p06002037c130476cd8d9@[192.168.50.32]>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 13:40:58 -0400
Message-Id: <1158342058.18951.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-15 at 08:51 -0400, Rosalie Hiebel wrote:
> I'm trying to understand precisely how a type_member rule specifies 
> the context to place on an instance of a polyinstantiated directory 
> when it's done by context.
> 
>    type_member <source_type> <target_type>:dir <member_type>;
> 
> What exactly will be the context placed on the instance of the 
> directory created by a process?   Will this context be the same as 
> the context passed to setexeccon ?  Is the <member_type> placed in 
> the context of the instance directory ?   Does running in permissive 
> mode result in a different context ?
> 
> I have experimented with this, and I seem to always get instance 
> directories created with the same context as that of the base 
> directory (the one being polyinstantiated.)

Let's distinguish between what security_compute_member() computes, and
how pam_namespace calls and uses it.

Further, before we delve too deep here, I have to ask:  Does your
application truly require polyinstantiated directories?  From what
you've described thus far, it sounds as though the application is
already security-aware and multi-level, so what does it gain from
polyinstantiation vs. explicit directory/file management?
Polyinstantiation is more oriented toward providing compatibility for
security-unaware applications when accessing a shared resource like /tmp
that must be partitioned in a multi-level environment without having to
modify those applications to know about per-level instances.  But if the
application already knows that it is operating in a multi-level
environment and even knows what level it needs to operate in, why does
it need polyinstantiation vs. just accessing the right subdir directly?
(I'd also be interested in exploring the architecture of your
application and whether it can be decomposed to minimize trust, but that
is another topic.)

Going back now to your questions, security_compute_member() is a
function to compute a member/instance context for a given
polyinstantiated object based on three inputs:
1) a source context, typically the context of the process that will be
accessing the instance,
2) a target context, typically the context of the polyinstantiated
object, and
3) the class of the object, so that we can distinguish different kinds
of polyinstantiated objects that might ultimately exist beyond just
directories.

The function itself has no knowledge of how these inputs are determined;
they are provided by the caller (pam_namespace in this case).  The
function computes a member context from these inputs based on its
internal rules, which are:
1) Look for a type_member rule that matches the type from the source
context (source_type), the type from the target context (target_type),
and the class.
2) If no such rule exists, then the function just returns a member
context equal to the target context (no instantiation).
3) If a rule exists, then use the member_type from the rule as the type
in the member context.  Further, if that member_type differs from the
target_type (*), use the level of the source context as the level in the
member context.

(*) Implementation artifact:  In concept, the type_member rule indicates
when to polyinstantiate an object, and it was assumed that one would
always want to polyinstantiate by type as well as level in such cases,
so member_type != target_type is used as the test in the MLS component
to determine whether it should polyinstantiate levels.  That could be
changed (in fact, there was some discussion of it in the past), but
until such a change occurs, you need to use member_type != target_type
in the rule to cause instantiation to occur.

pam_namespace uses security_compute_member() to get the member context.
It passes the following as inputs:
1) the exec context as the source context,
2) the context of the directory to be polyinstantiated as the target
context.
3) the directory class.

The use of the exec context is because we want to instantiate based on
the context of the process that will be accessing the member, which is
typically _not_ the current process.  Instead, it is typically a user
shell or other program executed by the current process (or a child) that
will run in the exec context rather than the current one.  This is the
case for e.g. login and newrole.  If your application doesn't follow
such a model, we need to talk about your application's architecture.

Examples of type_member rules from the refpolicy:
	type_member user_t tmp_t:dir user_tmp_t;
	type_member staff_t tmp_t:dir staff_tmp_t;

Then, if pam_namespace is configured to polyinstantiate /tmp by context
and the user is not in the list of excluded uids, it would call
security_compute_member with the exec context (set by the caller of
pam_namespace, e.g. sds:staff_r:staff_t:s3) and the context of the /tmp
directory (e.g. system_u:object_r:tmp_t:s0).  security_compute_member()
would find the matching type_member rule for (staff_t, tmp_t) and should
return the context system_u:object_r:staff_tmp_t:s3 as the
member/instance context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
