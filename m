Message-ID: <43D0F263.3010109@redhat.com>
Date: Fri, 20 Jan 2006 09:23:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Further bugfixes
References: <43D0383C.8010404@cornell.edu>	 <200601202321.07517.russell@coker.com.au> <1137762568.3648.101.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1137762568.3648.101.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-01-20 at 23:20 +1100, Russell Coker wrote:
>   
>> >From a patch to the semanage program:
>> +semanage fcontext [-admhfrst] CONTEXT_EXPRESSION\n\
>> +semanage interface [-admtr] INTERFACE_NAME\n\
>>  semanage login [-admsr] LOGIN_NAME\n\
>> -semanage port [-admtpr] PORT | PORTRANGE\n\
>> +semanage port [-admtpr] PORT | PORT_RANGE\n\
>>
>> I think that all of these should be changed similar to my revised man page 
>> (which I posted under the subject "semanage patch" on the 14th of Jan).
>>     
>
> IIRC, that was merged as part of a set of diffs from Dan for
> policycoreutils in 1.29.8 on the 18th of January.
>
>   
>> I would offer a patch for this, but I think we have enough unmerged patches 
>> for the semanage utility floating around at the moment.  Once we get the 
>> current patches sorted out I'll be happy to write a patch for this.
>>     
>
> Only ones I have queued are one from Joshua yesterday
> (libsemanage/semanage - permission check for semanage) and one from Ivan
> yesterday ([SEMANAGE] Further bugfixes).
>
>   
I have more, but I will wait til you merge what you have.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
