Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7TCoeOb009436
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2005 08:50:41 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7TCo7Cn003854
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2005 12:50:07 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j7TCoCus004462
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2005 08:50:12 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j7TCoC8E004461
	for selinux@tycho.nsa.gov; Mon, 29 Aug 2005 08:50:12 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7QIUCOb027286
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 14:30:12 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7QIU6Lr020852
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 18:30:07 GMT
Received: from teamamerica.columbia.tresys.com (teamamerica.columbia.tresys.com [10.1.13.43])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id j7QIU7sq023974
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 14:30:08 -0400
From: Spencer Shimko <sshimko@tresys.com>
To: selinux@tycho.nsa.gov
Subject: conditional name_bind permission check
Date: Fri, 26 Aug 2005 14:30:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200508261430.03861.sshimko@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While developing policy for an application we expected to see a 
name_bind denial message at a certain point.  The message was not
appearing in the audit logs.  Further exploration showed the avc_has_perm
call was wrapped in a conditional that excluded the port range in question.  
In security/selinux/hooks.c the avc_has_perm is only called if the
following condition is met:

if (snum&&(snum < max(PROT_SOCK,ip_local_port_range_0) ||
        snum > ip_local_port_range_1))

PROT_SOCK is defined as 1024 in the kernel.  ip_local_port_range_0
and ip_local_port_range_1 are macros that expand to the port range
specified in the /proc/sys/net/ipv4/ip_local_port_range sysctl interface.
So this prevents the name_bind permission from being checked on those 
ports reserved for local use.  What is the reason for not checking this 
range?

Thanks,
Spencer

--
Spencer Shimko
Tresys Technology, LLC
sshimko@tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
