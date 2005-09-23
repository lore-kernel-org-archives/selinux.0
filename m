Subject: Re: More Debian bugs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dale Amon <amon@vnl.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <20050923195227.GA21546@vnl.com>
References: <20050923195227.GA21546@vnl.com>
Content-Type: text/plain
Date: Fri, 23 Sep 2005 16:10:32 -0400
Message-Id: <1127506232.27851.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-23 at 20:52 +0100, Dale Amon wrote:
> As I plough onwards... with last nights set of hacks
> I was able to label files today. But that is about it.
> The latest debian packaged kernel turns out to have
> POLICYVERS=19 in security.h. However, the selinux-policy-default
> package builds a policy.20. 

You can change it to build policy.19 by adding the -c 19 option to
checkpolicy.  Attached policy Makefile diff from upstream CVS causes it
to build both versions and load the right one.

> I have other error messages which may or may not
> follow from that problem. When I attempt a load_policy:
> 
> sepol_genusers: can't find system.users
> No such file or directory
> unable to get boolean names: No surc file or directory

That's technically ok; load_policy will fall back to just the raw binary
policy image if those files don't exist.  But the Debian policy package
should create them nonetheless, like the Fedora one.

> I also note there are some dangling softlinks created
> by the setools package:
> 
> /usr/share/setools/
> lrwxrwxrwx  1 root root     24 2005-09-23 18:18 seaudit-report.conf -> /etc/seaudit-report.conf
> lrwxrwxrwx  1 root root     23 2005-09-23 18:18 seaudit-report.css -> /etc/seaudit-report.css
> lrwxrwxrwx  1 root root     16 2005-09-23 18:18 seuser.conf -> /etc/seuser.conf
> 
> But the targets are not at those locations, they are:
> /etc/setools/
> -rw-r--r--  1 root root 2805 2005-09-15 08:29 seaudit-report.conf
> -rw-r--r--  1 root root 3040 2005-09-15 08:29 seaudit-report.css
> -rw-r--r--  1 root root 1815 2005-09-15 08:29 seuser.conf

Hmmm...on Fedora, they aren't symlinks and there is no /etc/setools.
You may just want to grab the latest upstream tarball for setools from
Tresys and build it directly.  But note that setools is purely optional;
it is not required for operation of SELinux at all.  

> Although I have not looked at Stephens patches, I
> would very much be surprised if I could just change
> the defines in security.h, rebuild the kernel and
> have it work...

No, but checkpolicy always provides backwards compatibility via the -c
option, so you can just build via checkpolicy -c 19 -o policy.19
policy.conf. 

> I've got a bad feeling that the debian kernel
> (2.6.12-1-686) is using a very out of date 
> selinux patch set.

It should still be useable.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
