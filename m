Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KEQcKh014870
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 09:26:39 -0500
Received: from g1t0028.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KEQZDb023734
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 14:26:36 GMT
From: Paul Moore <paul.moore@hp.com>
To: Kohei KaiGai <kaigai@ak.jp.nec.com>
Subject: Re: [PATCH] Labeled IPsec for PostgreSQL/MySQL/SSHd (Re: [PATCH] IPsec SPD default security context)
Date: Wed, 20 Feb 2008 09:18:51 -0500
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com> <200802192237.22546.paul.moore@hp.com> <47BBB69C.2050007@ak.jp.nec.com>
In-Reply-To: <47BBB69C.2050007@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802200918.51651.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 20 February 2008 12:11:56 am Kohei KaiGai wrote:
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
> At first, I implemented this idea for three services
> (PostgreSQL/MySQL/SSHd).
>
> This patch adds the following interfaces:
> - postgresql_labeled_communicate(domain)
> - mysql_labeled_communicate(domain)
> - ssh_labeled_communicate(domain)

If this approach is approved by everyone else, I think we would want to add 
similar interfaces to all of the network facing daemons in the policy.  I 
know it's a lot of work but it's the right thing to do.

> Chris, is it suitable for refpolicy framework?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
