Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHIlGMh006789
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 13:47:16 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHIkWwh024004
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 18:46:33 GMT
Message-ID: <455E03BD.6020501@redhat.com>
Date: Fri, 17 Nov 2006 13:47:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Klaus Weidner <klaus@atsec.com>, Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: MLS policy constraints verification
References: <20061111183721.GA629@w-m-p.com> <1163426567.18181.104.camel@sgc.columbia.tresys.com>
In-Reply-To: <1163426567.18181.104.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Sat, 2006-11-11 at 12:37 -0600, Klaus Weidner wrote:
>   
>> in the ongoing LSPP evaluation project, a review of the constraints
>> defined in "policy/mls" in the refpolicy turned up some suspicious
>> entries.
>>
>> Could people who wrote the policy or have opinions on what it's supposed
>> to be please comment?
>>     
>
> The constraints are almost all from the old example policy and were
> written by TCS since they did the enhanced MLS support.  Since I'm not
> familiar with the LSPP requirements, I can't speak to whether or not the
> MLS is strict enough to meet the requirements.  Chad, Darrel?
>
>   
Klous do you have a patch that you want applied to modify the constraints?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
