Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA21299
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2002 09:01:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA18260
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2002 14:00:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA18256
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2002 14:00:37 GMT
Date: Tue, 22 Jan 2002 09:00:58 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: ppp security settings
In-Reply-To: <20020119182303.E8C9B907@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0201220851420.9412-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 19 Jan 2002, Russell Coker wrote:

> I have attached a patch against the latest selinux-small for pppd settings
> (granting access to /dev/ppp by the program /usr/sbin/pppd).
>
> Also I have added settings for /dev/vc/* (devfs equivalent of /dev/tty[0-9]+)
> and /dev/pts/*.
>
> Also I have added dhclient to the domain dhcpc_exec_t and made appropriate
> changes for it's config files.
>
> Let me know if I'm doing anything stupid here.

A few questions and comments:

1) I would only add pppd_t to system_r.  If started by an administrator,
it should be done via run_init, so you don't need it in sysadm_r.  Do you
really want it started by ordinary users?  If not, then drop it from
user_r in rbac and drop the user_t transition from pppd.te.

2) I doubt that you really need all of the "priv*" attributes on the
pppd_t domain - you probably just cut-and-pasted from an existing domain
that did need those attributes.  In particular, pppd_t should have no
reason to be associated with the "privuser", "privrole", or "privowner"
attributes.

3) Your diff doesn't show the type declaration for net_device_t anywhere -
probably in types/files.te.

4) I'm not familiar with dhclient, so I'm not sure whether it belongs in
the same domain as dhcpcd.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
