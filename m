Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81Bs1rT020125
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 07:54:01 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81BrCY2021360
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 11:53:12 GMT
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, Tom London <selinux@comcast.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1094038404.13328.5.camel@moss-spartans.epoch.ncsc.mil>
References: <4130CF1B.3090909@comcast.net>
	 <200408291737.17497.russell@coker.com.au> <41322F5E.90409@comcast.net>
	 <200409011637.41952.russell@coker.com.au>
	 <1094038404.13328.5.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1094039529.13328.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 01 Sep 2004 07:52:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-01 at 07:33, Stephen Smalley wrote:
> These permissions shouldn't be granted directly to the user domains.  We
> need per-userdomain dbusd domains defined via a macro for the
> per-session message bus.  

BTW, note that in the rawhide policy, Dan (or someone) has added a
domain_auto_trans(userdomain, dbusd_exec_t, dbusd_t) to dbusd.te as a
workaround so that the per-session bus daemons also run in dbusd_t, but
that isn't truly what we want in the long term.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
