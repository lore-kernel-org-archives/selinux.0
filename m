Subject: Re: Loadable Modules and RPM
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, James Morris <jmorris@redhat.com>,
   Jeremy Katz <katzj@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <4346D351.3070202@redhat.com>
References: <4346D351.3070202@redhat.com>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 17:30:32 -0400
Message-Id: <1128720632.1450.130.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 15:58 -0400, Daniel J Walsh wrote:
> Two problems have always existed with this:
> First it eliminates the possibility of having different policies for 
> different policy types.  IE it makes it harder to have a apache_targeted 
> policy or apache_mls policy.  In practice this is not such a big thing 
> since the "Targeted" or server based
> policies are mostly common across the currently defined policies.  We 
> have one apache policy for Targeted, Strict and MLS with minor tweaks.  
> The new policy language has the ability to divine optional sections to 
> take care of these differences.

What about introducing a level of indirection by having apache (httpd)
depend on a separate httpd-policy package, and likewise for other
packages that have associated policy modules?  I think Hardened Gentoo
did something along those lines.

> The Second problem involves file context.  Basically the kernel has to 
> know the file_context before rpm lays the files down on disk.  Because 
> it verifies that system_u:object_r:httpd_exec_t exists.  So applications 
> need to install/reload policy before the files get put on disk.  What 
> would happen if we changed the kernel to allow certain privileged 
> applications to write security context onto disk, which the kernel does 
> not understand.  The kernel could just treat these files as 
> unlabeled_t.  Then the RPM package could contain the file_context to 
> place on disk, install the files with the correct context.  In the post 
> install script it could add its policy  and load it into the kernel.  At 
> which point the kernel would understand the file context.

That makes it more difficult to ever confine rpm in any way.  It also is
problematic on the kernel side even if we wanted this behavior; the
kernel doesn't presently recheck the security contexts of already incore
inodes upon a policy reload.  If they have a SID that is invalidated by
the policy load, then they will subsequently be treated as unlabeled,
but if they start as unlabeled and then you add the type via a policy
reload, the incore inode label won't be reset until they are evicted
from memory and re-acquired by a lookup.

I think you need to reload policy first, and it will be easier to do so
if you separate out the policy into its own package, just one per
application package, ala httpd-policy.  Ideally, you'd allow a way for
httpd-policy to be provided by multiple packages, so we could have
httpd-mls-policy, httpd-targeted-policy, httpd-strict-policy.  I'm not
sure that the module ifopt support is going to be enough for those kinds
of differences.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
