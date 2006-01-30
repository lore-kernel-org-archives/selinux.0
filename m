Message-ID: <43DE65A9.6000504@redhat.com>
Date: Mon, 30 Jan 2006 14:14:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, Chad Hanson <chanson@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>, dgoeddel@TrustedCS.com
Subject: Re: [SEMANAGE] nodecon
References: <36282A1733C57546BE392885C0618592FD4DE0@chaos.tcs.tcs-sec.com>	 <43DE6298.2040108@cornell.edu> <1138648401.7076.163.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138648401.7076.163.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-01-30 at 14:01 -0500, Ivan Gyurdiev wrote:
>   
>> Chad Hanson wrote:
>>     
>>> Hi,
>>>
>>> Are there any plans for adding nodecon support to libsemanage? We would like
>>> to request this functionality as we use the nodecon rules in our solutions.
>>> We noticed this deficiency in examining our existing toolset and mapping the
>>> functionality to libsemanage. It is crucial to manage the domains/labels of
>>> hosts/networks.
>>>   
>>>       
>> I can work on adding nodecon support to libsepol and libsemanage, if 
>> that's agreed on (Stephen?)
>>     
>
> Yes, I agree that it would be useful.
>
>   
I think it is fine to do this, but I still believe this is more in the 
realm of iptables then really the role of SELinux.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
