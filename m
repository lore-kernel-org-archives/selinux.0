Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w28HYpdR014027
 for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2018 12:34:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3zxyLx2mstz19Yv4
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 17:34:49 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3zxyLx2DW9z19Ytv
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 17:34:49 +0000 (UTC)
Date: Thu, 08 Mar 2018 12:34:40 -0500 (EST)
Message-Id: <20180308.123440.2224695014753871221.davem@davemloft.net>
To: stephen@networkplumber.org
Cc: pmoore@redhat.com, netdev@vger.kernel.org, viro@zeniv.linux.org.uk,
 dac.override@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180306155920.7b6379ac@xeon-e3>
References: <152037526427.18953.14013300464173153064.stgit@chester>
 <20180306155920.7b6379ac@xeon-e3>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [PATCH] net: don't unnecessarily load kernel modules in
 dev_ioctl()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 6 Mar 2018 15:59:20 -0800

> Actually dev_load by ethernet name is really a legacy thing that
> should just die,
> 
> It was kept around so that some very tunnel configuration using special names.
> 
> 	# ifconfig sit0
> 
> which probably several web pages still tell users to do...
> We have much better control now with ip commands so that this is just
> baggage.

As you say, some people use this stuff, so we really can't break
it at this point.
