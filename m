Message-ID: <43D903B0.6000909@redhat.com>
Date: Thu, 26 Jan 2006 12:15:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils 1.29.10
References: <1138044857.20815.142.camel@moss-spartans.epoch.ncsc.mil>	 <1138193526.20815.309.camel@moss-spartans.epoch.ncsc.mil>	 <43D7A46C.7020605@redhat.com> <1138206577.13075.11.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138206577.13075.11.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-01-25 at 11:16 -0500, Daniel J Walsh wrote:
>   
>> I just built 1.29.11.  I was waiting for some mods to libsemanage to 
>> handle semanage_user_set_roles
>>
>> but I build it anyways.  Modify of users does not work, until this 
>> swigify is fixed.
>>     
>
> Sorry, can you clarify what the issue is there?
>
>   
Currently the semanageswig.i file is broken

semanage_user_set_roles Returns an error.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
