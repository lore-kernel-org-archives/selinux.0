Message-ID: <4186D416.8010903@tresys.com>
Date: Mon, 01 Nov 2004 19:25:58 -0500
From: Karl MacMillan <kmacmillan@tresys.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SELinux List <SELinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>
Subject: Re: dynamic context transitions
References: <4182959B.4080503@trustedcs.com> <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net> <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil> <20041101141025.GZ8897@lkcl.net> <418662EE.5090001@trustedcs.com> <1099344460.23756.49.camel@pham.columbia.tresys.com> <20041101223306.GO9643@lkcl.net>
In-Reply-To: <20041101223306.GO9643@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>On Mon, Nov 01, 2004 at 04:27:40PM -0500, Karl MacMillan wrote:
>  
>
>>Dropping privileges after startup can already be accomplished with
>>conditional policies, though it requires that only one process be
>>running in a given domain.
>>    
>>
> 
> sorry to be a pain but i feel a need to clarify: is that most
> definitely the case?
>  
>

Yes. There is no "drop priveleges" functions - instead a boolean can be 
defined that covers a section of policy that allows a daemon the access 
necessary for startup. After startup, that policy can be disabled via 
the boolean. Because this access is defined for the entire domain 
(type), then a change in policy effects all processes running in that 
domain. That means that :

> to illustrate, which of these is true:
>
> - if i have two processes in a given domain, and one process
>   runs the "drop privileges" selinux function, the process calling
>   the function has its privileges "dropped" but the other process
>   retains the _original_ privileges.
>
>  
>
This is not the case.

> - if i have two or more processes in a given domain, and one process
>   runs the "drop privileges" selinux function, _all_ processes in that
>   domain have their its privileges "dropped".
>
>  
>

This is the case.

> - something indeterminate happens and it all goes pear-shaped.
>
>  
>

It is definitely deterministic. A final note, there are certain types of 
access that cannot be revoked by a change in policy, most notably access 
to mmapped files. In generaly, this is probably not a problem, but it 
should be kept in mind.

Karl

> l.
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
