Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7JCwZw9014661
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 08:58:38 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o7JCww6r027836
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 12:59:00 GMT
Message-ID: <4C6D2A73.6020302@tresys.com>
Date: Thu, 19 Aug 2010 08:58:27 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: TaurusHarry <harrytaurus2002@hotmail.com>,
        refpolicy-mailing-list <refpolicy@oss1.tresys.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Problem about audit-test-2090 + refpolicy-2.20091117
References: <SNT139-w318948F5C7E5124B30AB6AAB9D0@phx.gbl> <1282132367.4122.8.camel@flek>
In-Reply-To: <1282132367.4122.8.camel@flek>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/18/10 07:52, Paul Moore wrote:
> On Wed, 2010-08-18 at 10:26 +0000, TaurusHarry wrote:
>> Hi SELinux exports,
>>
>> When I am trying to build the lspp_test.pp provided by
>> audit-test-2090/utils/selinux-policy/lspp_test.* along with the
>> refpolicy-20091117 source code, I copied lspp_test.* files to
>> policy/modules/apps/ and then modified policy/modules.conf to declare
>> "lspp_test = module", but I run into below error message ...
>
> Is there any reason why you copied the lspp_test policy files to the
> refpolicy sources and tried to build it there?  I'm not completely sure
> that this is the cause of your problem but I can say for certain that
> this is not a tested procedure for building the lspp_test module.

I wouldn't expect this to introduce problems, unless the headers in the 
policy source didn't match the target system's base policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
