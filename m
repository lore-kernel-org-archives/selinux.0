Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PGFofE032223
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 11:15:50 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PGFkJD023229
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 16:15:46 GMT
Subject: Re: [PATCH] Labeled IPsec for PostgreSQL/MySQL/SSHd (Re: [PATCH]
	IPsec SPD default security context)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Kohei KaiGai <kaigai@ak.jp.nec.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
In-Reply-To: <47BBB69C.2050007@ak.jp.nec.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <1203428116.13618.77.camel@gorn> <47BB7B6A.1090207@ak.jp.nec.com>
	 <200802192237.22546.paul.moore@hp.com>  <47BBB69C.2050007@ak.jp.nec.com>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 11:12:52 -0500
Message-Id: <1203955972.32061.55.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-02-20 at 14:11 +0900, Kohei KaiGai wrote:
> Paul Moore wrote:
> > On Tuesday 19 February 2008 7:59:22 pm Kohei KaiGai wrote:
> >> Is it acceptable one, if we provide an interface to allow a domain
> >> to communicate postgresql_t via labeled networking, separated from
> >> existing permissions for local ports and nodes?
> >>
> >> For example:
> >> -- at postgresql.if
> >> interface(`postgresql_labeled_connect',`
> >> 	gen_require(`
> >> 		type postgresql_t;
> >> 	')
> >> 	corenet_tcp_recvfrom_labeled($1,postgresql_t)
> >> ')
> >>
> >> and
> >> -- at apache.te
> >> postgresql_labeled_connect(httpd_t)
> >>
> >> I think this approach enables to keep independency between modules
> >> in unlabeled networking cases too.
> > 
> > For what it is worth, it looks like a good idea to me.
> 
> At first, I implemented this idea for three services (PostgreSQL/MySQL/SSHd).
> 
> This patch adds the following interfaces:
> - postgresql_labeled_communicate(domain)
> - mysql_labeled_communicate(domain)
> - ssh_labeled_communicate(domain)
> 
> Chris, is it suitable for refpolicy framework?

The only issue I have with it would just be the interface naming;
probably something like mysql_tcp_recvfrom() would be better.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
