Message-ID: <48BE2723.4030002@redhat.com>
Date: Wed, 03 Sep 2008 15:56:51 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "SELinux Contexts and Attributes" review
References: <48B4FA3E.3000602@redhat.com>	 <1219844836.5708.92.camel@moss-spartans.epoch.ncsc.mil>	 <48BB93D2.8090909@redhat.com> <1220360324.26711.33.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1220360324.26711.33.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2008-09-01 at 17:03 +1000, Murray McAllister wrote:
>>> A process in one domain transitions to another domain by executing a new
>>> program with the entrypoint type for the new domain.
>> How about:
>>
>> A subject in one domain transitions to another domain by executing an 
>> object that is labeled with a file type that has entrypoint permission 
>> for the new domain. The entrypoint permission is used in SELinux policy, 
>> and controls which domains an object can enter. The following example...
> 
> Not exactly:
> 1) A new domain has entrypoint permission to the file type, not the
> other way around.
> 2) The entrypoint permission controls which programs can be used to
> enter a domain, not the other way around.

How about (from your original suggestion):

A subject in one domain transitions to another domain by executing an 
object that has the entrypoint file type for the new domain. The 
entrypoint permission is used in SELinux policy, and controls which 
objects can be used to enter a domain.

I added the following to the list of steps:

An SELinux policy rule states that the passwd_t domain type has 
entrypoint permission to the passwd_exec_t file type.

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
