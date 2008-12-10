Subject: Re: [PATCH] SELinux: open perms on sockets, AF_UNIX
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, dwalsh@redhat.com
In-Reply-To: <1228916038.23307.1.camel@localhost.localdomain>
References: <1228865476.3737.13.camel@localhost.localdomain>
	 <1228916038.23307.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 09:05:17 -0500
Message-Id: <1228917917.3524.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-12-10 at 08:33 -0500, Stephen Smalley wrote:

> > diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
> > index c0c8854..31df1d7 100644
> > --- a/security/selinux/include/av_perm_to_string.h
> > +++ b/security/selinux/include/av_perm_to_string.h
> > @@ -24,6 +24,7 @@
> >     S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
> >     S_(SECCLASS_CHR_FILE, CHR_FILE__OPEN, "open")
> >     S_(SECCLASS_BLK_FILE, BLK_FILE__OPEN, "open")
> > +   S_(SECCLASS_SOCK_FILE, SOCK_FILE__OPEN, "open")
> >     S_(SECCLASS_FIFO_FILE, FIFO_FILE__OPEN, "open")
> >     S_(SECCLASS_FD, FD__USE, "use")
> >     S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
> > @@ -152,6 +153,7 @@
> >     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_WRITE, "nlmsg_write")
> >     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_RELAY, "nlmsg_relay")
> >     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READPRIV, "nlmsg_readpriv")
> > +   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT, "nlmsg_tty_audit")
> 
> Unrelated diff?  Defined in refpolicy yet?

Defined in policy, I'll run down if it is in refpolicy or only in the
fedora policy (diff was created using fedora's latest policy).  Either
way I think I need to get it fixed in refpolicy (and make use of it in
upstream kernel but obviously that's another patch.)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
