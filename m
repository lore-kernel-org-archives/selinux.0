Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2NJCfDo025123
	for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2005 14:12:41 -0500 (EST)
Subject: Re: New policy for pyzor
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: David Hampton <hampton-rh@rainbolthampton.net>
Cc: SELinux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
In-Reply-To: <1111454594.18940.54.camel@hampton-pc.rainbolthampton.net>
References: <1111454594.18940.54.camel@hampton-pc.rainbolthampton.net>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 14:14:02 -0500
Message-Id: <1111605242.3856.24.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From pyzor.te:

##########
# pyzor daemon
##########
daemon_domain(pyzord, `, privlog, nscd_client_domain')
pyzor_base_domain(pyzord)
allow pyzord_t pyzor_port_t:udp_socket name_bind;
home_domain_access(pyzord_t, sysadm, pyzor)

Why home_domain_access()?
There is no sysadm_pyzor_home_t defined, so it causes an error.

On Mon, 2005-03-21 at 20:23 -0500, David Hampton wrote:
> This is a new strict policy for the pyzor spam filter.  It is based on
> the selinux-policy-strict-sources-1.23.2-1 fedora RPM.  This policy
> requires the definition of a pyzor reserved port that was in the
> net_contexts diff I sent last Wednesday.  Please let me know if there
> are any problems with or changes needed to this policy.
> 
> David
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
