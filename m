Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2OFkBVA019301
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2014 11:46:11 -0400
Received: by mail-qg0-f45.google.com with SMTP id j5so17194367qga.4
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2014 08:46:10 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Joe Nall <joe@nall.com>
Subject: Re: What should the context of ICMP packets be on a ranged network
 interface be?
Date: Mon, 24 Mar 2014 11:46:08 -0400
Message-ID: <4800378.F83Hlv0U7Z@sifl>
In-Reply-To: <A6374F78-81BF-4649-9FA0-D83E5ACC780C@nall.com>
References: <A6374F78-81BF-4649-9FA0-D83E5ACC780C@nall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, March 24, 2014 10:26:09 AM Joe Nall wrote:
> If I 'semanage interface -a -t netif_t -r s0-s1 eth1' and
> 'netlabelctl unlbl add interface:eth1 address:1.2.3.4/32
> label:remote_u:remote_r:router_t:s1' ...

Don't forget that the 'netlabelctl unlbl add ...' commands only set the label 
on *incoming* traffic that isn't otherwise labeled.  The static/fallback 
labels have no effect on outbound traffic.
 
> ... and the kernel needs to send ICMP packets on that interface to 1.2.3.4,
> what should the context of the outbound ICMP packets be?

What kind of ICMP packets?  If it is a ping/echo reply then the label will be 
dependent on both the labeled IPsec configuration and the label on the 
ping/echo request.

-- 
paul moore
www.paul-moore.com
