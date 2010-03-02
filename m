Message-ID: <4B8C7D8C.9060803@ak.jp.nec.com>
Date: Tue, 02 Mar 2010 11:53:00 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp> <4B0DBDF2.5050601@ak.jp.nec.com> <4B14396A.9000207@tycho.nsa.gov>
In-Reply-To: <4B14396A.9000207@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2009/12/01 6:30), Eamon Walsh wrote:
> On 11/25/2009 06:29 PM, KaiGai Kohei wrote:
>> KaiGai Kohei wrote:
>>
>>> Eamon Walsh wrote:
>>>
>>>> On 11/19/2009 03:21 AM, KaiGai Kohei wrote:
>>>>
>>>>> This patch allows selabel_*() interfaces to provide an expected security context
>>>>> for the given database object identified by its name and object class.
>>>>> It is necessary to implement a feature something like the restorecon on databases.
>>>>>
>>>> The patch is whitespace damaged, can you re-send it as a text attachment.
>>>>
>>>>
>>> Does the attached one still damaged?
>>>
>>>
>> Sorry, my careless misses. It didn't attach the patch body.
>>
>> The attached one contains the patch with tab-indents.
>>
>> Thanks,
>>
> 
> 
> Looks good to me,
> 
> Acked-by: Eamon Walsh<ewalsh@tycho.nsa.gov>

What is the current status of the patch?

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
