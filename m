Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RGQebN003777
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 12:26:40 -0400
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RGMfGo023290
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 16:22:42 GMT
Message-ID: <49CCFDF6.9050603@rubix.com>
Date: Fri, 27 Mar 2009 17:25:26 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com>
In-Reply-To: <49CCF41D.4090603@manicmethod.com>
Content-Type: multipart/alternative;
 boundary="------------040006010702000804050909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040006010702000804050909
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



Joshua Brindle wrote:
> Andy Warner wrote:
>   
>> Joshua Brindle wrote:
>>     
>>> Andy Warner wrote:
>>>   
>>>       
>>>> KaiGai Kohei wrote:
>>>>     
>>>>         
>>>>> As I noted in the previous message, SE-PostgreSQL is postponed to
>>>>> the PostgreSQL v8.5 after the long discussion in the pgsql-hackers
>>>>> list, unfortunately.
>>>>> However, it also mean a good chance to revise its design because
>>>>> we have a few months before v8.5 development cycle launched.
>>>>>
>>>>> 1. Changes in object classes and access vectors
>>>>>  - add db_database:{superuser} permission
>>>>>   
>>>>>  - remove db_database:{get_param set_param} permission
>>>>>  - remove db_table/db_column/db_tuple:{use} permission
>>>>>
>>>>>   Please refer the previous messages for them.
>>>>>
>>>>>  - add new object class "db_schema"
>>>>>   As Andy noted, we directly put database objects under the
>>>>>   db_database class directly. But, some of database objects
>>>>>   are created under a schema object.
>>>>>   In other word, RDBMS's design has three level hierachy as:
>>>>>      <database>  (<-- some DBMSs calls it as <catalog>)
>>>>>       + <schema>
>>>>>          + <tables>, <procedures>, ...
>>>>>
>>>>>   Now, we control user's DDL statement via permissions on
>>>>>   the sepgsql_sysobj_t type as row-level controls.
>>>>>   But I think db_schema object class here is meaningful
>>>>>   to match SQL's design and analogy to the dir class.
>>>>>
>>>>>   The new db_schema object class inherits six permissions
>>>>>   from common database objects, and defines three its own
>>>>>   permissions: add_object, remove_object, usage
>>>>>   
>>>>>       
>>>>>           
>>>> I would suggest that the SQL catalog object should also be supported. 
>>>> Though not common in implementation, it is part of the SQL spec. Our 
>>>> DBMS (Trusted RUBIX) supports it, and for us it is basically another 
>>>> level in the naming. (database.catalog.schema.table). I would suggest 
>>>> that a db_catalog object be included with the same basic semantics as 
>>>> the db_schema object.
>>>>
>>>>     
>>>>         
>>> Is there more information available about how Trusted RUBIX uses SELinux? I see
>>> on the webpage a brief mention of it but no detailed page like the other access
>>> control models, nor in the security policy manager data sheet.
>>>   
>>>       
>> On our download page (http://rubix.com/cms/downloads) there is a pdf 
>> called the Trusted RUBIX SELinux Guide.
>> Because our SELinux integration is very new we have not updated our 
>> website to reflect it yet. The above Guide is the best source of how we 
>> use SELinux. I can also answer any questions you have.
>>
>> In general, I created a concept called an "object set" which may be 
>> created with SELinux interfaces. An object set is all DBMS objects under 
>> (and including) a named catalog object. An object set may include any 
>> number of schemata, tables, views, etc. An admin may create an object 
>> set and roles to administer the object set. They may also use provided 
>> interfaces to give a domain restricted SQL access to the access set 
>> (e.g., full sql, select only, insert, update, DDL, etc.). The intent was 
>> to partition security domains by database subtree and provide easy 
>> interfaces for them to create roles and control SQL access.
>>
>>     
>
> I see now. When the db object classes were proposed we hoped they would be
> general enough to cover other dbms's, it looks like we weren't far off. 

Other than omitting the catalog and schema object classes, which are SQL
standard objects (though sparsely used and poorly defined), I would agree.
> I have
> some comments for permission sets found in the document mentioned above, for
> example:
>
> CREATE TABLE: db_database {access}; dir {search} on catalog; dir {search
> add_name} on schema; db_table {create} on table
>
> you require dir search, add_name. What is the source context in this case? Is
> Trusted RUBIX doing avc_has_perm calls with dir as the object class on behalf of
> the connected client or is the server masquerading as the client and those
> checks are done by SELinux? I don't think it is a good idea to muddle the object
> class ownership concept by doing checks for classes which are owned by another
> object manager (except in the case that you are proxying access for that object
> manager, such as the case for samba).
>   
Trusted RUBIX does all security decision checks using avc_has_perm on
behalf of the connected client. We use the SELinux mechanism for access
control decisions and never for enforcement (I am speaking of only DBMS
objects). All DBMS object contexts are maintained internally in the
database. RUBIX enforces all decisions. Note that the schema is not an
OS directory, it is purely an internal DBMS object. I only used the dir
object class because there was no support for the DBMS schema or catalog
objects. I believe there will be support for this in the future, at
which time we would replace the use of the dir class with the db_schema
or db_catalog.

So, internally, the access checks on the database and catalog are
performed when those objects are opened. During the actual create table
operation we have two calls to avc_has_perm, the first checks the
client's context, schema's context for dir {search add_name} and the
second checks the client's context, table's context for db_table {create}

Could you elaborate on what you mean by "I don't think it is a good idea
to muddle the object
class ownership concept by doing checks for classes which are owned by
another
object manager" ? In what way is an object class *owned* by an object
manager? I'm a newbie in this area and would appreciate some
constructive criticism.

> Were the db object classes incomplete for you so you needed to use filesystem
> object classes? I'm trying to get a feeling for what the motivation was behind
> these checks.
>   
Yes, if the db object classes supported schema and catalog I would not
use the dir. I'm not sure what to say for motivation, other than I felt
it important and useful to have security checks on our catalog and
schemata. And, since these objects function very closely to an OS
directory, and there was no support for the catalog and schema objects
in the selinux policy, and I decided not to modify the targeted/mls
policies as part of our release, I chose to use the dir object class.
Actually, I think I got the idea from an old post on this newsgroup. The
options presented in that post were to either modify the policy's object
class and permissions or overload a pre-existing object class. I chose
the latter. It was the lesser of two evils. I didn't want to have to
keep up with updates to the targeted/mls policies.
> Is Trusted RUBIX with these SELinux checks actually released, are the access
> checks set in stone? I'd like to see as much consistency between dbms object
> models as possible so that policy won't be dramatically different between them.
>   
Yes, Trusted RUBIX with these security checks is released. But no, they
are not set in stone. The minute a new policy is released supporting the
db_schema and db_catalog object classes will be the time I change our
product to use them, and stop using the dir object class.

To my knowledge there are only two DBMS's that integrate SELinux into
its product, SEPostgresql and Trusted RUBIX. I'm not so sure I would say
our DBMS object models are dramatically different. SEPostgresql does not
have a catalog object and chose not to have selinux control over their
schema object. From looking at KaiGai's work and posts I think in the
future they will support the schema object, in much the same way I tried
to in our current release.

--------------040006010702000804050909
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
Joshua Brindle wrote:
<blockquote cite="mid:49CCF41D.4090603@manicmethod.com" type="cite">
  <pre wrap="">Andy Warner wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">
Joshua Brindle wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Andy Warner wrote:
  
      </pre>
      <blockquote type="cite">
        <pre wrap="">KaiGai Kohei wrote:
    
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
      <pre wrap="">Is there more information available about how Trusted RUBIX uses SELinux? I see
on the webpage a brief mention of it but no detailed page like the other access
control models, nor in the security policy manager data sheet.
  
      </pre>
    </blockquote>
    <pre wrap="">On our download page (<a class="moz-txt-link-freetext" href="http://rubix.com/cms/downloads">http://rubix.com/cms/downloads</a>) there is a pdf 
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

    </pre>
  </blockquote>
  <pre wrap=""><!---->
I see now. When the db object classes were proposed we hoped they would be
general enough to cover other dbms's, it looks like we weren't far off. </pre>
</blockquote>
<br>
Other than omitting the catalog and schema object classes, which are
SQL standard objects (though sparsely used and poorly defined), I would
agree.<br>
<blockquote cite="mid:49CCF41D.4090603@manicmethod.com" type="cite">
  <pre wrap="">I have
some comments for permission sets found in the document mentioned above, for
example:

CREATE TABLE: db_database {access}; dir {search} on catalog; dir {search
add_name} on schema; db_table {create} on table

you require dir search, add_name. What is the source context in this case? Is
Trusted RUBIX doing avc_has_perm calls with dir as the object class on behalf of
the connected client or is the server masquerading as the client and those
checks are done by SELinux? I don't think it is a good idea to muddle the object
class ownership concept by doing checks for classes which are owned by another
object manager (except in the case that you are proxying access for that object
manager, such as the case for samba).
  </pre>
</blockquote>
Trusted RUBIX does all security decision checks using avc_has_perm on
behalf of the connected client. We use the SELinux mechanism for access
control decisions and never for enforcement (I am speaking of only DBMS
objects). All DBMS object contexts are maintained internally in the
database. RUBIX enforces all decisions. Note that the schema is not an
OS directory, it is purely an internal DBMS object. I only used the dir
object class because there was no support for the DBMS schema or
catalog objects. I believe there will be support for this in the
future, at which time we would replace the use of the dir class with
the db_schema or db_catalog.<br>
<br>
So, internally, the access checks on the database and catalog are
performed when those objects are opened. During the actual create table
operation we have two calls to avc_has_perm, the first checks the
client's context, schema's context for dir {search add_name} and the
second checks the client's context, table's context for db_table
{create}<br>
<br>
Could you elaborate on what you mean by "I don't think it is a good
idea to muddle the object<br>
class ownership concept by doing checks for classes which are owned by
another<br>
object manager" ? In what way is an object class *owned* by an object
manager? I'm a newbie in this area and would appreciate some
constructive criticism. <br>
<br>
<blockquote cite="mid:49CCF41D.4090603@manicmethod.com" type="cite">
  <pre wrap="">
Were the db object classes incomplete for you so you needed to use filesystem
object classes? I'm trying to get a feeling for what the motivation was behind
these checks.
  </pre>
</blockquote>
Yes, if the db object classes supported schema and catalog I would not
use the dir. I'm not sure what to say for motivation, other than I felt
it important and useful to have security checks on our catalog and
schemata. And, since these objects function very closely to an OS
directory, and there was no support for the catalog and schema objects
in the selinux policy, and I decided not to modify the targeted/mls
policies as part of our release, I chose to use the dir object class.
Actually, I think I got the idea from an old post on this newsgroup.
The options presented in that post were to either modify the policy's
object class and permissions or overload a pre-existing object class. I
chose the latter. It was the lesser of two evils. I didn't&nbsp; want to
have to keep up with updates to the targeted/mls policies. <br>
<blockquote cite="mid:49CCF41D.4090603@manicmethod.com" type="cite">
  <pre wrap="">
Is Trusted RUBIX with these SELinux checks actually released, are the access
checks set in stone? I'd like to see as much consistency between dbms object
models as possible so that policy won't be dramatically different between them.
  </pre>
</blockquote>
Yes, Trusted RUBIX with these security checks is released. But no, they
are not set in stone. The minute a new policy is released supporting
the db_schema and db_catalog object classes will be the time I change
our product to use them, and stop using the dir object class. <br>
<br>
To my knowledge there are only two DBMS's that integrate SELinux into
its product, SEPostgresql and Trusted RUBIX. I'm not so sure I would
say our DBMS object models are dramatically different.&nbsp; SEPostgresql
does not have a catalog object and chose not to have selinux control
over their schema object. From looking at KaiGai's work and posts I
think in the future they will support the schema object, in much the
same way I tried to in our current release.<br>
</body>
</html>

--------------040006010702000804050909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
