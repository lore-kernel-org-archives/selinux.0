Subject: Re: [RFC][PATCH] selinux:  support 64-bit capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <Xine.LNX.4.64.0802071102420.5800@us.intercode.com.au>
References: <1202314924.27371.163.camel@moss-spartans.epoch.ncsc.mil>
	 <1202322530.27371.171.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0802071102420.5800@us.intercode.com.au>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 08:53:06 -0500
Message-Id: <1202392386.27371.199.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-07 at 11:04 +1100, James Morris wrote:
> On Wed, 6 Feb 2008, Stephen Smalley wrote:
> 
> > 
> > > +	switch (CAP_TO_INDEX(cap)) {
> > > +	case 0:
> > > +		sclass = SECCLASS_CAPABILITY;
> > > +		break;
> > > +	case 1:
> > > +		sclass = SECCLASS_CAPABILITY2;
> > > +		break;
> > > +	default:
> > > +		return -EPERM;
> > 
> > Should likely make this something like:
> > 	printk(KERN_WARNING "SELinux:  unknown capability %d\n", cap);
> > 	if (selinux_enforcing)
> > 		return -EPERM;
> > 	else
> > 		return 0;
> > 
> > Then, if/when people introduce capabilities without updating SELinux,
> > we'll get a warning but permissive mode will allow the operation to
> > proceed.
> 
> Agreed, perhaps also suggest upgrading policy in the message.

Policy upgrade won't help in that case - it requires code changes to
allow SELinux to deal with higher capabilities beyond its supported
range (the printk here is in the default: case, where we've gone beyond
CAP_INDEX() of 0 or 1, i.e. capability value >= 64).

Alternatively, possibly we could cause a build failure in some way if
CAP_INDEX(CAP_LAST_CAP) > 1, and make the default case a BUG().

> > 
> > > +	}
> > > +	return avc_has_perm(tsec->sid, tsec->sid, sclass, av, &ad);
> > >  }
> > >  
> > >  /* Check whether a task is allowed to use a system operation. */
> > > diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
> > > index 399f868..d569669 100644
> > > --- a/security/selinux/include/av_perm_to_string.h
> > > +++ b/security/selinux/include/av_perm_to_string.h
> > > @@ -132,6 +132,9 @@
> > >     S_(SECCLASS_CAPABILITY, CAPABILITY__LEASE, "lease")
> > >     S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_WRITE, "audit_write")
> > >     S_(SECCLASS_CAPABILITY, CAPABILITY__AUDIT_CONTROL, "audit_control")
> > > +   S_(SECCLASS_CAPABILITY, CAPABILITY__SETFCAP, "setfcap")
> > > +   S_(SECCLASS_CAPABILITY2, CAPABILITY2__MAC_OVERRIDE, "mac_override")
> > > +   S_(SECCLASS_CAPABILITY2, CAPABILITY2__MAC_ADMIN, "mac_admin")
> > >     S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_READ, "nlmsg_read")
> > >     S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_WRITE, "nlmsg_write")
> > >     S_(SECCLASS_NETLINK_FIREWALL_SOCKET, NETLINK_FIREWALL_SOCKET__NLMSG_READ, "nlmsg_read")
> > > diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
> > > index 84c9abc..75b4131 100644
> > > --- a/security/selinux/include/av_permissions.h
> > > +++ b/security/selinux/include/av_permissions.h
> > > @@ -533,6 +533,9 @@
> > >  #define CAPABILITY__LEASE                         0x10000000UL
> > >  #define CAPABILITY__AUDIT_WRITE                   0x20000000UL
> > >  #define CAPABILITY__AUDIT_CONTROL                 0x40000000UL
> > > +#define CAPABILITY__SETFCAP                       0x80000000UL
> > > +#define CAPABILITY2__MAC_OVERRIDE                 0x00000001UL
> > > +#define CAPABILITY2__MAC_ADMIN                    0x00000002UL
> > >  #define NETLINK_ROUTE_SOCKET__IOCTL               0x00000001UL
> > >  #define NETLINK_ROUTE_SOCKET__READ                0x00000002UL
> > >  #define NETLINK_ROUTE_SOCKET__WRITE               0x00000004UL
> > > diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
> > > index b1b0d1d..bd813c3 100644
> > > --- a/security/selinux/include/class_to_string.h
> > > +++ b/security/selinux/include/class_to_string.h
> > > @@ -71,3 +71,4 @@
> > >      S_(NULL)
> > >      S_(NULL)
> > >      S_("peer")
> > > +    S_("capability2")
> > > diff --git a/security/selinux/include/flask.h b/security/selinux/include/flask.h
> > > index 09e9dd2..febf886 100644
> > > --- a/security/selinux/include/flask.h
> > > +++ b/security/selinux/include/flask.h
> > > @@ -51,6 +51,7 @@
> > >  #define SECCLASS_DCCP_SOCKET                             60
> > >  #define SECCLASS_MEMPROTECT                              61
> > >  #define SECCLASS_PEER                                    68
> > > +#define SECCLASS_CAPABILITY2                             69
> > >  
> > >  /*
> > >   * Security identifier indices for initial entities
> > > 
> > 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
