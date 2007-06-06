Message-ID: <46673242.1060909@tresys.com>
Date: Wed, 06 Jun 2007 18:16:34 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/5] libselinux: rename existing name<->value functions
 for	compat
References: <1181157051.6578.36.camel@sgc.columbia.tresys.com> <46671547.5010604@tycho.nsa.gov>
In-Reply-To: <46671547.5010604@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Christopher J. PeBenito wrote:
> 
> [snip]
> 
>> -const char *security_class_to_string(security_class_t tclass)
>> +static const char *security_class_to_string_compat(security_class_t 
>> tclass)
>>  {
>>      tclass = (tclass > 0 && tclass < NCLASSES) ? tclass : 0;
>>      return class_to_string_data.str + class_to_string[tclass];
>>  }
>>  
> 
> This will have to be rebased to the errno patch r2463 in trunk.  Also, 
> the behavior should be identical on the new functions (return EINVAL in 
> the same manner).
> 
> This patchset should go in prior to the mapping patchset I posted today.
> 

Has anyone stacked these patches yet to see if they integrate as 
expected? I assume they will since Chris' patches just change the 
interfaces that you were using to obtain the kernel values.

This seems to have worked out well assuming the integration fell out 
naturally :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
