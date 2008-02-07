Date: Thu, 7 Feb 2008 11:04:10 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH] selinux:  support 64-bit capabilities
In-Reply-To: <1202322530.27371.171.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0802071102420.5800@us.intercode.com.au>
References: <1202314924.27371.163.camel@moss-spartans.epoch.ncsc.mil>
 <1202322530.27371.171.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Feb 2008, Stephen Smalley wrote:

> 
> > +	switch (CAP_TO_INDEX(cap)) {
> > +	case 0:
> > +		sclass = SECCLASS_CAPABILITY;
> > +		break;
> > +	case 1:
> > +		sclass = SECCLASS_CAPABILITY2;
> > +		break;
> > +	default:
> > +		return -EPERM;
> 
> Should likely make this something like:
> 	printk(KERN_WARNING "SELinux:  unknown capability %d\n", cap);
> 	if (selinux_enforcing)
> 		return -EPERM;
> 	else
> 		return 0;
> 
> Then, if/when people introduce capabilities without updating SELinux,
> we'll get a warning but permissive mode will allow the operation to
> proceed.

Agreed, perhaps also suggest upgrading policy in the message.


> 
> > +	}
> > +	return avc_has_perm(tsec->sid, tsec->sid, sclass, av, &ad);
> >  }
> >  
> >  /* Check whether a task is allowed to use a system operation. */
> > diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
> > index 399f868..d569669 100644
> > --- a/security/selinux/include/av_perm_to_string.h
> > +++ b/security/selinux/include/av_perm_to_string.h
> > @@ -132,6 +132,9 @@
> >     S_(SECCLASS_CAPABILITY, CAPABILITY__LEASE, "lease")
> >     S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_WRITE, "audit_write")
> >     S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_CONTROL, "audit_control")
> > +   S_(SECCLASS_CAPABILITY, CAPABILITY__SETFCAP, "setfcap")
> > +   S_(SECCLASS_CAPABILITY2, CAPABILITY2__MAC_OVERRIDE, "mac_override")
> > +   S_(SECCLASS_CAPABILITY2, CAPABILITY2__MAC_ADMIN, "mac_admin")
> >     S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_READ, "nlmsg_read")
> >     S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_WRITE, "nlmsg_write")
> >     S_(SECCLASS_NETLINK_FIREWALL_SOCKET, NETLINK_FIREWALL_SOCKET__NLMSG_READ, "nlmsg_read")
> > diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
> > index 84c9abc..75b4131 100644
> > --- a/security/selinux/include/av_permissions.h
> > +++ b/security/selinux/include/av_permissions.h
> > @@ -533,6 +533,9 @@
> >  #define CAPABILITY__LEASE                         0x10000000UL
> >  #define CAPABILITY__AUDIT_WRITE                   0x20000000UL
> >  #define CAPABILITY__AUDIT_CONTROL                 0x40000000UL
> > +#define CAPABILITY__SETFCAP                       0x80000000UL
> > +#define CAPABILITY2__MAC_OVERRIDE                 0x00000001UL
> > +#define CAPABILITY2__MAC_ADMIN                    0x00000002UL
> >  #define NETLINK_ROUTE_SOCKET__IOCTL               0x00000001UL
> >  #define NETLINK_ROUTE_SOCKET__READ                0x00000002UL
> >  #define NETLINK_ROUTE_SOCKET__WRITE               0x00000004UL
> > diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
> > index b1b0d1d..bd813c3 100644
> > --- a/security/selinux/include/class_to_string.h
> > +++ b/security/selinux/include/class_to_string.h
> > @@ -71,3 +71,4 @@
> >      S_(NULL)
> >      S_(NULL)
> >      S_("peer")
> > +    S_("capability2")
> > diff --git a/security/selinux/include/flask.h b/security/selinux/include/flask.h
> > index 09e9dd2..febf886 100644
> > --- a/security/selinux/include/flask.h
> > +++ b/security/selinux/include/flask.h
> > @@ -51,6 +51,7 @@
> >  #define SECCLASS_DCCP_SOCKET                             60
> >  #define SECCLASS_MEMPROTECT                              61
> >  #define SECCLASS_PEER                                    68
> > +#define SECCLASS_CAPABILITY2                             69
> >  
> >  /*
> >   * Security identifier indices for initial entities
> > 
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
