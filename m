Subject: RE: Policy compiler issues.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Bush, Daniel" <Daniel.Bush@boeing.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <E7E29FA7C732D146887C784B34AEF6A0044E412B@xch-ne-01.ne.nos.boeing.com>
References: 
	 <E7E29FA7C732D146887C784B34AEF6A0044E412B@xch-ne-01.ne.nos.boeing.com>
Content-Type: text/plain
Message-Id: <1085070079.521.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 12:21:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 11:54, Bush, Daniel wrote:
> >How do you plan on distributing updates to the users list and user-role authorizations?
>    As it stands the whole system needs to weigh in at less than about
> 64M with smaller being MUCH better (32M would be ideal.) So you can
> see, there's not much room for a full compiler/linker suite.

Just to clarify, we aren't talking about a full compiler/linker suite. 
The policy compiler is just a specialized compiler for the policy
language.  And you can always recompile the policy on a "policy build
machine" and push the new binary policy to all of your embedded systems
via some mechanism, so you really only need load_policy on the embedded
systems.  load_policy is a trivial program; just opens and mmap's the
binary policy file and writes it to /selinux/load to feed it to the
kernel.

$ size /usr/sbin/load_policy
   text    data     bss     dec     hex filename
   2739     316       0    3055     bef /usr/sbin/load_policy

>     "user_u" isn't really the problem. The other, higher orders are.
> The specification calls for a couple of new user classes (I'm pretty
> sure I can institute those.) and those  classes have a forseeable need
> to have their membership lists changed in the field. If we need to
> re-compile the policy when that happens, this presents a problem.

If you set up an infrastructure that lets you rebuild policy on a
"policy build machine" and then push out the binary policy to all of
your embedded systems upon user database updates, I'm not sure that this
is a real issue.  

The alternative is to implement support for generic user identity
mapping in libselinux's get_ordered_context_list function beyond the
simple user_u support that exists today, define a set of generic user
identities one per role (staff_u, sysadm_u, etc) that are authorized for
that role, and have libselinux map all real users to one of these
generic user identities based on some other criteria (e.g. is the real
user in a particular group in the NIS map?).  That pushes responsibility
for enforcing user-role restrictions up into libselinux and ultimately
to your user database server, so you obviously need to provide
appropriate protection there.

> This sounds promising... Could you please direct me to the date range of the messages you're referring to?

http://marc.theaimsgroup.com/?l=selinux&m=106453351114046&w=2
http://marc.theaimsgroup.com/?l=selinux&m=105459714906101&w=2

The binary policy patch tools are out-of-date, and should be obsoleted
by newer work going on at Tresys to support direct manipulation of
binary policies.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
