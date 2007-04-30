Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UEPjk7029812
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 10:25:45 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3UEPiid025288
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 14:25:44 GMT
Message-ID: <4635FC63.3000003@redhat.com>
Date: Mon, 30 Apr 2007 10:25:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Steve G <linux_4ever@yahoo.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to cleanup audit handling in policy.
References: <254813.17034.qm@web51501.mail.re2.yahoo.com> <1177942650.3570.78.camel@sgc>
In-Reply-To: <1177942650.3570.78.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2007-04-27 at 16:38 -0700, Steve G wrote:
>   
>>> I have removed -send_audit_msgs_pattern and replaced it with 4 functions 
>>>       
>> I'd like to clarify what they are in case anyone thinks the names need tweeking
>>
>> logging_send_audit_msg - This is for any Trusted App that needs to send audit
>> events
>>
>> logging_set_loginuid - This would be for entry point daemons or daemons that
>> perform actions on behalf of a user (cron/at). Includes the ability to send audit
>> events.
>>
>> logging_set_audit - This should be for the audit daemon only
>>
>> logging_set_auditctl - This is only for auditctl and autrace.
>>     
>
> I'm not convinced that these are necessary.  The assertions in the
> policy are mainly to stop people from accidentally shooting themselves
> in the foot by allowing potentially dangerous access, for example,
> access to /etc/shadow or raw disk access.
>
>   
When I reviewed the policy, almost ever call to allow audit was wrong.  
I think we should
take advantage of the tools to allow policy writers to accidently grant 
more access then is
necessary.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
