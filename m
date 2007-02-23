Subject: Re: Several SELinux questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dave Quigley <dquigley+selinux@gmail.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <f888952b0702221634h3a673ee5v1cc92722f60ced56@mail.gmail.com>
References: <f888952b0702221634h3a673ee5v1cc92722f60ced56@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 09:38:09 -0500
Message-Id: <1172241489.19041.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-22 at 19:34 -0500, Dave Quigley wrote:
>     My first question is if it is possible to query what the relabel
> context for a path should be using one of the selinux libraries and a
> policy module?

We've previously talked about a variant of matchpathcon(3) that would
act on a policy module (in the context of how to handle rpm selinux
integration for per-package policy).  It wouldn't be difficult to write
a program that splits out a .pp file into its components
(semodule_unpackage, see list archives for a start at one), takes
the .fc file and combines with it the base system policy (as you need
fallbacks for when the file doesn't match something specifically in the
per-module .fc file), and then applies matchpathcon to that result (you
can already tell matchpathcon to take input from a particular file via
matchpathcon_init).

But the preferred approach is to install the policy module first, then
use matchpathcon(3) as it exists today, so that you get the full file
contexts configuration for the entire set of policy modules.

>  I am working on a high level language for selinux that
> uses the reference policy as a base to work on top of. Because of this
> I need to make use of the types that already exist. For instance I
> don't want to rely on the current state of the system to determine
> that the type for /tmp should be tmp_t. An example I have for this is
> the ability for a policy writer to say that he wants a set of isolated
> tmp files. This means it can't use the default type tmp_t however by
> placing the constraint on the developer that he will be placing his
> files in a directory labeled with tmp_t I can generate the policy code
> to do several things. First we can generate a type without the policy
> developer having to be too conscious of it. Second we can generate the
> transition rules that are needed to make sure the files created in a
> tmp_t directory are labeled properly. Finally the developer specifies
> what kinds of objects he will want to act upon and in what manner and
> we generate the appropriate AV rules.

I'm not sure how this relates to your question, because the context for
a newly created file is computed from the context of the creator and the
context of the parent directory based on type transition rules, vs. a
pathname-based install-time relabeling that uses matchpathcon.  You can
query for information about such transitions via
security_compute_create(3), which internally maps to the kernel's
security_transition_sid() function.

>     My second question is how do we handle things such as shell
> scripts and interpreted languages inside policy? I remember hearing
> somewhere that we just run programs such as the java and python
> interpreters as unconfined. I am not really sure if it is possible to
> have java programs and other interpreted programs constricted under
> SELinux since we do need to grant the interpreter privileges to do
> quite a few things without making the interpreters aware of selinux
> security contexts in addition to normal security controls.

Not sure what you are asking here.  By default, a program runs in the
caller's domain unless a domain transition from the calling domain to a
new domain on the executable type, so that applies to both interpreted
scripts/programs and native binaries.  Many programs (both interpreted
and otherwise) run in the user's own domain since they don't require
distinct permissions, whether the user's domain is unconfined (as in
targeted) or user_t/staff_t/sysadm_t (as in strict).   Unlike suid/sgid
execution, we do support domain transitions on interpreted
scripts/programs, but with the understanding that you must trust the
caller's domain more than the script/program's domain since there is a
fundamental race there and since scripts are so susceptible to caller
influence.  Wrapper binaries are a possible countermeasure.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
