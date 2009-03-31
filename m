Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2VDpNjd008238
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 09:51:23 -0400
Received: from mail1.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2VDpLOw016955
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 13:51:22 GMT
Message-ID: <49D21FD5.7020600@kaigai.gr.jp>
Date: Tue, 31 Mar 2009 22:51:17 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, cpebenito@tresys.com,
        method@manicmethod.com, selinux@tycho.nsa.gov,
        refpolicy@oss.tresys.com
Subject: Re: [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com> <49D1EAE7.8050100@rubix.com>
In-Reply-To: <49D1EAE7.8050100@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andy Warner wrote:
> looks good to me.
> 
> One minor comment. For the superuser permission, this may be common use 
> of DBMS's but I believe is not a standard SQL feature. RUBIX has no such 
> concept, so we would generally ignore that permission. Also, it is 
> unclear to me what abilities the superuser should have (in the general 
> sense, not necessarily within sepostgresql).

It is a request from the pgsql-hackers.

In addition, the permission is well symmetrical with root capability
on operating system.
In PostgreSQL, database users with superuser privilege are allowed
various kind of operating, such as ignoring DAC policy, ignoring
ownership of database objects, installing shared libraries and so on.
The db_database:{superuser} enables to control these capabilities.

> Is this just a permission 
> to override SQL DAC, or does it also give administrative abilities like 
> setting audit configurations, or "all the above." I think you said 
> before that it would not allow MAC override, correct?

SELinux does not allow anyone to override MAC.
The unconfined domain is allowed anything in the result of access controls.

> RUBIX currently has four privileged "roles":
> Database Administrator: DAC override
> Security Administrator: MAC override, to some degree. With SELinux much 
> of this can be done with discrete rules.
> Audit Administrator: administer audit trail and criteria
> Database Operator: do the normal day-today administrative DBMS tasks, 
> like backup.
> 
> I am curious, if the intended use of the db_database superuser 
> permission would be an encapsulation of our all of our roles, excluding 
> the Security Administrator.

My preference is to adopt common design *as far as possible*.
If you need finer-grained privileges, please propose it as a characteristic
part for Trusted RUBIX, as if we did on db_catalog class.
Anyway, I cannot believe the pgsql-hackers accepts its design changes due
to the RUBIX's design.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
