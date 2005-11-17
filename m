Message-ID: <437CD141.60905@redhat.com>
Date: Thu, 17 Nov 2005 13:51:45 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Swigify libselinux
References: <437CBA8D.8050103@redhat.com> <437CBE8A.2020900@tresys.com>
In-Reply-To: <437CBE8A.2020900@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> <snip>
>> +
>> +extern int getseuserbyname(const char *linuxuser, char **seuser, 
>> char **level);
>> +
>
> Why not include the header so that API changes get reflected when 
> changes are made?
First it will not build some of the _raw functions, I believe there is a 
problem with the hidden_profile handling.
But I also do not want to support some of the more exotic uses of the 
library.  So I just went in and grabbed the ones
I could see most people using.  Raw functions can be mimiced using some 
of the translation calls.  I could be convinced either
way.  The main goal to start was to get is_selinux_enabled and 
is_selinux_mls_enabled.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
