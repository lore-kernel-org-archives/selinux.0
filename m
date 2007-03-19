Subject: Re: Confirmation about task_has_security in selinuxfs.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <574941.32780.qm@web86909.mail.ukl.yahoo.com>
References: <574941.32780.qm@web86909.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 08:36:49 -0400
Message-Id: <1174307809.22565.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-14 at 06:25 +0000, JanuGerman wrote:
> > The first question to ask is what are you trying to
> > do with your module,
> 
> I was intrested in LSM Stacking for my project. On
> this line, i found that SELinux is also built using
> LSM, and some kind of stacking mechanism is possible
> with SELinux, though, this assumption proved it self
> wrong.
> 
> Is this possible, to compile the SELinux LSM without
> Kernel re-compilation (may be a stupid question).
> Because it takes too much time to recompile the kernel
> each time, a change is made.

SELinux is necessarily built-in, so you cannot rebuild it separately (as
you can do for genuine loadable kernel modules).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
