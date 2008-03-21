Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2L5BVEW005583
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2008 01:11:31 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2L5BTVp019651
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2008 05:11:30 GMT
Message-ID: <47E3437C.8090300@ak.jp.nec.com>
Date: Fri, 21 Mar 2008 14:11:24 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy (try #3)
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com>	 <1204817238.3994.59.camel@gorn.columbia.tresys.com>	 <47D09FEB.3030005@ak.jp.nec.com>	 <1204922912.20251.58.camel@gorn.columbia.tresys.com>	 <47D3F33B.5010209@kaigai.gr.jp> <1205240234.25555.55.camel@gorn>	 <47DE3A66.602@ak.jp.nec.com> <1205937929.16113.78.camel@gorn> <47E33A66.6030705@ak.jp.nec.com>
In-Reply-To: <47E33A66.6030705@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> It seems that if the user template is instantiated, then it should
>> already have all the access that a client might have.  I'm still
>> thinking about it, but we might want to just drop the type transition
>> out of the unconfined section and just require that something that is
>> unconfined should be either a client or userdom too, to make the the
>> type_transitions are correct.
> 
> In this policy, sepgsql_client_type is also given minimum set of permissions
> 
> +interface(`postgresql_unconfined',`
> +       gen_require(`
> +               attribute sepgsql_unconfined_type;
> +               attribute sepgsql_client_type;
> +       ')
> +       typeattribute $1 sepgsql_unconfined_type;
> +       typeattribute $1 sepgsql_client_type;
> +')
> 
> It is a relic when unconfined domain is conditional, unnecessary now.
> It does not need to invoke trusted procedure when unconfined domain
> is persistent, and unconfined domain will not need to be within userdom
> because its does not create objects with any user prefix.
> 
>> This whole section should probably just go into postgresql_client() and
>> then the attribute could be dropped.
> 
> However, I want remain sepgsql_client_type to mark domains as a client
> of SE-PostgreSQL, with separating from minimum set of permissions.
> It enables to describe user defined policy easier.
> (Like auditallow switch for debugging.)

Oops, if whole of section is moved to postgresql_client(), we have to put
sepgsql_enable_users_ddl tunable section within interface.

How do you think the following idea?
1. type_transition rules are moved to postgresql_client() or
   postgresql_userdom_template().
   (sepgsql_db_t is an exception. It's common for any client)
2. a new attribute sepgsql_unpriv_client_type gives a set of
   baseline permissions, including sepgsql_enable_users_ddl
   tunable.
 --> It means any client domain belongs to sepgsql_client_type
     and either sepgsql_unconfined_type or sepgsql_unpriv_client_type.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
