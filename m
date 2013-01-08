Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r08FMNPC025312
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2013 10:22:23 -0500
Received: by mail-ob0-f173.google.com with SMTP id xn12so483269obc.32
        for <selinux@tycho.nsa.gov>; Tue, 08 Jan 2013 07:21:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50EC3644.2000600@tycho.nsa.gov>
References: <C1432A7484D61749AF22A060C2B03C5D1632046A18@StaEx7mb3.telecom.sna.samsung.com>
	<50EC3644.2000600@tycho.nsa.gov>
Date: Tue, 8 Jan 2013 10:21:51 -0500
Message-ID: <CACLa4ptCvT4S_MY67AUE41fRH_Xy_m69Gi+rWMoh4X1Yv-DJGw@mail.gmail.com>
Subject: Re: Fixing external/checkpolicy issues found by Klocwork
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Alice Chu <alice.chu@sta.samsung.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've recently done a bunch of work to handle errors found by coverity.
 I'll take a look at these and see which still make sense.  Thanks!

On Tue, Jan 8, 2013 at 10:07 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 01/07/2013 08:29 PM, Alice Chu wrote:
>>
>> Hello,
>>
>> Attached you will find the Klocwork report on seandroid master branch
>> external/checkpolicy. The following is the fix for issues found in
>> policy_define.c.
>> Please review and give me your feedback.
>>
>> Thank you very much,
>> Alice Chu
>>
>>
>> ============================================================================
>>>
>>> From 18555451c5831fd95044e665d3dc514eb69e3b75 Mon Sep 17 00:00:00 2001
>>
>> From: Alice Chu <alice.chu@sta.samsung.com>
>> Date: Mon, 7 Jan 2013 15:29:29 -0800
>> Subject: [PATCH] Fix issues found by Klocwork
>>
>> Change-Id: Ic3a01364b6855529f6b58a8820c6011a22c21841
>> ---
>>   policy_define.c |   24 +++++++++++++++++++-----
>>   1 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/policy_define.c b/policy_define.c
>> index 2c12447..504af69 100644
>> --- a/policy_define.c
>> +++ b/policy_define.c
>> @@ -3583,6 +3591,11 @@ static int parse_security_context(context_struct_t
>> * c)
>>         }
>>
>>         context_init(c);
>> +       /* check context c to make sure ok to dereference c later */
>> +       if (c == NULL) {
>> +               yyerror("null context pointer!");
>> +               goto bad;
>> +       }
>>
>>         /* extract the user */
>>         id = queue_remove(id_queue);
>
>
> I think you want this check before context_init(), as it dereferences c.
> And then just return -1 in the error path.
> This btw is an illegal state as NULL should only be passed if pass == 1.
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
