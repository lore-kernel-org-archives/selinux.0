Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IDZM3R018701
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 09:35:22 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6IDZMAI007724
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:35:22 GMT
Subject: Re: [PATCH] Labeled IPsec for PostgreSQL/MySQL/SSHd (Re: [PATCH]
	IPsec SPD default security context)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
In-Reply-To: <4860BA1B.5030302@ak.jp.nec.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <1203428116.13618.77.camel@gorn> <47BB7B6A.1090207@ak.jp.nec.com>
	 <200802192237.22546.paul.moore@hp.com>  <47BBB69C.2050007@ak.jp.nec.com>
	 <1203955972.32061.55.camel@gorn> <47C3738A.3010007@ak.jp.nec.com>
	 <4860BA1B.5030302@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 09:34:54 -0400
Message-Id: <1216388094.21191.132.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-06-24 at 18:10 +0900, KaiGai Kohei wrote:
> Kohei KaiGai wrote:
> > Christopher J. PeBenito wrote:
> >> On Wed, 2008-02-20 at 14:11 +0900, Kohei KaiGai wrote:
> >>> Paul Moore wrote:
> >>>> On Tuesday 19 February 2008 7:59:22 pm Kohei KaiGai wrote:
> >>>>> Is it acceptable one, if we provide an interface to allow a domain
> >>>>> to communicate postgresql_t via labeled networking, separated from
> >>>>> existing permissions for local ports and nodes?
> >>>>>
> >>>>> For example:
> >>>>> -- at postgresql.if
> >>>>> interface(`postgresql_labeled_connect',`
> >>>>> 	gen_require(`
> >>>>> 		type postgresql_t;
> >>>>> 	')
> >>>>> 	corenet_tcp_recvfrom_labeled($1,postgresql_t)
> >>>>> ')
> >>>>>
> >>>>> and
> >>>>> -- at apache.te
> >>>>> postgresql_labeled_connect(httpd_t)
> >>>>>
> >>>>> I think this approach enables to keep independency between modules
> >>>>> in unlabeled networking cases too.
> >>>> For what it is worth, it looks like a good idea to me.
> >>> At first, I implemented this idea for three services (PostgreSQL/MySQL/SSHd).
> >>>
> >>> This patch adds the following interfaces:
> >>> - postgresql_labeled_communicate(domain)
> >>> - mysql_labeled_communicate(domain)
> >>> - ssh_labeled_communicate(domain)
> >>>
> >>> Chris, is it suitable for refpolicy framework?
> >> The only issue I have with it would just be the interface naming;
> >> probably something like mysql_tcp_recvfrom() would be better.
> > 
> > I think the name of "xxxx_tcp_recvfrom()" is not obvious whether it means
> > permissions related to labeled networking, or not.
> > 
> > What do you think the following ideas?
> >  - something_labeled_recvfrom(domain)
> >       or
> >  - something_labeled_tcp_recvfrom(domain)
> > 
> > Thanks,
> 
> Oops, I found out this topic has not been progressed for a long time.
> 
> An interface of corenet_*_recvfrom_labeled(dom1, dom2) is
> provided in the latest policy, but nobody uses it except
> for a few cases like:
>  - communication between unconfined domain and any other domain.
>  - communication between httpd_t and postgresql_t.
> 
> In the previous discussion, you were hesitant to add permissions
> which allows to communicate between widespread domains, so we
> made a decision to put per-domain interfaces as above.
> 
> At first, could you fix its naming scheme?
> I think somethind_labeled_tcp_recvfrom(domain) is more obvious
> to show its meanings.

Thats fine.  Its consistent with refpolicy naming.  e.g.
apache_tcp_recvfrom() would be fine.

> And, I'm worried about massive enumeration of these interfaces
> at userdom_basic_networking_template.
> Currently, it allows widespread permissions toward any nodes,
> port and interfaces.
> I don't think "daemon_labeled_tcp_recvfrom($1_t)" here makes
> security degrading. Is it reasonable to allow to communicate
> between userdomains and daemon attribute?

Yes, thats fine.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
