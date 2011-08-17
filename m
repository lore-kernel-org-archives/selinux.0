Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7HFbpUi009319
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 11:37:51 -0400
Received: from mail-gx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7HFbojW006661
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 15:37:50 GMT
Received: by gxk9 with SMTP id 9so1059331gxk.12
        for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 08:37:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E4BDF8A.5090703@schaufler-ca.com>
References: <4E4B4CF8.6080800@schaufler-ca.com>
	<CACLa4psgw+FzdJb_TUZdCmakeFrQMOVaFynsPYEe_93RHQCSrw@mail.gmail.com>
	<4E4BDF8A.5090703@schaufler-ca.com>
Date: Wed, 17 Aug 2011 11:37:50 -0400
Message-ID: <CACLa4pvDW9MQ0KNznuMQh2wzRDwSnQMhgvh4JV7NkEARiakhrw@mail.gmail.com>
Subject: Re: inclusion of selinux.h in cred.h
From: Eric Paris <eparis@parisplace.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 17, 2011 at 11:34 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 8/17/2011 6:35 AM, Eric Paris wrote:
>>
>> On Wed, Aug 17, 2011 at 1:09 AM, Casey Schaufler<casey@schaufler-ca.com>
>>  wrote:
>>>
>>> Is there some reason that linux/selinux.h is
>>> #included in linux/cred.h?
>>>
>>> I've been building kernels with the inclusion
>>> commented out and I have encountered no problems.
>>>
>>> It's not a problem, but I am curious.
>>
>> It can be safely moved, but not removed.  This was added when
>> creds_are_invalid() was implemented in the header, which makes SELinux
>> specific calls (see commit ed868a56988464cd31de0302426a5e94d3127f10).
>> This function was moved to kernel/cred.c in commit
>> 74908a0009eb36054190ab80deb9671014efed96 but the header was not moved
>> with it.  If you want to send a patch to move the header from cred.h
>> to cred.c I think that would make a lot of sense.
>
> Enlightenment. Thank you.
>
> Since creds_are_invalid() only exists under CONFIG_DEBUG_CREDENTIALS
> I would expect the include of selinux.h to be under that ifdef as well.

Seems quite reasonable to me...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
