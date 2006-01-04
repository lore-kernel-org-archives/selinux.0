Message-ID: <43BC2C0F.6050208@tresys.com>
Date: Wed, 04 Jan 2006 15:11:59 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com> <43BAB2D6.4030103@cornell.edu> <43BBF8C6.1070109@cornell.edu> <43BBFA8A.2040601@cornell.edu> <43BC1ECA.1070806@redhat.com> <43BC0681.2090403@cornell.edu> <43BC248C.7050102@redhat.com> <43BC24D3.7060504@tresys.com> <43BC0D99.10200@cornell.edu>
In-Reply-To: <43BC0D99.10200@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>>> But I thought we were only going to allow modifying of local stuff.  
>>> Do we want a user to be able to modify the SELinux USER Root or 
>>> user_u?  I don't think so.
>>>
>> why not? that is a fairly arbitrary decision, maybe we shouldn't allow 
>> them to modify the ssh port either?
> 
> Speaking of overriding things, is it currently possible to override the 
> entire ethereal security module, for example?
> Is there a modules.local? It's always been my opinion that modules 
> should be just another record type, and the fs directory should be just 
> another backend to the database...
> 
> 
I really don't want to get into this again. Generalizing module store 
for the sake of doing so would be a tremendous waste of time. The policy 
server will allow transfering of the binary modules to machines over the 
network (with access control) so why would they ever need to be stored 
in some other medium.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
