Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SIhOrT009773
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 14:43:24 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SIhMPw013194
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 18:43:22 GMT
Subject: Re: [patch] policy update for dnsmasq
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Greg Norris <haphazard@kc.rr.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040925005803.GA23849@yggdrasil.localdomain>
References: <20040925005803.GA23849@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1096396758.30810.82.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Sep 2004 14:39:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2004-09-24 at 20:58, Greg Norris wrote:
> Please apply the attached dnsmasq policy patch.  It's needed in order to
> support version 2.10 and later (see below for details).
> 
> Let me know if I can provide any additional information.  Thanx!
> 
> ----- Forwarded message from Greg Norris <haphazard@kc.rr.com> -----
> 
> Date: Tue, 14 Sep 2004 20:18:36 -0500
> From: Greg Norris <haphazard@kc.rr.com>
> To: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
> Cc: simon@thekelleys.org.uk
> Subject: policy update for dnsmasq
> X-Mailing-List: selinux-tycho.nsa.gov
> 
> I've attached a small patch against the dnsmasq policy, which provides
> the updates indicated below.  Thanx to Simon Kelley, author of this
> wondrous beastie, for bringing the relevant enhancements to my
> attention. ;-)
> 
> 1) Allow binding to port 53 TCP.  Beginning with version 2.10, dnsmasq
>    supports DNS queries over both TCP and UDP.
> 
> 2) Allow the creation of RAWIP sockets, in order to enable ICMP echo
>    requests.  This is used as a sanity-check before assigning an IP
>    address via DHCP, to ensure that it isn't already in use.
> 
> I've been running with the modified policy for the past few days (while
> trying to stress it appropriately), and everything appears to be
> working as expected... I think it's ready to be merged into CVS.  As
> always, comments are most welcome.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
