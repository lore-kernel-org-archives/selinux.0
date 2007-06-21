Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LFNJH1003860
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 11:23:19 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5LFNGA7021728
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 15:23:16 GMT
Subject: Re: dhcpd needs additional privs from dbus
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301452.l4UEq0GX008232@localhost.localdomain>
References: <200705301452.l4UEq0GX008232@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 11:21:35 -0400
Message-Id: <1182439295.24679.7.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:52 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/dhcp.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/dhcp.te	2007-05-30 07:35:54.000000000 -0400
[...]
> +	dbus_dontaudit_rw_system_selinux_socket(dhcpd_t)

I can't find a patch that adds an implementation of this interface.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
