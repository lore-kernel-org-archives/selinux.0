Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n47COq3N007342
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 08:24:52 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n47COpZg017497
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 12:24:51 GMT
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <49ED04DF.8050306@ak.jp.nec.com>
References: <49D1DA85.1030902@ak.jp.nec.com>
	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>
	 <1238684951.32379.311.camel@gorn.columbia.tresys.com>
	 <49D563A9.1000607@ak.jp.nec.com>  <49D965CA.4030908@ak.jp.nec.com>
	 <1240258044.19211.767.camel@gorn.columbia.tresys.com>
	 <49ED04DF.8050306@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 07 May 2009 08:24:39 -0400
Message-Id: <1241699079.19211.1251.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-21 at 08:27 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > On Mon, 2009-04-06 at 11:15 +0900, KaiGai Kohei wrote:
> >> The attached patch provides some of reworks and bugfuxes
> >> except for new object classes and permissions.
> >>

> >> - rework: All the newly created database objects by unprivileged
> >>   clients are prefixed with "user_", and these are controled via
> >>   sepgsql_enable_users_ddl.
> > 
> > I don't think we should be mixing user content with other unpriv
> > clients.
> 
> I would like to discriminate between a procedure declared by unpriv
> client and by administrative client, because the policy allows the
> unprefixed "sepgsql_proc_exec_t" to be installed as a system internal
> component, but it is undesirable to install unpriv-user defined
> procedures as is.
> 
> If the "user_" prefix is unpreferable, how do you think other prefixes
> something like "anon_", "unpriv_" and so on?

I think we should go with unpriv_ for now.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
