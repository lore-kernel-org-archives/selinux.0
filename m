Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAIFAiMA021231
	for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2005 10:10:44 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAIF2poG004397
	for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2005 15:02:51 GMT
Message-ID: <437DED16.4090506@redhat.com>
Date: Fri, 18 Nov 2005 10:02:46 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Current Reference Policy patch
References: <437CA7D7.6090308@redhat.com> <1132254164.7259.61.camel@sgc.columbia.tresys.com>
In-Reply-To: <1132254164.7259.61.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2005-11-17 at 10:55 -0500, Daniel J Walsh wrote:
>   
>> Need to turn on rpm and not alias to unconfined_t, because the rule
>>
>> rpm_t->shell_exec_t->rpm_script_t was causing all terminal windows to 
>> run in rpm_script_t in targeted.
>>     
>
> Yesterday I disabled that transition in targeted (it was the one causing
> the xdm logins to go to rpm_script_t), so do you still want to rpm_t as
> non-aliased?
>
>   
Yes.  Lets move that way and see how it works.
>> Allow users to su to root and then suspend the session.
>>
>> Pegasus policy was too loose.
>> /bin/ksh should be sheel_exec_t
>> (.*)?  is the same as .* and causes python to blow up.
>>
>>     


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
