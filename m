Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
In-Reply-To: <42346C17.3090301@kaigai.gr.jp>
References: <42346C17.3090301@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 08:50:02 -0500
Message-Id: <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-14 at 01:36 +0900, KaiGai Kohei wrote:
> This attached patch provids a new syntax extension to checkpolicy.
> This makes it possible to describe a definition of type which inherit
> access vectors of parent's types/attributes.

Thanks for creating this patch, as there does seem to be renewed
interest in such a feature.  I haven't looked closely at it yet, but
wanted to mention that we used to have a "clone" statement in the policy
language that could be used to clone all TE rules from one domain into
another domain, but we ultimately dropped it because we didn't think
that it was the right approach, and that the ability to define shared
sets of permissions among domains via macros was preferable to allow
tailoring of the shared set to specific needs.  Some specific issues
with supporting such a feature in the base language were:

1) Should the child domain inherit all rules that involved the parent
domain at all, or only rules where the parent domain was the
source/subject in the rule?  It looks like you have chosen the former,
but this means that any domain that can act on the parent domain can act
in the same manner on the child domain directly; not clear that this is
always what you want.

2) Should the child domain inherit rules between the parent and the
child, i.e. should the child be able to do anything to itself that the
parent can do to it?  It looks like you are inheriting such rules, but
is this always desirable, e.g. the parent may need permissions to set up
the child, control it, kill it, etc that the child may not need to
itself.

3) What should happen with rules between the parent and itself?  It
looks like you are translating "self" rules to only involve the child
and its descendants, but this would still mean that any explicit rule of
the form "allow parent_t parent_t:process sigkill;" would be inherited
by the child, i.e. "allow child_t parent_t:process sigkill;", right?

4) What should happen with transition rules that involve the parent?  In
some cases, you will likely want to inherit them, but in others, you may
want the child to transition to a separate derived domain from the one
used by the parent. 

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
