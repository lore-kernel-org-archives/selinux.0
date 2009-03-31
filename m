Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2VFDUmj020481
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 11:13:30 -0400
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2VFDUb0011329
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 15:13:30 GMT
Message-ID: <49D23288.2030807@rubix.com>
Date: Tue, 31 Mar 2009 17:11:04 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, cpebenito@tresys.com,
        method@manicmethod.com, selinux@tycho.nsa.gov,
        refpolicy@oss.tresys.com
Subject: Re: [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com> <49D1EAE7.8050100@rubix.com> <49D21FD5.7020600@kaigai.gr.jp>
In-Reply-To: <49D21FD5.7020600@kaigai.gr.jp>
Content-Type: multipart/alternative;
 boundary="------------050907030104040302070407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050907030104040302070407
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



KaiGai Kohei wrote:
> Andy Warner wrote:
>   
>> looks good to me.
>>
>> One minor comment. For the superuser permission, this may be common use 
>> of DBMS's but I believe is not a standard SQL feature. RUBIX has no such 
>> concept, so we would generally ignore that permission. Also, it is 
>> unclear to me what abilities the superuser should have (in the general 
>> sense, not necessarily within sepostgresql).
>>     
>
> It is a request from the pgsql-hackers.
>
> In addition, the permission is well symmetrical with root capability
> on operating system.
> In PostgreSQL, database users with superuser privilege are allowed
> various kind of operating, such as ignoring DAC policy, ignoring
> ownership of database objects, installing shared libraries and so on.
> The db_database:{superuser} enables to control these capabilities.
>
>   
Sounds like our DBA role. Basically, its just a different name. I agree
that the superuser is a common concept in OS's, but note that its use is
often discouraged. I'm note sure introducing it for databases is a great
idea. But, as I said before, we would just ignore it as primarily its
there to satisfy postgresql.
>> Is this just a permission 
>> to override SQL DAC, or does it also give administrative abilities like 
>> setting audit configurations, or "all the above." I think you said 
>> before that it would not allow MAC override, correct?
>>     
>
> SELinux does not allow anyone to override MAC.
> The unconfined domain is allowed anything in the result of access controls.
>   
I am referring to things like:

mlsconstrain { db_tuple } { use select }
(( l1 dom l2 ) or
(( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
( t1 == mlsdbread ) or
( t2 == mlstrustedobject ));

where t1 == mlsdbread seems to imply an object is trusted to read
strictly dominating objects. Unless I am missing the meaning here, I
would call this a MAC override. I realize there is no concept of a TE
override, but MLS is part of MAC, no? And, this violates B&L rules. This
is something we would control with a Security Administrator "role". Or,
is this mlsdbread something that is impossible to give to a domain in a
DBMS policy?
>   
>> RUBIX currently has four privileged "roles":
>> Database Administrator: DAC override
>> Security Administrator: MAC override, to some degree. With SELinux much 
>> of this can be done with discrete rules.
>> Audit Administrator: administer audit trail and criteria
>> Database Operator: do the normal day-today administrative DBMS tasks, 
>> like backup.
>>
>> I am curious, if the intended use of the db_database superuser 
>> permission would be an encapsulation of our all of our roles, excluding 
>> the Security Administrator.
>>     
>
> My preference is to adopt common design *as far as possible*.
> If you need finer-grained privileges, please propose it as a characteristic
> part for Trusted RUBIX, as if we did on db_catalog class.
> Anyway, I cannot believe the pgsql-hackers accepts its design changes due
> to the RUBIX's design.
>   
> Thanks,
>   

--------------050907030104040302070407
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-2022-JP"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
KaiGai Kohei wrote:
<blockquote cite="mid:49D21FD5.7020600@kaigai.gr.jp" type="cite">
  <pre wrap="">Andy Warner wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">looks good to me.

One minor comment. For the superuser permission, this may be common use 
of DBMS's but I believe is not a standard SQL feature. RUBIX has no such 
concept, so we would generally ignore that permission. Also, it is 
unclear to me what abilities the superuser should have (in the general 
sense, not necessarily within sepostgresql).
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It is a request from the pgsql-hackers.

In addition, the permission is well symmetrical with root capability
on operating system.
In PostgreSQL, database users with superuser privilege are allowed
various kind of operating, such as ignoring DAC policy, ignoring
ownership of database objects, installing shared libraries and so on.
The db_database:{superuser} enables to control these capabilities.

  </pre>
</blockquote>
Sounds like our DBA role. Basically, its just a different name. I agree
that the superuser is a common concept in OS's, but note that its use
is often discouraged. I'm note sure introducing it for databases is a
great idea.&nbsp; But, as I said before, we would just ignore it as
primarily its there to satisfy postgresql.<br>
<blockquote cite="mid:49D21FD5.7020600@kaigai.gr.jp" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">Is this just a permission 
to override SQL DAC, or does it also give administrative abilities like 
setting audit configurations, or "all the above." I think you said 
before that it would not allow MAC override, correct?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
SELinux does not allow anyone to override MAC.
The unconfined domain is allowed anything in the result of access controls.
  </pre>
</blockquote>
I am referring to things like:<br>
<br>
mlsconstrain { db_tuple } { use select }<br>
&nbsp;&nbsp;&nbsp; (( l1 dom l2 ) or<br>
&nbsp;&nbsp;&nbsp; &nbsp;(( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or<br>
&nbsp;&nbsp;&nbsp; &nbsp;( t1 == mlsdbread ) or<br>
&nbsp;&nbsp;&nbsp; &nbsp;( t2 == mlstrustedobject ));<br>
<br>
where t1 == mlsdbread seems to imply an object is trusted to read
strictly dominating objects. Unless I am missing the meaning here, I
would call this a MAC override. I realize there is no concept of a TE
override, but MLS is part of MAC, no? And, this violates B&amp;L rules.
This is something we would control with a Security Administrator
"role". Or, is this mlsdbread something that is impossible to give to a
domain in a DBMS policy?<br>
<blockquote cite="mid:49D21FD5.7020600@kaigai.gr.jp" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">RUBIX currently has four privileged "roles":
Database Administrator: DAC override
Security Administrator: MAC override, to some degree. With SELinux much 
of this can be done with discrete rules.
Audit Administrator: administer audit trail and criteria
Database Operator: do the normal day-today administrative DBMS tasks, 
like backup.

I am curious, if the intended use of the db_database superuser 
permission would be an encapsulation of our all of our roles, excluding 
the Security Administrator.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
My preference is to adopt common design *as far as possible*.
If you need finer-grained privileges, please propose it as a characteristic
part for Trusted RUBIX, as if we did on db_catalog class.
Anyway, I cannot believe the pgsql-hackers accepts its design changes due
to the RUBIX's design.
  </pre>
</blockquote>
<blockquote cite="mid:49D21FD5.7020600@kaigai.gr.jp" type="cite">
  <pre wrap="">
Thanks,
  </pre>
</blockquote>
</body>
</html>

--------------050907030104040302070407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
