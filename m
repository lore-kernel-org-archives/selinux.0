Message-ID: <4B958987.30807@ak.jp.nec.com>
Date: Tue, 09 Mar 2010 08:34:31 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp> <4B0DBDF2.5050601@ak.jp.nec.com> <4B14396A.9000207@tycho.nsa.gov> <4B8C7D8C.9060803@ak.jp.nec.com> <4B9584A3.1070603@tycho.nsa.gov> <4B958795.6060403@rubix.com>
In-Reply-To: <4B958795.6060403@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/03/09 8:26), Andy Warner wrote:
> 
> 
> On 3/8/2010 6:13 PM, Eamon Walsh wrote:
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
>>
> 
> Regarding the sepgsql_contexts name, is this functionality targeted only
> for sepgsql, or would another DBMS be able to us it (e.g, Trusted
> RUBIX)? if others would be able to use the functionality, would each
> DBMS have their own *_contexts file, or would all use sepgsql_contexts?
> 

It allows to give a path to be parsed using SELABEL_OPT_PATH option.
The "sepgsql_context" is just a default.

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
