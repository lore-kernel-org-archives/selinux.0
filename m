Message-ID: <4B97DF3C.6070601@rubix.com>
Date: Wed, 10 Mar 2010 13:04:44 -0500
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp> <4B0DBDF2.5050601@ak.jp.nec.com> <4B14396A.9000207@tycho.nsa.gov> <4B8C7D8C.9060803@ak.jp.nec.com> <4B9584A3.1070603@tycho.nsa.gov> <4B9598F1.50309@ak.jp.nec.com> <4B95A2D2.3080101@tycho.nsa.gov> <4B95A780.8050300@ak.jp.nec.com> <4B96AAA7.5090909@tycho.nsa.gov> <4B96C8CA.1090301@kaigai.gr.jp> <4B97D2D0.3010507@tycho.nsa.gov>
In-Reply-To: <4B97D2D0.3010507@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On 3/10/2010 12:11 PM, Eamon Walsh wrote:
> On 03/09/2010 05:16 PM, KaiGai Kohei wrote:
>   
>> (2010/03/10 5:08), Eamon Walsh wrote:
>>   
>>     
>>> What is the meaning of the fourth "temp" argument here. Aren't lines
>>> only supposed to have three entries? Please remove this if it is not needed.
>>>     
>>>       
>> If the line has four or more elements, we want to raise an error, rather than
>> ignoring it.
>> If here is not the fourth %as, sscanf() does not return 4, does it?
>>
>> Thanks,
>>   
>>     
>
> OK, that makes sense.
>
> I don't see any other issues with the patches. Unless Andy has any
> concerns, I will push them later today or tomorrow.
>   

What is implemented looks fine to me. Just a few comments and questions.

Only thing that may keep us from fully using this functionality is that
because there is not support for db_schema and db_catalog objects, it
can't fully cover our labeled objects (correct?). Our naming scheme is
database.catalog.schema.table, so I am guessing only the database and
table could be labeled explicitly through the *_contexts file. It would
probably confuse our customers to be able to assign contexts to some
objects but not others. This might delay our use of it until the new DB
object classes come out.

We currently overload the dir object class to cover our catalog and
schema objects. This is not great, but the best choice we have to cover
those objects. KaiGai, is it possible to actually use a dir object class
within the *_contexts file? I acknowledge overloading/mixing these
object classes (db and OS) is controversial and not the best solution,
but I am curious if it would be technically possible under this patch.
Or, does it restrict its functionality to only db objects?

Lastly, regarding tuples, I noticed the ability to label tuples was
removed because tuples are not named. Would it be useful to label all
tuples under an object (e.g., table) as follows. I am sure you
considered this, just curious of your thoughts:

db_tuple *.pg_catalog.pg_table.* system_u:object_r:sepgsql_tuple_t:s0

So that all tuples under the *.pg_catalog.pg_table table would have a
context of system_u:object_r:sepgsql_tuple_t:s0. Or, is the fact that
you are not able to use anything other than * as the tuple's name simply
make things too messy? I would assume there would be a similar issue in
constructing a key value for a tuple in the call to selabel_lookup.

Andy

>
>   

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
