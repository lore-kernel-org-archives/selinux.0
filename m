Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00268
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 10:41:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA06262
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:40:01 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA06258
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:40:00 GMT
Date: Thu, 21 Mar 2002 10:41:18 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: addition for xdm.te
In-Reply-To: <20020321152304.1441765C@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203211031470.19336-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 21 Mar 2002, Russell Coker wrote:

> domain_auto_trans(initrc_t, xdm_exec_t, xdm_t)

Why?  Do some people start xdm from an rc script?  If not, then there is
no reason to provide a transition from initrc_t.  There is already a
transition in init.te to handle xdm being started directly by init, as
configured in /etc/inittab:
	domain_auto_trans(init_t, xdm_exec_t, xdm_t)

We could move the above domain_auto_trans rule from init.te to xdm.te to
provide better encapsulation of xdm_t.  In general, it is debateable
whether it is better to place the rule in the source domain's .te file or
the target domain's .te file.  Originally, the convention was to place the
rule in the source domain's .te file, listing all outgoing transitions
from a domain.  I chose to distribute the rules for big "multiplexor"
domains among the target domain .te files in the last release to make it
easier to add new daemons and user domains without needing to update a
central source domain .te file each time, but the other domains still tend
to follow the original convention.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
