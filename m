Message-ID: <4B95A2D2.3080101@tycho.nsa.gov>
Date: Mon, 08 Mar 2010 20:22:26 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp> <4B0DBDF2.5050601@ak.jp.nec.com> <4B14396A.9000207@tycho.nsa.gov> <4B8C7D8C.9060803@ak.jp.nec.com> <4B9584A3.1070603@tycho.nsa.gov> <4B9598F1.50309@ak.jp.nec.com>
In-Reply-To: <4B9598F1.50309@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/08/2010 07:40 PM, KaiGai Kohei wrote:
> (2010/03/09 8:13), Eamon Walsh wrote:
>   
>> On 03/01/2010 09:53 PM, KaiGai Kohei wrote:
>>     
>>> What is the current status of the patch?
>>>
>>> Thanks,
>>>
>>>       
>>
>> Can you send me a sample sepgsql_contexts file so I can test this?
>>
>>     
> The attached selabel-test.conf is an example specfile, and the selabel-test.c
> is a sample program to lookup an expected security context for the given name.
>
>   $ gcc selabel-test.c -o selabel-test -lselinux \
>         -I repo/selinux/libselinux/include/ \
>         -L repo/selinux/libselinux/src/
>   $ ./selabel-test selabel-test.conf db_table postgres.pg_catalog.pg_class
>   "postgres.pg_catalog.pg_class" => "system_u:object_r:sepgsql_sysobj_t:s0"
>   $ ./selabel-test selabel-test.conf db_table postgres.pg_public.my_table
>   "postgres.pg_public.my_table" => "system_u:object_r:sepgsql_table_t:s0"
>   $ ./selabel-test selabel-test.conf db_table foovarbaz
>   failed to lookup : "foovarbaz" (No such file or directory)
>
> In PostgreSQL, its namespace has the following structure:
>   <database>.<schema>.(<table>|<view>|<procedure>|...)
>
> So, the example specfile defines the following lines:
>   db_table    *.pg_catalog.*     system_u:object_r:sepgsql_sysobj_t:s0
>
> It informs all tables under the "pg_catalog" schema should be labeled as
> "system_u:object_r:sepgsql_sysobj_t:s0".
>
> Andy, in rubix, the specfile should be described as follows:
>   db_table    *.*.*.*            system_u:object_r:rubix_table_t:s0
>
> The library just does pattern matching without any assumption of database
> architecture.
>
>
> I also noticed the previous patch allows to lookup an expected security
> context for the db_tuple object class, but tuples don't have their name
> basically, so I removed it.
> And, it didn't support an upcoming db_view object class, I added it instead.
>
> Thanks,
>   


This patch is missing the new files label_db.c and selabel_db.5.

Also, in the previous patch, the file selabel_db.c had two instances of
trailing whitespace: lines 20 and 55. Please fix those up and re-send.


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
