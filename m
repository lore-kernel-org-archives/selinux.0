Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2NINuDo024683
	for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2005 13:23:56 -0500 (EST)
Subject: Re: Latest diff.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <424062D4.8090708@redhat.com>
References: <424062D4.8090708@redhat.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 13:25:17 -0500
Message-Id: <1111602317.3856.10.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, including your diff of diffs.

On Tue, 2005-03-22 at 13:24 -0500, Daniel J Walsh wrote:
> Fixed assert.te to allow unrestricted domains full access.
> 
> Added httpd_unconfined_t so that if a user has a script that can not run 
> under SELinux protection, he can label just this script
> with httpd_unconfined_script_t and it will run in an unconfined domain.  
> The rest of the scripts and httpd itself will run under
> normal apache policy. I am not sure if we want this protected via a 
> boolean or not.  The user has to set httpd_unconfined_script_t on
> a script for it to take place.  Maybe should be placed under a boolean.  
> This is better than the current solution which is to turn off
> protection for all of apache.
> 
> Merged in changes to get ready for name_connect.
> 
> Also added liberal allow rules for all domains that
> have can_network or can_network_tcp.  Allowing them to connect to port_type.
> I need help from people to go through these network controls and tighten 
> them up.   IE we need to specify the only ports that
> dhcp, or named or xserver etc can connect to.
> 
> Alot of port_type definitions need to be moved out of their individual 
> te files into types/network.te
> 
> I also changed can_kerberos, can_portmap, can_resolv, can_ldap to use 
> the named ports.
> 
> Dan

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
