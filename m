Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2PJh0Fo007839
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 15:43:00 -0400
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2PJd3Zr017995
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 19:39:04 GMT
Message-ID: <49CA8934.1040200@rubix.com>
Date: Wed, 25 Mar 2009 20:42:44 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com>
In-Reply-To: <49CA6D24.3040007@manicmethod.com>
Content-Type: multipart/alternative;
 boundary="------------070906070801070709060709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070906070801070709060709
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



Joshua Brindle wrote:
> Andy Warner wrote:
>   
>> KaiGai Kohei wrote:
>>     
>>> As I noted in the previous message, SE-PostgreSQL is postponed to
>>> the PostgreSQL v8.5 after the long discussion in the pgsql-hackers
>>> list, unfortunately.
>>> However, it also mean a good chance to revise its design because
>>> we have a few months before v8.5 development cycle launched.
>>>
>>> 1. Changes in object classes and access vectors
>>>  - add db_database:{superuser} permission
>>>   
>>>  - remove db_database:{get_param set_param} permission
>>>  - remove db_table/db_column/db_tuple:{use} permission
>>>
>>>   Please refer the previous messages for them.
>>>
>>>  - add new object class "db_schema"
>>>   As Andy noted, we directly put database objects under the
>>>   db_database class directly. But, some of database objects
>>>   are created under a schema object.
>>>   In other word, RDBMS's design has three level hierachy as:
>>>      <database>  (<-- some DBMSs calls it as <catalog>)
>>>       + <schema>
>>>          + <tables>, <procedures>, ...
>>>
>>>   Now, we control user's DDL statement via permissions on
>>>   the sepgsql_sysobj_t type as row-level controls.
>>>   But I think db_schema object class here is meaningful
>>>   to match SQL's design and analogy to the dir class.
>>>
>>>   The new db_schema object class inherits six permissions
>>>   from common database objects, and defines three its own
>>>   permissions: add_object, remove_object, usage
>>>   
>>>       
>> I would suggest that the SQL catalog object should also be supported. 
>> Though not common in implementation, it is part of the SQL spec. Our 
>> DBMS (Trusted RUBIX) supports it, and for us it is basically another 
>> level in the naming. (database.catalog.schema.table). I would suggest 
>> that a db_catalog object be included with the same basic semantics as 
>> the db_schema object.
>>
>>     
>
> Is there more information available about how Trusted RUBIX uses SELinux? I see
> on the webpage a brief mention of it but no detailed page like the other access
> control models, nor in the security policy manager data sheet.
>   

On our download page (http://rubix.com/cms/downloads) there is a pdf
called the Trusted RUBIX SELinux Guide.
Because our SELinux integration is very new we have not updated our
website to reflect it yet. The above Guide is the best source of how we
use SELinux. I can also answer any questions you have.

In general, I created a concept called an "object set" which may be
created with SELinux interfaces. An object set is all DBMS objects under
(and including) a named catalog object. An object set may include any
number of schemata, tables, views, etc. An admin may create an object
set and roles to administer the object set. They may also use provided
interfaces to give a domain restricted SQL access to the access set
(e.g., full sql, select only, insert, update, DDL, etc.). The intent was
to partition security domains by database subtree and provide easy
interfaces for them to create roles and control SQL access.

Our Security Policy Manager is a totally separate Attribute Based Access
Control policy mechanism, based upon XACML. It does interact with
SELinux a little but in general is orthogonal. The ABAC decisions may
optionally override SELinux or work to further refine the SELinux policy
decision. The SPM may also consult about an SELinux policy decision and
use it in its policy decision.
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   

--------------070906070801070709060709
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
Joshua Brindle wrote:
<blockquote cite="mid:49CA6D24.3040007@manicmethod.com" type="cite">
  <pre wrap="">Andy Warner wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">
KaiGai Kohei wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">As I noted in the previous message, SE-PostgreSQL is postponed to
the PostgreSQL v8.5 after the long discussion in the pgsql-hackers
list, unfortunately.
However, it also mean a good chance to revise its design because
we have a few months before v8.5 development cycle launched.

1. Changes in object classes and access vectors
 - add db_database:{superuser} permission
  
 - remove db_database:{get_param set_param} permission
 - remove db_table/db_column/db_tuple:{use} permission

  Please refer the previous messages for them.

 - add new object class "db_schema"
  As Andy noted, we directly put database objects under the
  db_database class directly. But, some of database objects
  are created under a schema object.
  In other word, RDBMS's design has three level hierachy as:
     &lt;database&gt;  (&lt;-- some DBMSs calls it as &lt;catalog&gt;)
      + &lt;schema&gt;
         + &lt;tables&gt;, &lt;procedures&gt;, ...

  Now, we control user's DDL statement via permissions on
  the sepgsql_sysobj_t type as row-level controls.
  But I think db_schema object class here is meaningful
  to match SQL's design and analogy to the dir class.

  The new db_schema object class inherits six permissions
  from common database objects, and defines three its own
  permissions: add_object, remove_object, usage
  
      </pre>
    </blockquote>
    <pre wrap="">I would suggest that the SQL catalog object should also be supported. 
Though not common in implementation, it is part of the SQL spec. Our 
DBMS (Trusted RUBIX) supports it, and for us it is basically another 
level in the naming. (database.catalog.schema.table). I would suggest 
that a db_catalog object be included with the same basic semantics as 
the db_schema object.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Is there more information available about how Trusted RUBIX uses SELinux? I see
on the webpage a brief mention of it but no detailed page like the other access
control models, nor in the security policy manager data sheet.
  </pre>
</blockquote>
<br>
On our download page (<a class="moz-txt-link-freetext" href="http://rubix.com/cms/downloads">http://rubix.com/cms/downloads</a>) there is a pdf
called the Trusted RUBIX SELinux Guide. <br>
Because our SELinux integration is very new we have not updated our
website to reflect it yet. The above Guide is the best source of how we
use SELinux. I can also answer any questions you have.<br>
<br>
In general, I created a concept called an "object set" which may be
created with SELinux interfaces. An object set is all DBMS objects
under (and including) a named catalog object. An object set may include
any number of schemata, tables, views, etc. An admin may create an
object set and roles to administer the object set. They may also use
provided interfaces to give a domain restricted SQL access to the
access set (e.g., full sql, select only, insert, update, DDL, etc.).
The intent was to partition security domains by database subtree and
provide easy interfaces for them to create roles and control SQL
access. <br>
<br>
Our Security Policy Manager is a totally separate Attribute Based
Access Control policy mechanism, based upon XACML. It does interact
with SELinux a little but in general is orthogonal. The ABAC decisions
may optionally override SELinux or work to further refine the SELinux
policy decision. The SPM may also consult about an SELinux policy
decision and use it in its policy decision.<br>
<blockquote cite="mid:49CA6D24.3040007@manicmethod.com" type="cite">
  <pre wrap="">
--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with
the words "unsubscribe selinux" without quotes as the message.

  </pre>
</blockquote>
</body>
</html>

--------------070906070801070709060709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
