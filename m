Message-ID: <4B9ECA63.1040503@ak.jp.nec.com>
Date: Tue, 16 Mar 2010 09:01:39 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Andy Warner <warner@rubix.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp> <4B0DBDF2.5050601@ak.jp.nec.com> <4B14396A.9000207@tycho.nsa.gov> <4B8C7D8C.9060803@ak.jp.nec.com> <4B9584A3.1070603@tycho.nsa.gov> <4B9598F1.50309@ak.jp.nec.com> <4B95A2D2.3080101@tycho.nsa.gov> <4B95A780.8050300@ak.jp.nec.com> <4B96AAA7.5090909@tycho.nsa.gov> <4B96C8CA.1090301@kaigai.gr.jp> <4B97D2D0.3010507@tycho.nsa.gov> <4B97DF3C.6070601@rubix.com> <4B987150.10609@ak.jp.nec.com> <4B99934E.2030802@ak.jp.nec.com> <4B9EBEFC.7080805@tycho.nsa.gov>
In-Reply-To: <4B9EBEFC.7080805@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/03/16 8:13), Eamon Walsh wrote:
> On 03/11/2010 08:05 PM, KaiGai Kohei wrote:
>>>> Lastly, regarding tuples, I noticed the ability to label tuples was
>>>> removed because tuples are not named. Would it be useful to label all
>>>> tuples under an object (e.g., table) as follows. I am sure you
>>>> considered this, just curious of your thoughts:
>>>>
>>>> db_tuple *.pg_catalog.pg_table.* system_u:object_r:sepgsql_tuple_t:s0
>>>>
>>>> So that all tuples under the *.pg_catalog.pg_table table would have a
>>>> context of system_u:object_r:sepgsql_tuple_t:s0. Or, is the fact that
>>>> you are not able to use anything other than * as the tuple's name simply
>>>> make things too messy? I would assume there would be a similar issue in
>>>> constructing a key value for a tuple in the call to selabel_lookup.
>>>>
>>> Hmm. Indeed, it makes sense.
>>> I'll add db_tuple again. Please wait for a while.
>>>
>> The attached patch supports initial labeling of db_tuple class again.
>>
>> If DBMS identifies tuples using the relation which owns the tuples,
>> libselinux can return a hint of the security context to be assigned.
>>
> 
> I have committed this patch and released libselinux 2.0.93.
> 
> To follow up on Andy's concerns: the patch includes the db_tuple
> labeling keyword as you requested. But you also need support for
> db_catalog and db_schema object classes in the policy, is that correct?

Yes, correct. This update enables libselinux to provide a hint for
initial labeling on some kind of database object class including
ones which are not included yet.

> I can't see any reason not to add them, although I don't know what
> permissions they would need.

Unfortunately, we are still under working to get support SELinux in
PostgreSQL. It means here is a risk that its specifications are
changed to unexpected form.
(However, I thought they misunderstood SE-PostgreSQL _replaces_ its
existing permission checks and models, not an additional ones.
It might be a reason why they concerned about security features.)

Andy, if your concern is mainly addressed to default security context
under the catalog or schema object, here is a workaround hack.

The string_to_security_class() returns zero, if undefined object class
was given, such as "db_schema". If we provide security_compute_create()
a zero as object class code, it returns the target security context
(expect for "user" field; it is copied from subject context) as new
one.
It means, if we label the database as "system_u:object_r:sepgsql_db_t:s0",
we can also apply this context for catalogs/schemas until the default
policy does not have definition of db_schema/db_catalog classes.

e.g)
  [kaigai@saba selinux]$ php -r 'echo selinux_compute_create("unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023","system_u:object_r:sepgsql_db_t:s0","db_catalog")."\n";'
  unconfined_u:object_r:sepgsql_db_t:s0
  ^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^^^^^^
  copied from     copied from tcontext
  scontext

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
