Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        SELinux-dev@tresys.com, James Morris <jmorris@redhat.com>
In-Reply-To: <446DCF2D.9020902@redhat.com>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <1148046296.25168.89.camel@moss-spartans.epoch.ncsc.mil>
	 <446DCF2D.9020902@redhat.com>
Content-Type: text/plain
Date: Fri, 19 May 2006 10:14:09 -0400
Message-Id: <1148048049.25168.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-19 at 09:59 -0400, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > On Mon, 2006-05-15 at 12:35 -0400, Stephen Smalley wrote:
> >   
> >> With this patch applied, the following sequence is possible, subject to
> >> policy, which must allow <domain> security_t:security labelpriv; and
> >> allow unlabeled_t fs_t:filesystem associate; in order for this to work
> >> in enforcing mode.  Note that unconfined_t implicitly picks up all
> >> security permissions at present due to the use of a wildcard for the
> >> permission set in its rule.  However, you still need the second allow
> >> rule as well in order for this to succeed in enforcing mode.  
> >>
> >> # touch foo
> >> # chcon -t foo_exec_t foo
> >> # ls -Z foo
> >> -rw-r--r--  root root system_u:object_r:unlabeled_t    foo
> >> # semodule -i foo.pp # defines foo_exec_t
> >> # ls -Z foo
> >> -rw-r--r--  root root user_u:object_r:foo_exec_t       foo
> >> # semodule -r foo
> >> # ls -Z foo
> >> -rw-r--r--  root root system_u:object_r:unlabeled_t    foo
> >> # semodule -i foo.pp
> >> # ls -Z foo
> >> -rw-r--r--  root root user_u:object_r:foo_exec_t       foo
> >>     
> >
> > Eric Paris pointed out that the above behavior violates the principle of
> > least surprise for users (chcon appears to succeed but leaves the file
> > with unlabeled_t).  So to clarify:  The intent would be to exclude
> > labelpriv permission from even unconfined_t and to only allow it to
> > specific program domains (initially only package manager domains) where
> > the program expects such behavior and performs some verification
> > separately once the file context is expected to be valid.  Of course,
> > this requires that rpm_t not be an alias of unconfined_t, which is true
> > in FC5 (but not in FC4).
> >
> >   
> We already have this problem in targeted with aliases.
> 
> Try
> # ls -lZ /lib/libselinux.so.1
> -rwxr-xr-x  root root system_u:object_r:lib_t          /lib/libselinux.so.1
> # chcon -t shlib_t /lib/libselinux.so.1
> # ls -lZ /lib/libselinux.so.1
> -rwxr-xr-x  root root system_u:object_r:lib_t          /lib/libselinux.so.1

Not quite the same issue.  In that case, shlib_t is a valid type; it
just happens to be aliased to lib_t in targeted policy.  So the user
gets the expected behavior, i.e. the file becomes accessible under the
rules associated with that type.  And if the user enters a type that is
completely undefined by the policy, he still gets an error.

With labelpriv, if user has a simple typo (e.g. http_sys_content_t
instead of httpd_sys_content_t), he gets no error from chcon, and that
string is stored with the file, but the file is treated internally as
unlabeled_t.  Thus it is _not_ accessible under the rules associated
with the type he meant to apply.

In any event, as long as we exclude this permission (via ~labelpriv or
by explicitly enumerating the allowed security permissions) from
unconfined_t going forward, it shouldn't be a problem.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
