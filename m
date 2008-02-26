Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1Q37vju017868
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 22:07:58 -0500
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1Q37teq009313
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 03:07:56 GMT
Message-ID: <47C38287.4080302@ak.jp.nec.com>
Date: Tue, 26 Feb 2008 12:07:51 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com> <1203957028.32061.69.camel@gorn>
In-Reply-To: <1203957028.32061.69.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2008-02-13 at 18:29 +0900, Kohei KaiGai wrote:
>> The attached patch adds support for SE-PostgreSQL.
>> Most part of them are same as currently we are distributing via RPM package.
>>
>> This patch adds some booleans, attributes and types.
>> You can find out the detailed description about works of them in the chapter 5
>> of "The Security-Enhanced PostgreSQL Security Guide".
>> See, http://sepgsql.googlecode.com/files/sepgsql_security_guide.20070903.en.pdf
>>
>> Any comment please,
> 
> Just like with the X server, I don't believe that sepostgres should have
> its own module.

OK, I'll make next one as a patch for services/postgresql.*.

> At first glance, there appears to be too many
> attributes.  I'm guessing that you're doing the same thing that is done
> with the *_unconfined() interfaces.  We mainly do that to optimize size
> since unconfined brings in so many rules.

OK, I'll replace current interfaces by the following style's one.

interface(`sepostgresql_unconfined',`
         gen_require(`
                 attribute sepostgresql_unconfined_type;
         ')
         typeattribute $1 sepostgresql_unconfined_type;
')

> I also see references to types and attributes that belong do the module.

Is it unlabel_t and system_r?
Where is the best place to associate them with my local policy?

 > Also the auditing
> tunables seem unneeded; they seem to be more for debugging use.  I think
> I can get a better handle on the policy with these revisions.

Hmm...
The reason why I added these tunables is that database folks told me
that collecting logs in column/tuple level is an attractive feature,
because native DBMS cannot provide fine-grained access control and
cannot collect logs in these level.
Thus, I believe the feature to turn on/off auditing readily should
be remained.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
