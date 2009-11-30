Message-ID: <4B14396A.9000207@tycho.nsa.gov>
Date: Mon, 30 Nov 2009 16:30:18 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selabel_*() support for database objects
References: <4B050008.3010201@ak.jp.nec.com> <4B0757F5.5080902@tycho.nsa.gov> <4B07F64B.1070407@kaigai.gr.jp> <4B0DBDF2.5050601@ak.jp.nec.com>
In-Reply-To: <4B0DBDF2.5050601@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/25/2009 06:29 PM, KaiGai Kohei wrote:
> KaiGai Kohei wrote:
>   
>> Eamon Walsh wrote:
>>     
>>> On 11/19/2009 03:21 AM, KaiGai Kohei wrote:
>>>       
>>>> This patch allows selabel_*() interfaces to provide an expected security context
>>>> for the given database object identified by its name and object class.
>>>> It is necessary to implement a feature something like the restorecon on databases.
>>>>         
>>> The patch is whitespace damaged, can you re-send it as a text attachment.
>>>
>>>       
>> Does the attached one still damaged?
>>
>>     
> Sorry, my careless misses. It didn't attach the patch body.
>
> The attached one contains the patch with tab-indents.
>
> Thanks,
>   


Looks good to me,

Acked-by: Eamon Walsh <ewalsh@tycho.nsa.gov>



-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
