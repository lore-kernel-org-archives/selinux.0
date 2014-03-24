Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2OG0RK6020500
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2014 12:00:27 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: What should the context of ICMP packets be on a ranged network
 interface be?
From: Joe Nall <joe@nall.com>
In-Reply-To: <4800378.F83Hlv0U7Z@sifl>
Date: Mon, 24 Mar 2014 11:00:25 -0500
Message-Id: <B79601D8-B6CF-4C34-9678-915B32E9E096@nall.com>
References: <A6374F78-81BF-4649-9FA0-D83E5ACC780C@nall.com>
 <4800378.F83Hlv0U7Z@sifl>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On Mar 24, 2014, at 10:46 AM, Paul Moore <paul@paul-moore.com> wrote:

> On Monday, March 24, 2014 10:26:09 AM Joe Nall wrote:
>> If I 'semanage interface -a -t netif_t -r s0-s1 eth1' and
>> 'netlabelctl unlbl add interface:eth1 address:1.2.3.4/32
>> label:remote_u:remote_r:router_t:s1' ...
> 
> Don't forget that the 'netlabelctl unlbl add ...' commands only set the label 
> on *incoming* traffic that isn't otherwise labeled.  The static/fallback 
> labels have no effect on outbound traffic.
> 
>> ... and the kernel needs to send ICMP packets on that interface to 1.2.3.4,
>> what should the context of the outbound ICMP packets be?
> 
> What kind of ICMP packets?  If it is a ping/echo reply then the label will be 
> dependent on both the labeled IPsec configuration and the label on the 
> ping/echo request.

Probably 'Destination unreachable'. Forensics were limited since the system was in use by real people :)

The question might be better put as 'Are there any circumstances in which the egress is kernel_t:s15:c0.c1023?'

joe
