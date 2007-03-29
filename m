Subject: Re: SELinux cache.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <25193.15470.qm@web86909.mail.ukl.yahoo.com>
References: <25193.15470.qm@web86909.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 09:38:25 -0400
Message-Id: <1175175505.3864.548.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-29 at 14:33 +0100, JanuGerman wrote:
> Hi Stephen,
> 
> 
> > $ cat test.te
> > policy_module(test, 1.0)
> > 
> > require {
> >         attribute domain;
> >         attribute file_type;
> > }
> > 
> > auditallow domain file_type:dir_file_class_set *;
> > $ make -f /usr/share/selinux/devel/Makefile
> > $ su -
> > # semodule -i test.pp
> > # tail -f /var/log/audit/audit.log
> > 
> > But be warned that this will generate a lot of
> > audit.
> > To remove, use:
> > # semodule -r test
> > 
> 
> I am having some problems now with this module. I
> added this module, after restart, there were alot of
> messages, saying "audit ... maximum size=256 size
> exceeded".

Curious - I was able to insert it on a FC6 system, generating some audit
data, and then removed it.  But I wouldn't recommend trying to boot up
with it enabled - as I said, it will generate a ton of audit data since
it would trigger an audit message on every allowed file access.  Not
sure what limitations auditd imposes - I haven't seen that maximum size
message before.

>  The messages were not stopping so, I
> rebooted the system with selinux disabled and tried to
> remove this module.

You said "tried to remove this module."  Does that mean you did or did
not successfully run "semodule -r test"?  Should have been possible to
do without disabling SELinux; you could have booted single user.

> But now, when i reboot, the system hangs at starting
> "udev" service MAKEDEV: mkdir: FILE exists ...saying
> an error occured during file system check, dropping
> you to shell, ... give root password for maintaine....
> 
> My system have e compiled kernels, but non of them is
> rebooting with SElinux.
> 
> Can i recover the SELinux again while rebooted without
> SElinux? or this means, the system is not usable any
> more.

Boot with 'enforcing=0 single', then run 'fixfiles relabel' if it
doesn't automatically relabel, then reboot normally.

Disabling SELinux will leave you with unlabeled files that need to be
relabeled.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
