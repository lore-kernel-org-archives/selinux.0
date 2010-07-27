Date: Tue, 27 Jul 2010 15:38:23 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: ima-appraisal: CAP_MAC_ADMIN w/SELinux
Message-ID: <20100727203823.GA2884@hallyn.com>
References: <OF4AB3814C.68684AEB-ON8625771A.0055A68D-8625771A.00587153@us.ibm.com>
 <1273097271.11502.99.camel@localhost.localdomain>
 <1275272007.8204.0.camel@localhost.localdomain>
 <201006010935.15976.sgrubb@redhat.com>
 <1280233718.19585.33.camel@localhost.localdomain>
 <1280235897.4789.11.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280235897.4789.11.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Tue, 2010-07-27 at 08:28 -0400, Mimi Zohar wrote:
> > I'm seeing some interesting behavior in ima_inode_setxattr() with an
> > SELinux targeted policy enabled. Unlike the definition for
> > CAP_SYS_ADMIN, CAP_MAC_ADMIN does not permit root to write extended
> > attributes. (Without SELinux enabled, root can write 'security.ima'.)
> > Is this the intended behavior?
> > 
> > Without this permission, restorecond is also unable to write extended
> > attributes. 
> > 
> > kernel: type=1400 audit(1279830569.844:4): avc:  denied  { mac_admin }
> > for  pid=447 comm="restorecon" capability=33
> > scontext=system_u:system_r:setfiles_t:s0
> > tcontext=system_u:system_r:setfiles_t:s0 tclass=capability2
> > 
> > /*
> > * ima_protect_xattr - protect 'security.ima'
> > *
> > * Ensure that not just anyone can modify or remove 'security.ima'.
> > */
> > int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
> >                       const void *xattr_value, size_t xattr_value_len)
> > {
> >         if ((strcmp(xattr_name, XATTR_NAME_IMA) == 0)
> >             && !capable(CAP_MAC_ADMIN))
> >                 return -EPERM;
> >         return 0;
> > }
> > 
> > Adding the following rules, permits root and restorecond to write
> > 'security.ima'. 
> > 
> > module local-cap 1.0;
> > 
> > require {
> > 	type setfiles_t;
> > 	type unconfined_t;
> > 	class capability2 mac_admin;
> > }
> > 
> > #============= setfiles_t ==============
> > allow setfiles_t self:capability2 mac_admin;
> > allow unconfined_t self:capability2 mac_admin;
> 
> I don't think you should be overloading CAP_MAC_ADMIN in this manner.

I'd originally suggested CAP_MAC_ADMIN since evm seems like a mac thing.
But of course we don't want to end up giving away more privilege as a
result, so I'm fine with going back to CAP_SYS_ADMIN.

Heck we could introduce CAP_INTEGRITY_VIOLATE...  except i'm not in the
mood to complicate things (and by 'things' i mean capability.h) today.

> The ability to set IMA attributes is not equivalent to the ability to
> administer Smack, nor to get/set raw on-disk attributes in SELinux.
> 
> We only allow mac_admin in policy to a specialized domain for e.g.
> livecd creation.  Normal admin of SELinux is handled through its
> existing fine-grained permission checks without any dependency on
> CAP_MAC_ADMIN.  
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
