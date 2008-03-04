Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24FGgL3027276
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 10:16:42 -0500
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m24FGcRe019449
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 15:16:39 GMT
Message-ID: <47CD67CB.3060305@kaigai.gr.jp>
Date: Wed, 05 Mar 2008 00:16:27 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Kohei KaiGai <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com> <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com> <47C5189B.9070500@ak.jp.nec.com>
In-Reply-To: <47C5189B.9070500@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kohei KaiGai wrote:
> The attached patch provides security policies related to SE-PostgreSQL.
> 
> The followings are updates/unchanges from the previous version submitted
> at two weeks ago. These updates replaced most of the part in the previous
> one.
> 
> - The targets of this patch are moved to services/postgresql.*,
>   although the previous one added new entries.
> - Any interface got slim. They contains only one TYPEATTRIBUTE
>   statement, and postgresql.te allows most of permissions to
>   the associated attributes.
> * Tunables to turn on/off audit are remained now, because database
>   folks told me fine-grained logs are worthwhile feature.
> 
> Any comment please,
> 
> Thanks,

Chris,

What is the current status of the patch?

>>> Just like with the X server, I don't believe that sepostgres should have
>>> its own module.
>>
>> OK, I'll make next one as a patch for services/postgresql.*.
>>
>>> At first glance, there appears to be too many
>>> attributes.  I'm guessing that you're doing the same thing that is done
>>> with the *_unconfined() interfaces.  We mainly do that to optimize size
>>> since unconfined brings in so many rules.
>>
>> OK, I'll replace current interfaces by the following style's one.
>>
>> interface(`sepostgresql_unconfined',`
>>         gen_require(`
>>                 attribute sepostgresql_unconfined_type;
>>         ')
>>         typeattribute $1 sepostgresql_unconfined_type;
>> ')
>>
>>> I also see references to types and attributes that belong do the module.
>>
>> Is it unlabel_t and system_r?
>> Where is the best place to associate them with my local policy?
>>
>>  > Also the auditing
>>> tunables seem unneeded; they seem to be more for debugging use.  I think
>>> I can get a better handle on the policy with these revisions.
>>
>> Hmm...
>> The reason why I added these tunables is that database folks told me
>> that collecting logs in column/tuple level is an attractive feature,
>> because native DBMS cannot provide fine-grained access control and
>> cannot collect logs in these level.
>> Thus, I believe the feature to turn on/off auditing readily should
>> be remained.
>>
>> Thanks,
> 
> 


-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
