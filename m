Subject: Re: ima-appraisal: CAP_MAC_ADMIN w/SELinux
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <1280325102.12879.18.camel@moss-pluto.epoch.ncsc.mil>
References: 
	 <OF4AB3814C.68684AEB-ON8625771A.0055A68D-8625771A.00587153@us.ibm.com>
	 <1273097271.11502.99.camel@localhost.localdomain>
	 <1275272007.8204.0.camel@localhost.localdomain>
	 <201006010935.15976.sgrubb@redhat.com>
	 <1280233718.19585.33.camel@localhost.localdomain>
	 <1280235897.4789.11.camel@moss-pluto.epoch.ncsc.mil>
	 <1280268498.2427.1.camel@localhost.localdomain>
	 <1280322813.12879.2.camel@moss-pluto.epoch.ncsc.mil>
	 <20100728131742.GB6367@hallyn.com>
	 <1280325102.12879.18.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Jul 2010 10:15:04 -0400
Message-ID: <1280326504.2916.87.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-07-28 at 09:51 -0400, Stephen Smalley wrote:
> On Wed, 2010-07-28 at 08:17 -0500, Serge E. Hallyn wrote:
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > On Tue, 2010-07-27 at 18:08 -0400, Mimi Zohar wrote:
> > > > On Tue, 2010-07-27 at 09:04 -0400, Stephen Smalley wrote:
> > > > > On Tue, 2010-07-27 at 08:28 -0400, Mimi Zohar wrote:
> > > > > > I'm seeing some interesting behavior in ima_inode_setxattr() with an
> > > > > > SELinux targeted policy enabled. Unlike the definition for
> > > > > > CAP_SYS_ADMIN, CAP_MAC_ADMIN does not permit root to write extended
> > > > > > attributes. (Without SELinux enabled, root can write 'security.ima'.)
> > > > > > Is this the intended behavior?
> > > > > > 
> > > > > > Without this permission, restorecond is also unable to write extended
> > > > > > attributes. 
> > > > > > 
> > > > > > kernel: type=1400 audit(1279830569.844:4): avc:  denied  { mac_admin }
> > > > > > for  pid=447 comm="restorecon" capability=33
> > > > > > scontext=system_u:system_r:setfiles_t:s0
> > > > > > tcontext=system_u:system_r:setfiles_t:s0 tclass=capability2
> > > > > > 
> > > > > > /*
> > > > > > * ima_protect_xattr - protect 'security.ima'
> > > > > > *
> > > > > > * Ensure that not just anyone can modify or remove 'security.ima'.
> > > > > > */
> > > > > > int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
> > > > > >                       const void *xattr_value, size_t xattr_value_len)
> > > > > > {
> > > > > >         if ((strcmp(xattr_name, XATTR_NAME_IMA) == 0)
> > > > > >             && !capable(CAP_MAC_ADMIN))
> > > > > >                 return -EPERM;
> > > > > >         return 0;
> > > > > > }
> > > > > > 
> > > > > > Adding the following rules, permits root and restorecond to write
> > > > > > 'security.ima'. 
> > > > > > 
> > > > > > module local-cap 1.0;
> > > > > > 
> > > > > > require {
> > > > > > 	type setfiles_t;
> > > > > > 	type unconfined_t;
> > > > > > 	class capability2 mac_admin;
> > > > > > }
> > > > > > 
> > > > > > #============= setfiles_t ==============
> > > > > > allow setfiles_t self:capability2 mac_admin;
> > > > > > allow unconfined_t self:capability2 mac_admin;
> > > > > 
> > > > > I don't think you should be overloading CAP_MAC_ADMIN in this manner.
> > > > > The ability to set IMA attributes is not equivalent to the ability to
> > > > > administer Smack, nor to get/set raw on-disk attributes in SELinux.
> > > > > 
> > > > > We only allow mac_admin in policy to a specialized domain for e.g.
> > > > > livecd creation.  Normal admin of SELinux is handled through its
> > > > > existing fine-grained permission checks without any dependency on
> > > > > CAP_MAC_ADMIN.  
> > > > 
> > > > With CAP_SYS_ADMIN, root is able to write xattrs, but restorecond is
> > > > still having problems:
> > > > 
> > > > type=1400 audit(1280268030.225:709): avc:  denied  { sys_admin } for
> > > > pid=1004 comm="restorecon" capability=21
> > > > scontext=system_u:system_r:setfiles_t:s0
> > > > tcontext=system_u:system_r:setfiles_t:s0 tclass=capability
> > > > 
> > > > Mimi
> > > 
> > > Why would restorecon/setfiles be setting the IMA attributes?
> > > Did you modify the application to do this?
> > 
> > I haven't seen it, but assumed that she did in fact modify the apps to
> > update the measurements...  And if that's the case, then perhaps a new
> > CAP_INTEGRITY_VIOLATE capability is appropriate after all.
> 
> Can someone clarify exactly how the security.ima attribute is supposed
> to be initialized and maintained over time?  

Anything the LSM permits to be written/updated, on file close, IMA
writes security.ima, of course based on the IMA policy.  Currently, the
default appraisal policy is to appraise files owned by root.

> And likewise for
> security.evm.  linux-ima.sourceforge.net and the patches left me with
> the impression that it is handled internally by the kernel
> (ima_appraise=fix followed by find / ...).  Has that changed?

For a new file, security.evm is based on the LSM label. There after,
whenever any of the EVM protected security xattrs are written,
security.evm is updated.

To initially label the system, either on initial install, or anytime
there after, booting with the command line 'ima_appraise=fix' option
will cause security.ima to be written, which in turn will cause
security.evm to be written.

> If you are taking the initialization of the attributes to userspace,
> then rpm seems a better target than setfiles/restorecon.  Even for the
> SELinux attribute, it is usually initialized by rpm these days as part
> of package install - setfiles/restorecon is only used as a fallback when
> things go wrong or you switch from selinux-disabled to selinux-enabled
> after install.

Userspace doesn't per-se update the xattrs, but opening/writing the file
does. So either having rpm write security.ima/security.evm directly, or
simply installing with 'ima_appraise=fix' should work. 

Mimi


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
