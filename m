Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2UA0ZPw004920
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 06:00:35 -0400
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2UA0YRp026921
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 10:00:34 GMT
Message-ID: <49D097C3.3010404@rubix.com>
Date: Mon, 30 Mar 2009 11:58:27 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Joshua Brindle <method@manicmethod.com>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com> <49CD687C.9080401@kaigai.gr.jp> <49CDCF07.1020900@rubix.com> <49D018A3.2090304@ak.jp.nec.com> <49D08105.2090607@ak.jp.nec.com>
In-Reply-To: <49D08105.2090607@ak.jp.nec.com>
Content-Type: multipart/alternative;
 boundary="------------050009010206060606030603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050009010206060606030603
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



KaiGai Kohei wrote:
> KaiGai Kohei wrote:
>   
>> My preference is the later one:
>>   TYPE_TRANSITION <subject context> <server context> : <class> <new context>;
>>
>> In addition, an idea of configuration file can be considerable to set up
>> the default context of database objects, though I considered it is not
>> necessary in the past discussion.
>> If a user want to work the database server process as an unconfined domain,
>> like a legacy "disable_xxxx_trans" boolean doing, the <server context> as
>> the target of TYPE_TRANSITION breaks all the correct labeling.
>>
>> If we have a /etc/selinux/$POLICYTYPE/contexts/db_{sepgsql|rubix}, as follows,
>> it can be used to specify the default context of special purpose database
>> object such as schemas to store temporary database objects, not only the
>> context of database as the root of type transition.
>> ------------
>> database    *             system_u:object_r:sepgsql_db_t:s0
>> schema      pg_temp_*     system_u:object_r:sepgsql_temp_schema_t:s0
>>   :             :            :
>> ------------
>>
>> The libselinux has selabel_lookup(3) interface to implement them
>> for various kind of objects.
>>     
>
> The attached patch is a proof of the concept.
> It adds the forth backend of selabel_lookup(3) interface.
>
> Under the enhancement, we should the following rules to determine what
> security context is assigned on the newly created database object.
>
> 1. An explicitly specified security context by users.
>    e.g)  CREATE TABLE t (a int, b text)
>              SECURITY_LABEL = 'system_u:object_r:sepgsql_table_t:SystemHigh';
>
> 2. A matched entry in the configuration file which can be lookup up
>    by selabel_lookup(3).
>    e.g)  schema  pg_temp_*  system_u:object_r:sepgsql_temp_schema_t:s0
>                  ^^^^^^^^^ --> if the new object name and type are matched.
>
> 3. The result of security_compute_av() or avc_compute_create() which can
>    return the result of TYPE_TRANSITION rules.
>
> The second step is newly suggested in this patch.
> Needless to say, the determinded security context has to be checked
> by the security policy.
>
>   
>> One concern is performance hit. If we need to open/lookup/close the file
>> for each INSERT statement, its pain will be unacceptable.
>>     
>
> This patch does not support db_tuple class, because of headach in performance
> and its characteristic that database tuples have no name to identify itself.
>   
Good decision about not including the tuple. I'm guessing that without
the tuple, the lookup would generally have small impact on overall
performance.

Is it standard in SELinux to have the selabel_lookup have higher
priority over any type transition rule? I was always curious about that.
> Thanks,
>   

--------------050009010206060606030603
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
<blockquote cite="mid:49D08105.2090607@ak.jp.nec.com" type="cite">
  <pre wrap="">KaiGai Kohei wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">My preference is the later one:
  TYPE_TRANSITION &lt;subject context&gt; &lt;server context&gt; : &lt;class&gt; &lt;new context&gt;;

In addition, an idea of configuration file can be considerable to set up
the default context of database objects, though I considered it is not
necessary in the past discussion.
If a user want to work the database server process as an unconfined domain,
like a legacy "disable_xxxx_trans" boolean doing, the &lt;server context&gt; as
the target of TYPE_TRANSITION breaks all the correct labeling.

If we have a /etc/selinux/$POLICYTYPE/contexts/db_{sepgsql|rubix}, as follows,
it can be used to specify the default context of special purpose database
object such as schemas to store temporary database objects, not only the
context of database as the root of type transition.
------------
database    *             system_u:object_r:sepgsql_db_t:s0
schema      pg_temp_*     system_u:object_r:sepgsql_temp_schema_t:s0
  :             :            :
------------

The libselinux has selabel_lookup(3) interface to implement them
for various kind of objects.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The attached patch is a proof of the concept.
It adds the forth backend of selabel_lookup(3) interface.

Under the enhancement, we should the following rules to determine what
security context is assigned on the newly created database object.

1. An explicitly specified security context by users.
   e.g)  CREATE TABLE t (a int, b text)
             SECURITY_LABEL = 'system_u:object_r:sepgsql_table_t:SystemHigh';

2. A matched entry in the configuration file which can be lookup up
   by selabel_lookup(3).
   e.g)  schema  pg_temp_*  system_u:object_r:sepgsql_temp_schema_t:s0
                 ^^^^^^^^^ --&gt; if the new object name and type are matched.

3. The result of security_compute_av() or avc_compute_create() which can
   return the result of TYPE_TRANSITION rules.

The second step is newly suggested in this patch.
Needless to say, the determinded security context has to be checked
by the security policy.

  </pre>
  <blockquote type="cite">
    <pre wrap="">One concern is performance hit. If we need to open/lookup/close the file
for each INSERT statement, its pain will be unacceptable.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This patch does not support db_tuple class, because of headach in performance
and its characteristic that database tuples have no name to identify itself.
  </pre>
</blockquote>
Good decision about not including the tuple. I'm guessing that without
the tuple, the lookup would generally have small impact on overall
performance.<br>
<br>
Is it standard in SELinux to have the selabel_lookup have higher
priority over any type transition rule? I was always curious about that.<br>
<blockquote cite="mid:49D08105.2090607@ak.jp.nec.com" type="cite">
  <pre wrap="">
Thanks,
  </pre>
</blockquote>
</body>
</html>

--------------050009010206060606030603--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
