MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH] selinux:  introduce support for deferred mapping of inode security contexts
Date: Fri, 19 May 2006 10:05:04 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015881707C7@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>,
        "Thomas Bleher" <bleher@informatik.uni-muenchen.de>,
        "selinux-dev" <selinux-dev@tresys.com>,
        "James Morris" <jmorris@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
> 
> Stephen Smalley wrote:
> > On Mon, 2006-05-15 at 12:35 -0400, Stephen Smalley wrote:
> >   
> >> With this patch applied, the following sequence is 
> possible, subject 
> >> to policy, which must allow <domain> security_t:security 
> labelpriv; 
> >> and allow unlabeled_t fs_t:filesystem associate; in order 
> for this to 
> >> work in enforcing mode.  Note that unconfined_t implicitly 
> picks up 
> >> all security permissions at present due to the use of a 
> wildcard for 
> >> the permission set in its rule.  However, you still need 
> the second 
> >> allow rule as well in order for this to succeed in enforcing mode.
> >>
> >> # touch foo
> >> # chcon -t foo_exec_t foo
> >> # ls -Z foo
> >> -rw-r--r--  root root system_u:object_r:unlabeled_t    foo
> >> # semodule -i foo.pp # defines foo_exec_t # ls -Z foo
> >> -rw-r--r--  root root user_u:object_r:foo_exec_t       foo
> >> # semodule -r foo
> >> # ls -Z foo
> >> -rw-r--r--  root root system_u:object_r:unlabeled_t    foo
> >> # semodule -i foo.pp
> >> # ls -Z foo
> >> -rw-r--r--  root root user_u:object_r:foo_exec_t       foo
> >>     
> >
> > Eric Paris pointed out that the above behavior violates the 
> principle 
> > of least surprise for users (chcon appears to succeed but 
> leaves the 
> > file with unlabeled_t).  So to clarify:  The intent would be to 
> > exclude labelpriv permission from even unconfined_t and to 
> only allow 
> > it to specific program domains (initially only package manager 
> > domains) where the program expects such behavior and performs some 
> > verification separately once the file context is expected 
> to be valid.  
> > Of course, this requires that rpm_t not be an alias of 
> unconfined_t, 
> > which is true in FC5 (but not in FC4).
> >
> >   
> We already have this problem in targeted with aliases.
> 
> Try
> # ls -lZ /lib/libselinux.so.1
> -rwxr-xr-x  root root system_u:object_r:lib_t          
> /lib/libselinux.so.1
> # chcon -t shlib_t /lib/libselinux.so.1
> # ls -lZ /lib/libselinux.so.1
> -rwxr-xr-x  root root system_u:object_r:lib_t          
> /lib/libselinux.so.1
> 

Another reason why canonicalizing the paths on getxattr() is non-ideal.
Why can't we use an alternate interface for canonicalizing paths
(optionally, if the client wants it).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
