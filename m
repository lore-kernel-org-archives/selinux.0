Message-ID: <42681E02.9020205@hp.com>
Date: Thu, 21 Apr 2005 17:41:22 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: selinux-policy-mls is now available for your testing pleasure.
References: <42602C45.3030706@redhat.com> <42680E33.8080607@hp.com>
In-Reply-To: <42680E33.8080607@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> Daniel J Walsh wrote:
> 
>> Based off STRICT policy.
>>
>> ftp://people.redhat.com/dwalsh/SELinux/Fedora/selinux-policy-mls-*
>>
>> It is not in Rawhide, yet but I will provide it via my people page.
>>
>> This has not been tested.
>> I have not got an MLS machine up and running yet.
>>
> 
> In version 1.23.12-1 of MLS policy RPM there is a problem with the file 
> contexts for '/sbin/arping' - there are entries for both 
> 'system_u:object_r:traceroute_exec_t:s0' and 
> 'system_u:object_r:netutils_exec_t:s0'.  I assume it should be the 
> latter of the two?
> 

I'm sorry, disregard that - I didn't see the updated RPM with this 
problem fixed.

-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
