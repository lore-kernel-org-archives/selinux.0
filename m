Subject: Re: [PATCH] audit tty selinux permission
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
        Eric Paris <eparis@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1204914187.1397.496.camel@moss-spartans.epoch.ncsc.mil>
References: <200803071224.33871.sgrubb@redhat.com>
	 <1204914187.1397.496.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 13:30:49 -0500
Message-Id: <1204914649.1397.498.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-07 at 13:23 -0500, Stephen Smalley wrote:
> On Fri, 2008-03-07 at 12:24 -0500, Steve Grubb wrote:
> > Hi,
> > 
> > Dan had mentioned that he wanted a new selinux permission to separate 
> > the ability to turn on tty auditing from the ability of setting audit rules.
> > It looks to me like the process that reads also writes, so only one new
> > permission is needed.
> 
> To add a new permission to SELinux:
> 1) checkout a copy of the refpolicy from oss.tresys.com
> 2) cd refpolicy/policy/flask/
> 3) edit access_vectors and add your definition
> 4) run make
> 5) run make LINUX_D=/path/to/linux-2.6 tokern to push the kernel headers
> to your kernel tree
> 6) run make LIBSELINUX_D=/path/to/libselinux tolib to push the
> libselinux headers to your libselinux tree.
> 
> Then you can generate patches against policy, kernel, and libselinux.

This btw ensures that all the necessary files get updated, such as
av_perm_to_string.h, used to get the string form of the permission for
avc audit messages.

> 
> There is also the backward compatibility issue - we must not break
> akpm's system if he boots a new kernel on an existing distro that lacks
> new policy.  So is this likely to break things if he boots a FC5, FC6,
> or F7 system (i.e. anything that predates handle_unknown) with a kernel
> with this patch?
> 
> > Signed-off-by: Steve Grubb <sgrubb@redhat.com>
> > 
> > 
> >  security/selinux/include/av_permissions.h |    1 +
> >  security/selinux/nlmsgtab.c               |    4 ++--
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff -urp linux-2.6.24.x86_64.orig/security/selinux/include/av_permissions.h linux-2.6.24.x86_64/security/selinux/include/av_permissions.h
> > --- linux-2.6.24.x86_64.orig/security/selinux/include/av_permissions.h	2008-03-06 17:13:22.000000000 -0500
> > +++ linux-2.6.24.x86_64/security/selinux/include/av_permissions.h	2008-03-06 17:41:29.000000000 -0500
> > @@ -702,6 +702,7 @@
> >  #define NETLINK_AUDIT_SOCKET__NLMSG_WRITE         0x00800000UL
> >  #define NETLINK_AUDIT_SOCKET__NLMSG_RELAY         0x01000000UL
> >  #define NETLINK_AUDIT_SOCKET__NLMSG_READPRIV      0x02000000UL
> > +#define NETLINK_AUDIT_SOCKET__NLMSG_TTY           0x04000000UL
> >  #define NETLINK_IP6FW_SOCKET__IOCTL               0x00000001UL
> >  #define NETLINK_IP6FW_SOCKET__READ                0x00000002UL
> >  #define NETLINK_IP6FW_SOCKET__WRITE               0x00000004UL
> > diff -urp linux-2.6.24.x86_64.orig/security/selinux/nlmsgtab.c linux-2.6.24.x86_64/security/selinux/nlmsgtab.c
> > --- linux-2.6.24.x86_64.orig/security/selinux/nlmsgtab.c	2008-03-06 17:13:22.000000000 -0500
> > +++ linux-2.6.24.x86_64/security/selinux/nlmsgtab.c	2008-03-06 17:41:09.000000000 -0500
> > @@ -110,8 +110,8 @@ static struct nlmsg_perm nlmsg_audit_per
> >  	{ AUDIT_DEL_RULE,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
> >  	{ AUDIT_USER,		NETLINK_AUDIT_SOCKET__NLMSG_RELAY    },
> >  	{ AUDIT_SIGNAL_INFO,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
> > -	{ AUDIT_TTY_GET,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
> > -	{ AUDIT_TTY_SET,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
> > +	{ AUDIT_TTY_GET,	NETLINK_AUDIT_SOCKET__NLMSG_TTY      },
> > +	{ AUDIT_TTY_SET,	NETLINK_AUDIT_SOCKET__NLMSG_TTY      },
> >  };
> >  
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
