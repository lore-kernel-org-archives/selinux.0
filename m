Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s08GOHtO022745
 for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2014 11:24:20 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so1935318qec.23
 for <selinux@tycho.nsa.gov>; Wed, 08 Jan 2014 08:24:18 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov
Subject: Re: how to use interface and node?
Date: Wed, 08 Jan 2014 11:24:14 -0500
Message-ID: <1832306.L1JRPPnfM3@sifl>
In-Reply-To: <15d7ab10.150e4.143702cead9.Coremail.bigclouds@163.com>
References: <15d7ab10.150e4.143702cead9.Coremail.bigclouds@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, January 08, 2014 12:47:08 PM bigclouds wrote:
> hi,all
> how to use interface and node?

We commonly call the network interface and node access controls the network 
ingress and egress controls; here are two links you may find helpful.

 * http://paulmoore.livejournal.com/2128.html
 * http://paulmoore.livejournal.com/5536.html

> 1. if i can deny a process to use a interface or node(IP)?

Read the links above, they should help explain how to do this.  You could also 
consider using using secmark for something like this, although I personally 
find secmark more difficult to manage.

 * http://paulmoore.livejournal.com/4281.html

> 2. node, it means local IP or remote IP. like nfs, if server side can allow
> a specific IP to mount?

I believe the links above should answer this for you and get you started on 
configuring your system, but if you still have questions don't hesitate to 
come back and ask.

-- 
paul moore
www.paul-moore.com
