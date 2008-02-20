Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1K3baKk013102
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 22:37:36 -0500
Received: from g1t0027.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1K3bYOu023384
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 03:37:35 GMT
From: Paul Moore <paul.moore@hp.com>
To: Kohei KaiGai <kaigai@ak.jp.nec.com>
Subject: Re: [PATCH] Labeled IPsec for PostgreSQL/MySQL/SSHd (Re: [PATCH] IPsec SPD default security context)
Date: Tue, 19 Feb 2008 22:37:22 -0500
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com> <1203428116.13618.77.camel@gorn> <47BB7B6A.1090207@ak.jp.nec.com>
In-Reply-To: <47BB7B6A.1090207@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802192237.22546.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 19 February 2008 7:59:22 pm Kohei KaiGai wrote:
> Is it acceptable one, if we provide an interface to allow a domain
> to communicate postgresql_t via labeled networking, separated from
> existing permissions for local ports and nodes?
>
> For example:
> -- at postgresql.if
> interface(`postgresql_labeled_connect',`
> 	gen_require(`
> 		type postgresql_t;
> 	')
> 	corenet_tcp_recvfrom_labeled($1,postgresql_t)
> ')
>
> and
> -- at apache.te
> postgresql_labeled_connect(httpd_t)
>
> I think this approach enables to keep independency between modules
> in unlabeled networking cases too.

For what it is worth, it looks like a good idea to me.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
