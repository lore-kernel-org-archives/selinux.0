MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Are the reference policy abstractions the right ones?
Date: Tue, 9 Oct 2007 14:18:26 -0400
Message-ID: <1191953906.13098.92.camel@gorn>
In-Reply-To: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
References: <1191942521.2794.89.camel@moss-lions.epoch.ncsc.mil>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <jwcart2@tycho.nsa.gov>
Cc: "SELinux" <selinux@tycho.nsa.gov>, "Steve Smalley" <sds@epoch.ncsc.mil>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-09 at 11:08 -0400, James Carter wrote:
> I would like to start a discussion on whether reference policy is
> providing the right abstractions for writing policy.
> 
> This is not intended to be an attack on Chris or Dan, or their work.  I
> think that it is obvious that reference policy is much better organized,
> far more useful, and works way better than the old example policy.  We
> don't want to go back to example policy.
> 
> One of the goals of reference policy is to provide a more modern feel to
> the policy by eliminating the use of types in a global manner across the
> whole policy.  It does this by allowing interfaces to be defined through
> which permissions can be granted to the types of a module.  There seems
> to be several problems with this.
> 
> 1) The user is constantly presented with types.  They are in the audit
> logs, when the label of a process or file is displayed, and even in the
> man pages ("Set cgi scripts with httpd_sys_script_exec_t to allow them
> to run with access to all sys types.")

One thing that has been discussed is adding documentation for types.  I
suspect you're looking for something more than that.

> 2) We have traded needing to know about 2500 types or so to write
> policy, for needing to know around 4000 interfaces.  And no, I don't
> think that SELinux Clippy is the answer.

Well to be fair, about half of those interfaces are due to corenetwork.
At this point, I can't see a way to abstract most of corenetwork's
access, and we probably don't want to.  Its already at a level that most
admins understand, since they understand firewalls.

> 3) We don't need to abstract class and permissions, because they don't
> change very much, but frequently the interfaces consist of only a few
> allow rules.  Over 60% of the interfaces have only one line (not
> counting gen_require or refpolicywarn lines).
> Lines   # of Interfaces
>      0    53	These only have a refpolicywarn line
>      1  3080    Around 300 of these consist of a single dontaudit rule

I would expect that a large number of these are now implemented with
policy pattern macros.  As for the dontaudits, thats been problematic.
There definitely have been cases where a dontaudit has clearly come from
an enforcing machine.

For example, say a domain is reading a file, but it first stat()s it.
For whatever reason we want to dontaudit this.  On an enforcing system
we would just see the getattr denial since the program would probably
not try to open the file.  On a permissive system, we would get both
messages.  What we really want to do is dontaudit getattr and read, but
only a getattr dontaudit was written since we're on an enforcing system,
and never saw the read denial.  One example of this that comes to mind
is related to /proc/pid access.  Some might just dontaudit the directory
search, others might dontaudit that plus the read of the files.  I'd
like to fix things like this, but its not exactly easy to do without
auditing all dontaudits.

> I think that we need:
> 
> 1) A way to say, "I want a domain like that one, without this
> permission, but with that one".  I think that inheritance is the answer,
> because a macro requires you to know ahead of time that someone might be
> interested in making something similar.  I believe that Karl tried to
> start a discussion on inheritance a month ago, but there wasn't any
> interest.  Let's restart that discussion.  I think that whether through
> macros or inheritance, a rule to remove permissions is needed, because
> without one, we have to get the base classes or macros perfect.

I'm going to stay silent on this for the moment, I don't know how this
would work.

> 2) A way to export types in some manner that would still allow
> flexibility in renaming or splitting a type locally, without having to
> change the global name.  That global name would also have to be what
> shows up in audit logs and other things.  Maybe this is impossible and
> we are just stuck treating types as global entities.

In general, this is counter to refpolicy, as it would allow the access
for a module to be defined somewhere other than where the type is owned.
That being said, it may be acceptable in a very specific instance, where
you are directly calling a template defined in another module, and then
want to add on access to a type it creates.  An example would be at the
bottom of apcupsd.te, where an apache template is used and then access
is added onto some of the generated types, despite apcupsd not actually
knowing the name of the types created by the template.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
