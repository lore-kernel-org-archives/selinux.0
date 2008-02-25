Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PGGLne032335
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 11:16:21 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PGGHJD023559
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 16:16:17 GMT
Subject: Re: [PATCH] Labeled IPsec for PostgreSQL/MySQL/SSHd (Re: [PATCH]
	IPsec SPD default security context)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Kohei KaiGai <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov,
        DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
In-Reply-To: <200802200918.51651.paul.moore@hp.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <200802192237.22546.paul.moore@hp.com> <47BBB69C.2050007@ak.jp.nec.com>
	 <200802200918.51651.paul.moore@hp.com>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 11:13:42 -0500
Message-Id: <1203956022.32061.57.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-02-20 at 09:18 -0500, Paul Moore wrote:
> On Wednesday 20 February 2008 12:11:56 am Kohei KaiGai wrote:
> > Paul Moore wrote:
> > > On Tuesday 19 February 2008 7:59:22 pm Kohei KaiGai wrote:
[...]
> > >> For example:
> > >> -- at postgresql.if
> > >> interface(`postgresql_labeled_connect',`
> > >> 	gen_require(`
> > >> 		type postgresql_t;
> > >> 	')
> > >> 	corenet_tcp_recvfrom_labeled($1,postgresql_t)
> > >> ')
> > >>
> > >> and
> > >> -- at apache.te
> > >> postgresql_labeled_connect(httpd_t)
> > >>
[...]
> > This patch adds the following interfaces:
> > - postgresql_labeled_communicate(domain)
> > - mysql_labeled_communicate(domain)
> > - ssh_labeled_communicate(domain)
> 
> If this approach is approved by everyone else, I think we would want to add 
> similar interfaces to all of the network facing daemons in the policy.  I 
> know it's a lot of work but it's the right thing to do.

I agree.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
