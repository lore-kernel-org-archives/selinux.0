Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2DH8h9X028240
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 13:08:43 -0400
Received: from web86910.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2DH8fmD019106
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 17:08:41 GMT
Date: Tue, 13 Mar 2007 17:08:40 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: Confirmation about task_has_security in selinuxfs.c
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1173798480.2068.51.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <288183.63596.qm@web86910.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,

Thanks for the response.


>From the discussion on this list and on the
linux-security-module, i deduce (kindly correct me, if
i am wrong) that the best option is not to have
another security LSM stacked to SELinux.

The remaining option with me, is that to include my
own module call within the fs/namei.c:permission(),
after the selinux_inode_permission() and/or
security_inode_permission() call.

For this, does i need some special procedure to follow
to register my own module with Linux kernel, or a
simple call to some module will be sufficed, followed
by the kernel re-compilation. This way, there will be
no conflict between the LSM of SELinux and a custom
security module in my opinion.

Further, within the security folder in the kernel
tree, the 2.6.20 linux kernel distribution is shipped
with a file root_plug.c (written by Greg
Kroah-Hartman), which is a classic introduction to
Linux Security Modules (LSM). The folder also contains
the folder of SELinux. In this context, whether
root_plug.c security module is stacked with the
SELinux security module or not.

Thank You,
MA








--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2007-03-13 at 15:01 +0000, JanuGerman wrote:
> > Hi Stephen,
> > 
> > Is the following lines in the selinuxfs.c that
> gets
> > the final decision from the security server:
> > 
> > length = security_compute_av(ssid, tsid, tclass,
> req,
> > &avd);
> >         if (length < 0)
> >                goto out2;
> > ...
> 
> For that particular call, yes.
> 
> > Actually, i am intrested in locating the last
> point at
> > which the selinuxfs.c communicates with the
> security
> > server for an access decision (no matter cached or
> > not) and then conveys back the decision to the LSM
> > hook.
> 
> You seem to misunderstand the purpose of selinuxfs. 
> selinuxfs is a
> pseudo filesystem interface between applications and
> the SELinux kernel
> module.  It isn't used by the LSM hooks called by
> the kernel.  The hook
> functions are implemented in
> security/selinux/hooks.c.
> 
> > Alternatively, the point, at which the DAC checks
> are
> > again checked by the LSM hook, which query the
> SElinux
> > LSM. I have checked the "security.c", which
> contains
> > the SELinux LSM hook registration but did not
> succeed
> > to locate the point, where all these calls are
> taking
> > place.
> 
> Perhaps an example would make things clearer. 
> During open(2)
> processing, the fs/namei.c:permission() function is
> called to check
> permissions.  That function first applies the usual
> Linux checks,
> including DAC checks, and, if they pass, the
> function then calls the LSM
> security_inode_permission() hook, which is defined
> by
> include/linux/security.h.  If using SELinux, this
> hook will call
> selinux_inode_permission() in
> security/selinux/hooks.c, which calls
> inode_has_perm(), which calls avc_has_perm() in
> security/selinux/avc.c.
> That is the access vector cache.  If there is a
> cache miss, then
> avc_has_perm_noaudit() in avc.c will call
> security_compute_av() to get
> the decision from the security server.  selinuxfs is
> not involved in
> that code path.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the
> selinux mailing list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as
> the message.
> 



		
___________________________________________________________ 
All New Yahoo! Mail – Tired of unwanted email come-ons? Let our SpamGuard protect you. http://uk.docs.yahoo.com/nowyoucan.html


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
