Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
In-Reply-To: <4235C937.3030404@kaigai.gr.jp>
References: <42346C17.3090301@kaigai.gr.jp>
	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
	 <4235C937.3030404@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 13:25:12 -0500
Message-Id: <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-15 at 02:26 +0900, KaiGai Kohei wrote:
> In my patch, child domain/type inherit all rules including target/object
> and area of ROLE clearly, not only source/subject.
> (Those source/target is also included in TYPE_TRANSITION statements.)
> Any permissions to parent means permissions to child/descendant concurrently.
<snip>
> When parent has permissions to himself, child also has permissions to his
> parent and himself(child). In my patch, to inherit type/domain always expand
> descendant's permissions. I intend to define a child type/domain which has
> tiny larger permission than own parent low cost.

This makes sense for unifying file types, as in the earlier multiple
contexts thread.  I'm not sure I see how it is useful for domains; any
permissions allowed to the child domain can be indirectly gained by the
parent domain (or any domain which can control the parent domain) and
any program executables that can be used to enter the parent domain can
be used to enter the child domain, so you might as well just directly
allow the permissions to the parent domain.  As a trivial example, if
you declare 'type user_ext_t extends user_t;', then user_t gets ptrace
permission to user_ext_t because it has ptrace permission to itself, so
any user_t process has full control over user_ext_t and can thus
exercise its permissions at will.

> I think definition of reductive permission child-type/domain is the next
> action assignment. If child does not need a part of the parent's permissions,
> those should be revoked by DENY statement for example.

Hmmm...given the way in which you are computing inheritance, it seems
that it could be very easy to miss something being implicitly allowed
and fail to define a corresponding deny statement.  Maintainability also
becomes a problem as you have to reassess the deny rules whenever a new
allow rule is added.  And we need to consider not only limiting the
child, but limiting the parent from controlling the child, if we are
going to allow more permissions to the child than the parent.

> When child_t inherit parent_t, "allow parent_t parent_t:process sigkill;"
> is unrolled to "allow {parent_t child_t} {parent_t child_t}:process sigkill;"
> The number of conbination is 4.
> 
> "allow parent_t self:process sigkill;" is unrolled as follows:
>   "allow parent_t parent_t:process sigkill;"
>   "allow parent_t child_t:process  sigkill;"
>   "allow child_t  child_t:process  sigkill;"

The latter is more in line with what I would expect, and regardless, I
think that they should be unrolled consistently regardless of whether
the allow rule was written with "self" or explicitly with the same
domain (or an attribute that included the domain); self was purely
intended as a convenience notation and a way to express the self
relationship when using an attribute/set for the source type.  

> parent_t/child_t shares same transition rule for same exec type.
> Maybe, any kind of overriding semantics is necessary.

Typically, when creating a derived domain (e.g. for a program run by a
user domain), we don't want to inherit any of the transition rules of
the base user domain.  A template-based approach as suggested by Karl
seems necessary here, effectively turning the existing macro constructs
into a language feature.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
