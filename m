Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7HFZd2T009202
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 11:35:39 -0400
Received: from nm22-vm0.bullet.mail.ac4.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p7HFZcU6023625
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 15:35:38 GMT
Message-ID: <4E4BDF8A.5090703@schaufler-ca.com>
Date: Wed, 17 Aug 2011 08:34:34 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: selinux@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: inclusion of selinux.h in cred.h
References: <4E4B4CF8.6080800@schaufler-ca.com> <CACLa4psgw+FzdJb_TUZdCmakeFrQMOVaFynsPYEe_93RHQCSrw@mail.gmail.com>
In-Reply-To: <CACLa4psgw+FzdJb_TUZdCmakeFrQMOVaFynsPYEe_93RHQCSrw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/17/2011 6:35 AM, Eric Paris wrote:
> On Wed, Aug 17, 2011 at 1:09 AM, Casey Schaufler<casey@schaufler-ca.com>  wrote:
>> Is there some reason that linux/selinux.h is
>> #included in linux/cred.h?
>>
>> I've been building kernels with the inclusion
>> commented out and I have encountered no problems.
>>
>> It's not a problem, but I am curious.
> It can be safely moved, but not removed.  This was added when
> creds_are_invalid() was implemented in the header, which makes SELinux
> specific calls (see commit ed868a56988464cd31de0302426a5e94d3127f10).
> This function was moved to kernel/cred.c in commit
> 74908a0009eb36054190ab80deb9671014efed96 but the header was not moved
> with it.  If you want to send a patch to move the header from cred.h
> to cred.c I think that would make a lot of sense.

Enlightenment. Thank you.

Since creds_are_invalid() only exists under CONFIG_DEBUG_CREDENTIALS
I would expect the include of selinux.h to be under that ifdef as well.

>
> -Eric
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
