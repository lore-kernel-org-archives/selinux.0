Subject: Re: Confirmation about task_has_security in selinuxfs.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <288183.63596.qm@web86910.mail.ukl.yahoo.com>
References: <288183.63596.qm@web86910.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 13:26:58 -0400
Message-Id: <1173806818.2068.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-13 at 17:08 +0000, JanuGerman wrote:
> >From the discussion on this list and on the
> linux-security-module, i deduce (kindly correct me, if
> i am wrong) that the best option is not to have
> another security LSM stacked to SELinux.

Correct.

> The remaining option with me, is that to include my
> own module call within the fs/namei.c:permission(),
> after the selinux_inode_permission() and/or
> security_inode_permission() call.

The first question to ask is what are you trying to do with your module,
and could it be done through configuration of the existing SELinux
mechanism?  If so, you get to leverage all of the work that has gone
into SELinux to date and all the work that will continue to go into it
in the future.  Not only kernel work, but also userland integration,
policy development, policy tools, policy management infrastructure, etc.

Then, if SELinux truly can't provide what you need as is, the next
logical question is whether you could implement your extension as part
of the SELinux security server (interface defined by
security/selinux/include/security.h, code under security/selinux/ss/)
without requiring any changes to that interface, as the interface was
designed to support many different security models.  If so, you don't
need to modify anything outside of the ss/ subdirectory and you get to
leverage all of the rest of the SELinux kernel and userland support
unmodified.  Even if you do have to modify the security server interface
somewhat, if you can limit yourself to a small extension to that
interface and keep the bulk of your changes localized to the security
server, you reduce your divergence from mainline SELinux and thus
maximize your ability to leverage its existing facilities.

Only if neither of those avenues suffice should you consider modifying
the SELinux hook functions, the LSM hooks, or the core kernel.  And
naturally you would seek to do it in the least invasive manner possible,
so if you can do it within the SELinux hook functions, that would be
least invasive.

> For this, does i need some special procedure to follow
> to register my own module with Linux kernel, or a
> simple call to some module will be sufficed, followed
> by the kernel re-compilation. This way, there will be
> no conflict between the LSM of SELinux and a custom
> security module in my opinion.

Depends on your approach above and whether you are creating a general
facility for all such "modules" or just adding your own code.  We
wouldn't encourage arbitrary hooking of SELinux.

> Further, within the security folder in the kernel
> tree, the 2.6.20 linux kernel distribution is shipped
> with a file root_plug.c (written by Greg
> Kroah-Hartman), which is a classic introduction to
> Linux Security Modules (LSM). The folder also contains
> the folder of SELinux. In this context, whether
> root_plug.c security module is stacked with the
> SELinux security module or not.

We don't use root_plug, and it was only written as a toy example of a
LSM by Greg, not intended for production use.  You might be able to
stack it by virtue of the fact that it doesn't use the security fields,
but I don't why you would do so.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
