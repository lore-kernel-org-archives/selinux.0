Subject: Re: preserving user-set contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1082752649.12608.111.camel@nexus.verbum.private>
References: <1082752649.12608.111.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1082989812.22940.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 26 Apr 2004 10:30:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-04-23 at 16:37, Colin Walters wrote:
> What I think would be nice is if we had chcon set another extended
> attribute that marked the file as having its context manually set.  Then
> we modify setfiles to ignore files which have this extended attribute by
> default.  That way I could use 'make relabel' to fix system contexts,
> and leave my customizations intact.

It wouldn't be safe to allow untrusted users to mark files in this
manner, as it could prevent proper relabeling of the filesystem upon a
policy update.  So you would have to limit it to administrators anyway. 
And if they are administrators, they can already mark the files with
<<none>> in the file contexts configuration.  You could also introduce a
separate type in the policy that setfiles doesn't have permission to
relabelfrom, and use that type for this purpose.

> Is this desirable?  Does it seem like the right approahc?  One question
> is - which namespace to put it in?  user.?  system.?  If we allow
> regular users to relabel (as we already do for files like
> httpd_user_script_exec_t) then we can only put it in the user.
> namespace.

I don't think it is the right approach.  But note that the security
namespace is easily extensible, so you can create additional security
attributes in it for other purposes without requiring changes to the
kernel.  Use of the security namespace requires CAP_SYS_ADMIN except for
the SELinux attribute, which has its own finer-grained permissions.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
