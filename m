Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2UDN0GX001365
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 09:23:00 -0400
Received: from mail1.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2UDMw3E007878
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 13:22:59 GMT
Message-ID: <49D0C7A3.7040006@kaigai.gr.jp>
Date: Mon, 30 Mar 2009 22:22:43 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>,
        Joshua Brindle <method@manicmethod.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com> <49CD687C.9080401@kaigai.gr.jp> <49CDCF07.1020900@rubix.com> <49D018A3.2090304@ak.jp.nec.com> <49D08105.2090607@ak.jp.nec.com> <49D097C3.3010404@rubix.com>
In-Reply-To: <49D097C3.3010404@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> Under the enhancement, we should the following rules to determine what
>> security context is assigned on the newly created database object.
>>
>> 1. An explicitly specified security context by users.
>>    e.g)  CREATE TABLE t (a int, b text)
>>              SECURITY_LABEL = 'system_u:object_r:sepgsql_table_t:SystemHigh';
>>
>> 2. A matched entry in the configuration file which can be lookup up
>>    by selabel_lookup(3).
>>    e.g)  schema  pg_temp_*  system_u:object_r:sepgsql_temp_schema_t:s0
>>                  ^^^^^^^^^ --> if the new object name and type are matched.
>>
>> 3. The result of security_compute_av() or avc_compute_create() which can
>>    return the result of TYPE_TRANSITION rules.
>>
>> The second step is newly suggested in this patch.
>> Needless to say, the determinded security context has to be checked
>> by the security policy.
>>
>>   
>>> One concern is performance hit. If we need to open/lookup/close the file
>>> for each INSERT statement, its pain will be unacceptable.
>>>     
>>
>> This patch does not support db_tuple class, because of headach in performance
>> and its characteristic that database tuples have no name to identify itself.
>>   
> Good decision about not including the tuple. I'm guessing that without 
> the tuple, the lookup would generally have small impact on overall 
> performance.
> 
> Is it standard in SELinux to have the selabel_lookup have higher 
> priority over any type transition rule? I was always curious about that.

Please note that the security policy has to allow the client db_xxxx:{create}
privilege on creation of database object independent from its labeling
strategy. Don't confound the way to specify an explicit label and permission
to create a database object. :-)

>From an analogy of filesystem, if we can put a valid security context on
/proc/self/attr/fscreate, it enables us to *try to create* a file with
discretionary label, but it does not mean that the file:{create} permission
is always allowed on any given labels.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
