Message-ID: <4B9EBEFC.7080805@tycho.nsa.gov>
Date: Mon, 15 Mar 2010 19:13:00 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Andy Warner <warner@rubix.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp> <4B0DBDF2.5050601@ak.jp.nec.com> <4B14396A.9000207@tycho.nsa.gov> <4B8C7D8C.9060803@ak.jp.nec.com> <4B9584A3.1070603@tycho.nsa.gov> <4B9598F1.50309@ak.jp.nec.com> <4B95A2D2.3080101@tycho.nsa.gov> <4B95A780.8050300@ak.jp.nec.com> <4B96AAA7.5090909@tycho.nsa.gov> <4B96C8CA.1090301@kaigai.gr.jp> <4B97D2D0.3010507@tycho.nsa.gov> <4B97DF3C.6070601@rubix.com> <4B987150.10609@ak.jp.nec.com> <4B99934E.2030802@ak.jp.nec.com>
In-Reply-To: <4B99934E.2030802@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/11/2010 08:05 PM, KaiGai Kohei wrote:
>>> Lastly, regarding tuples, I noticed the ability to label tuples was
>>> removed because tuples are not named. Would it be useful to label all
>>> tuples under an object (e.g., table) as follows. I am sure you
>>> considered this, just curious of your thoughts:
>>>
>>> db_tuple *.pg_catalog.pg_table.* system_u:object_r:sepgsql_tuple_t:s0
>>>
>>> So that all tuples under the *.pg_catalog.pg_table table would have a
>>> context of system_u:object_r:sepgsql_tuple_t:s0. Or, is the fact that
>>> you are not able to use anything other than * as the tuple's name simply
>>> make things too messy? I would assume there would be a similar issue in
>>> constructing a key value for a tuple in the call to selabel_lookup.
>>>       
>> Hmm. Indeed, it makes sense.
>> I'll add db_tuple again. Please wait for a while.
>>     
> The attached patch supports initial labeling of db_tuple class again.
>
> If DBMS identifies tuples using the relation which owns the tuples,
> libselinux can return a hint of the security context to be assigned.
>   

I have committed this patch and released libselinux 2.0.93.

To follow up on Andy's concerns: the patch includes the db_tuple
labeling keyword as you requested. But you also need support for
db_catalog and db_schema object classes in the policy, is that correct?
I can't see any reason not to add them, although I don't know what
permissions they would need.


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
