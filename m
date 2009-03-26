Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2Q0DLqh005566
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 20:13:22 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2Q09N8t004062
	for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 00:09:24 GMT
Message-ID: <49CAC890.8000305@ak.jp.nec.com>
Date: Thu, 26 Mar 2009 09:13:04 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49C9E949.7020108@ak.jp.nec.com> <49C9F287.9000507@rubix.com> <49CA1CF7.7010103@kaigai.gr.jp> <49CA63B8.8090101@rubix.com>
In-Reply-To: <49CA63B8.8090101@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andy Warner wrote:
>>> So, based upon the above I would say that PostgreSQL's database object 
>>> (as well as RUBIX's) is analogous to the cluster. I think database is a 
>>> much more common term. Based upon the fact that SQL and ODBC (JDBC?) 
>>> provide support for directly accessing DBMS objects (e.g., in a select 
>>> statement) using the catalog and schema (but not database), I would 
>>> still propose that both db_catalog and db_schema support are needed in 
>>> SELinux. Obviously, the db_database also needs to be provided, as it is.
>>>
>>> From my rather limited understanding of SELinux I do not believe that 
>>> is a technical problem with having an object class, such as db_catalog, 
>>> that a particular DBMS does not use. Correct?
>>>     
>>
>> At least, I don't oppose to db_catalog class as far as we can make
>> clear the differences between databases, catalogs and schemas.
>> In PostgreSQL, it does not have an idea of catalog as a namespace
>> upper than schema, so we cannot handle these object obviously,
>> even if it is defined in the security policy.
>>
>> I have still a question. Is there any functional differences between
>> a catalog and a schema? If both of them works just a namespace, we
>> can apply db_schema class and its permission on both of catalogs and
>> schema.
>> In other word, when we accesses /var/log/messages, we need to have
>> privileges for /var and /var/log on dir class and /var/log/message
>> on file class. The reason why dir class is applied both of /var
>> and /var/log is these are same kind of object.
>> (Perhaps, this suggestion might be a misdesign.)
>>   
> Actually, I think using one object class to represent both schemata and 
> catalogs is a possibility. As I said before, we currently use the dir 
> object class to represent both, and it provides all of the SELinux 
> function we require, at this time. However, I think it may produce a bit 
> of confusion for the user (to use dir), as to why we use what appears to 
> be an OS object class within the database. Also, it would seem a bit odd 
> and possibly confusing to use an object class named db_schema on a 
> catalog object, when the DBMS has distinct objects called schema and 
> catalog.
> 
> From an SQL perspective, the general difference between a schema and a 
> catalog is that a catalog may only hold schemata. A schema may only hold 
> tables, views, etc. Also, according to the spec there should be an 
> Information Schema (which describes objects from all catalogs and 
> schemata) within each catalog. Though, we do not support this. There may 
> be other distinguishing factors, but I am not aware of them right now. 
> Note that a catalog may not hold catalogs and a schema may not hold 
> catalogs or schemata. So, in that sense there is a distinction between 
> them, where in your /var/log directory comparison there is no such 
> distinction. Both the /var and /var/log may each hold files and directories.
> 
> So, using one object class to represent both objects could create 
> confusion, in my opinion. Also, if in the future it becomes attractive 
> to have some distinct SELinux permission for catalogs and schemata, this 
> will not be an option if the same object class is chosen for both.
> 
> So, the bottom line for me is that I slightly would prefer having both 
> the db_catalog and db_schema object classes. If we have a single db 
> object class for both catalog and schema, I would suggest using some 
> generic name (e.g., db_dir) and not db_schema, to avoid confusion. I 
> more strongly prefer using one of the previous two options and have some 
> db_ class to cover the catalog and schema. Using the dir object class as 
> I have been seems a bit "hackish" to me. I would preface my opinion with 
> the fact that I know very little of the impact on the SELinux code of 
> having one extra object class or two extra object classes (or none).

OK, indeed, the namespaces in database (catalog and schema) has
a restriction about what kind of objects to be stored under them.
At least, I can agree the selinux policy have two new different
object classes, even if SE-PostgreSQL does not use db_catalog class.

I have one more point interested in. Could you make clear how does
the Trusted RUBIX assigns a security context on the newly created
database objects on the modified design?

We can obtain a security context for a new object using
security_compute_create() which provides us a result of TYPE_TRANSITION
rules, if configured.

In SE-PostgreSQL:
A new database object is labeled based only subject's context.

A new schema object will inherit the context of database, or be labeled
using TYPE_TRANSITION rules on db_schema class and the database.

A new table, procedure ans sequence will inherit the context of database,
or be labeled using TYPE_TRANSITION rules on its class and the schema.

A new column and tuple will inherit the context of table, or be labeled
using TYPE_TRANSITION rules on its class and the table.

A new largeobject is a headache for me. It does not belong to any schema.
Currently, it inherits the context of database, or be labeled using
TYPE_TRANSITION rules on its class and the database.
One considerable idea is to propose a facility to store largeobjects
under certain schema, but it is not an issue in SELinux.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
