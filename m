Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA19631
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2002 22:06:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA27440
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2002 03:05:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id DAA27430
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2002 03:05:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: ppp security settings
Date: Fri, 25 Jan 2002 14:06:15 +1100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0201220851420.9412-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0201220851420.9412-100000@raven>
MIME-Version: 1.0
Message-Id: <20020125030616.0C2D33A2113@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 Jan 2002 01:00, Stephen Smalley wrote:
> On Sat, 19 Jan 2002, Russell Coker wrote:
> > I have attached a patch against the latest selinux-small for pppd
> > settings (granting access to /dev/ppp by the program /usr/sbin/pppd).
> >
> > Also I have added settings for /dev/vc/* (devfs equivalent of
> > /dev/tty[0-9]+) and /dev/pts/*.
> >
> > Also I have added dhclient to the domain dhcpc_exec_t and made
> > appropriate changes for it's config files.
> >
> > Let me know if I'm doing anything stupid here.
>
> A few questions and comments:
>
> 1) I would only add pppd_t to system_r.  If started by an administrator,
> it should be done via run_init, so you don't need it in sysadm_r.

Your other message regarding run_init convinced me about this.

>  Do you
> really want it started by ordinary users?  If not, then drop it from
> user_r in rbac and drop the user_t transition from pppd.te.

In some situations yes.  If someone is running a laptop to connect to the net 
then they will generally want to start and stop pppd as non-root and 
non-sysadm_r.

I think I will put in the user_t transition in a comment.

> 2) I doubt that you really need all of the "priv*" attributes on the
> pppd_t domain - you probably just cut-and-pasted from an existing domain

Yes.

> that did need those attributes.  In particular, pppd_t should have no
> reason to be associated with the "privuser", "privrole", or "privowner"
> attributes.

OK.

> 3) Your diff doesn't show the type declaration for net_device_t anywhere -
> probably in types/files.te.

In types/device.te:
type net_device_t, file_type;

> 4) I'm not familiar with dhclient, so I'm not sure whether it belongs in
> the same domain as dhcpcd.

dhclient is a dhcp client program.  It does exactly the same thing as dhcpcd 
and (IMHO) deserves to be in the same domain.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
