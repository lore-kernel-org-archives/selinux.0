Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9ODBC3A008431
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 09:11:12 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l9ODBBjT005580
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2007 13:11:11 GMT
Subject: Re: policyd module
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jan-Frode Myklebust <janfrode@tanso.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071023160316.GA10042@lc4eb8045376502.ibm.com>
References: <20070929231049.GA14665@lc4eb8045376502.ibm.com>
	 <1191243135.4282.42.camel@gorn>
	 <20071003125323.GA15070@lc4eb8045376502.ibm.com>
	 <1191416728.5843.6.camel@gorn>
	 <20071003150600.GA16964@lc4eb8045376502.ibm.com>
	 <1191606242.13098.4.camel@gorn.columbia.tresys.com>
	 <20071005234757.GA4249@lc4eb8045376502.ibm.com>
	 <1191855475.13098.37.camel@gorn>
	 <20071008164636.GA9601@lc4eb8045376502.ibm.com>
	 <20071023160316.GA10042@lc4eb8045376502.ibm.com>
Content-Type: text/plain
Date: Wed, 24 Oct 2007 13:08:32 +0000
Message-Id: <1193231312.9466.104.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-23 at 18:03 +0200, Jan-Frode Myklebust wrote:
> Resending this one, as it seems to have dropped of your radar. Still
> applies to refpolicy-head.

I'm wrestling with the naming.  Policyd, while its the name of the
server, seems far too generic.  It seems like postfix_policyd would be
better.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
