Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l91Dhqki017706
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 09:43:52 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l91Dhlr5002198
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 13:43:47 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: policyd module
Date: Mon, 1 Oct 2007 08:52:14 -0400
Message-ID: <1191243135.4282.42.camel@gorn>
In-Reply-To: <20070929231049.GA14665@lc4eb8045376502.ibm.com>
References: <20070929231049.GA14665@lc4eb8045376502.ibm.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Jan-Frode Myklebust" <janfrode@tanso.net>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-09-30 at 01:10 +0200, Jan-Frode Myklebust wrote:
> Here's a module for the postfix policy server "policyd",
> http://policyd.org/. It also needs the port 10031/tcp labeled as
> policyd_port_t, but I don't know how to code that in a module. So I've
> added it manually with "semanage port -a -t policyd_port_t -p tcp 10031"
> on my systems.

It is a limitation of modules, ports can only be defined in the base
module or via semanage.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
