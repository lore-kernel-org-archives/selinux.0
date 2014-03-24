Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2OFQC3o017782
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2014 11:26:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by smtp6.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id CC0061C8045
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2014 11:26:10 -0400 (EDT)
Received: by smtp6.relay.ord1c.emailsrvr.com (Authenticated sender:
 joe-AT-nall.com) with ESMTPSA id 7C8751C803A
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2014 11:26:10 -0400 (EDT)
From: Joe Nall <joe@nall.com>
Content-Type: text/plain; charset=us-ascii
Subject: What should the context of ICMP packets be on a ranged network
 interface be?
Message-Id: <A6374F78-81BF-4649-9FA0-D83E5ACC780C@nall.com>
Date: Mon, 24 Mar 2014 10:26:09 -0500
To: SELinux <selinux@tycho.nsa.gov>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If I 
 semanage interface -a -t netif_t -r s0-s1 eth1
and 
 netlabelctl unlbl add interface:eth1 address:1.2.3.4/32 label:remote_u:remote_r:router_t:s1

and the kernel needs to send ICMP packets on that interface to 1.2.3.4, what should the context of the outbound ICMP packets be? 

joe
