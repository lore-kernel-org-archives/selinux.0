Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UFaKK5002948
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 11:36:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3UFaJid006607
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 15:36:19 GMT
Message-ID: <46360CEB.3020106@redhat.com>
Date: Mon, 30 Apr 2007 11:36:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Steve G <linux_4ever@yahoo.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to cleanup audit handling in policy.
References: <254813.17034.qm@web51501.mail.re2.yahoo.com>	 <1177942650.3570.78.camel@sgc>  <4635FC63.3000003@redhat.com>	 <1177943981.3570.90.camel@sgc>  <4636036C.8060208@redhat.com> <1177946990.3570.103.camel@sgc>
In-Reply-To: <1177946990.3570.103.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2007-04-30 at 10:55 -0400, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> On Mon, 2007-04-30 at 10:25 -0400, Daniel J Walsh wrote:
>>>   
>>>       
>>>> Christopher J. PeBenito wrote:
>>>>     
>>>>         
>>>>> On Fri, 2007-04-27 at 16:38 -0700, Steve G wrote:
>>>>>   
>>>>>       
>>>>>           
>>>>>>> I have removed -send_audit_msgs_pattern and replaced it with 4 functions 
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>>> I'd like to clarify what they are in case anyone thinks the names need tweeking
>>>>>>
>>>>>> logging_send_audit_msg - This is for any Trusted App that needs to send audit
>>>>>> events
>>>>>>
>>>>>> logging_set_loginuid - This would be for entry point daemons or daemons that
>>>>>> perform actions on behalf of a user (cron/at). Includes the ability to send audit
>>>>>> events.
>>>>>>
>>>>>> logging_set_audit - This should be for the audit daemon only
>>>>>>
>>>>>> logging_set_auditctl - This is only for auditctl and autrace.
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> I'm not convinced that these are necessary.  The assertions in the
>>>>> policy are mainly to stop people from accidentally shooting themselves
>>>>> in the foot by allowing potentially dangerous access, for example,
>>>>> access to /etc/shadow or raw disk access.
>>>>>
>>>>>   
>>>>>       
>>>>>           
>>>> When I reviewed the policy, almost ever call to allow audit was wrong.  
>>>>     
>>>>         
>>> Wrong in what sense?
>>>
>>>       
>> Wrong in the sense of granting more privs then they intended.  Login 
>> programs being able to change the audit rules.  audit_control versus 
>> audit_write and netlinkmsg_write versus netlinkmsg_relay.  Better to put 
>> them into interfaces and force policy writers to use them.
>>     
>
> This is an argument for more patterns, which would be fine.
>
>   

Why would we want patterns over interfaces?  We can not use constraints 
in interfaces.  I want constraints to stop people from making dumb 
mistakes.  The interface most often uses is logging_send_audit_msg which 
matches up very closely to logging_send_syslog_msg.  To me patterns make 
no sense here, these are interfaces.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
