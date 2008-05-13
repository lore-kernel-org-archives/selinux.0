Message-ID: <482A0789.5060504@manicmethod.com>
Date: Tue, 13 May 2008 17:26:33 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, dwalsh@redhat.com
Subject: Re: [PATCH-v3] libsepol: allow genfscon statements in modules
References: <1210173297.3084.13.camel@localhost.localdomain>	 <4829F4C4.4020306@manicmethod.com> <1210710370.3118.15.camel@localhost.localdomain>
In-Reply-To: <1210710370.3118.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Tue, 2008-05-13 at 16:06 -0400, Joshua Brindle wrote:
>   
>>> +static void free_genfs(genfs_t *genfs)
>>>   
>>>       
>> I don't think this should go in link.c
>>     
>
> meaning what?  you want me to static inline it from a header file?
> Doesn't matter to me...
>   

IMO put it in policydb.c and change policydb_destroy to use it as well.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
