Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2U9pG3N004071
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 05:51:16 -0400
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2U9pFRp025532
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 09:51:15 GMT
Message-ID: <49D0958F.2020109@rubix.com>
Date: Mon, 30 Mar 2009 11:49:03 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Joshua Brindle <method@manicmethod.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com> <49CD687C.9080401@kaigai.gr.jp> <49CDCF07.1020900@rubix.com> <49D018A3.2090304@ak.jp.nec.com>
In-Reply-To: <49D018A3.2090304@ak.jp.nec.com>
Content-Type: multipart/alternative;
 boundary="------------020902000607030906030501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020902000607030906030501
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



KaiGai Kohei wrote:
>>> It had been a headache what is the target of TYPE_TRANSITION for the root
>>> object.
>>> At the initial design, as you pointed out, I used the domain of server
>>> process as the target to decide the security context of database itself.
>>> Then, I got a suggestion that we can use the following notation to
>>> represent the security context of new object is determined by only
>>> the context of subject.
>>>
>>>   TYPE_TRANSITION <subject context> <subject context> : <class> <new context>;
>>>
>>> I could understand as an analogy of permission checks on the kernel
>>> capability classes.
>>>
>>>   
>>>       
>> It seems if you decide the context of the database using only the 
>> subject's attributes itself, there will always be potential conflict 
>> with other DBMS's. There is nothing in the type transition that 
>> identifies the rule as applying to a sepostgresql dbms as opposed to any 
>> other. It seems a bad way to do it. I would propose either:
>>
>> TYPE_TRANSITION <server context> <server context> : <class> <new context>;
>>
>> or
>>
>> TYPE_TRANSITION <subject context> <server context> : <class> <new context>;
>>
>> Where the 1st has the potential to cover all permutations (but only one new context) and the latter opens the possibility to have different new contexts based upon the context of the subject, but could leave some permutations uncovered. I think the second case is more general and flexible and the first case could be viewed as a special case of the second.
>>     
>
> I can understand your concern. Indeed, the combination of client context and
> itself cannot handle the case when multiple DBMSs are installed.
>   
Won't the issue exist even if SEPostresql is not installed, as the
policy transition rules (client context and itself) are still there by
default? Or, did you mean if the DBMS policy is installed? I guess one
solution for me could have been to uninstall the sepostgresql policy
module (?).
> My preference is the later one:
>   TYPE_TRANSITION <subject context> <server context> : <class> <new context>;
>   
This one is also my preference.
> In addition, an idea of configuration file can be considerable to set up
> the default context of database objects, though I considered it is not
> necessary in the past discussion.
> If a user want to work the database server process as an unconfined domain,
> like a legacy "disable_xxxx_trans" boolean doing, the <server context> as
> the target of TYPE_TRANSITION breaks all the correct labeling.
>
> If we have a /etc/selinux/$POLICYTYPE/contexts/db_{sepgsql|rubix}, as follows,
> it can be used to specify the default context of special purpose database
> object such as schemas to store temporary database objects, not only the
> context of database as the root of type transition.
> ------------
> database    *             system_u:object_r:sepgsql_db_t:s0
> schema      pg_temp_*     system_u:object_r:sepgsql_temp_schema_t:s0
>   :             :            :
> ------------
>
> The libselinux has selabel_lookup(3) interface to implement them
> for various kind of objects.
>
> One concern is performance hit. If we need to open/lookup/close the file
> for each INSERT statement, its pain will be unacceptable.
>   
I agree it's interesting but potentially a performance hit. For my
purposes, I don't see this as needed because once the db object
transition rule is settled in a way that is friendly to all DBMS's, all
of the functionality I need exists (at this time). It would be
interestung to know the extend of the performance hit expected.
> Thanks,
>   

--------------020902000607030906030501
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-2022-JP"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
KaiGai Kohei wrote:
<blockquote cite="mid:49D018A3.2090304@ak.jp.nec.com" type="cite">
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">It had been a headache what is the target of TYPE_TRANSITION for the root
object.
At the initial design, as you pointed out, I used the domain of server
process as the target to decide the security context of database itself.
Then, I got a suggestion that we can use the following notation to
represent the security context of new object is determined by only
the context of subject.

  TYPE_TRANSITION &lt;subject context&gt; &lt;subject context&gt; : &lt;class&gt; &lt;new context&gt;;

I could understand as an analogy of permission checks on the kernel
capability classes.

  
      </pre>
    </blockquote>
    <pre wrap="">It seems if you decide the context of the database using only the 
subject's attributes itself, there will always be potential conflict 
with other DBMS's. There is nothing in the type transition that 
identifies the rule as applying to a sepostgresql dbms as opposed to any 
other. It seems a bad way to do it. I would propose either:

TYPE_TRANSITION &lt;server context&gt; &lt;server context&gt; : &lt;class&gt; &lt;new context&gt;;

or

TYPE_TRANSITION &lt;subject context&gt; &lt;server context&gt; : &lt;class&gt; &lt;new context&gt;;

Where the 1st has the potential to cover all permutations (but only one new context) and the latter opens the possibility to have different new contexts based upon the context of the subject, but could leave some permutations uncovered. I think the second case is more general and flexible and the first case could be viewed as a special case of the second.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I can understand your concern. Indeed, the combination of client context and
itself cannot handle the case when multiple DBMSs are installed.
  </pre>
</blockquote>
Won't the issue exist even if SEPostresql is not installed, as the
policy transition rules (client context and itself) are still there by
default? Or, did you mean if the DBMS policy is installed? I guess one
solution for me could have been to uninstall the sepostgresql policy
module (?).<br>
<blockquote cite="mid:49D018A3.2090304@ak.jp.nec.com" type="cite">
  <pre wrap="">
My preference is the later one:
  TYPE_TRANSITION &lt;subject context&gt; &lt;server context&gt; : &lt;class&gt; &lt;new context&gt;;
  </pre>
</blockquote>
This one is also my preference.<br>
<blockquote cite="mid:49D018A3.2090304@ak.jp.nec.com" type="cite">
  <pre wrap="">
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

One concern is performance hit. If we need to open/lookup/close the file
for each INSERT statement, its pain will be unacceptable.
  </pre>
</blockquote>
I agree it's interesting but potentially a performance hit. For my
purposes, I don't see this as needed because once the db object
transition rule is settled in a way that is friendly to all DBMS's, all
of the functionality I need exists (at this time). It would be
interestung to know the extend of the performance hit expected.<br>
<blockquote cite="mid:49D018A3.2090304@ak.jp.nec.com" type="cite">
  <pre wrap="">
Thanks,
  </pre>
</blockquote>
</body>
</html>

--------------020902000607030906030501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
