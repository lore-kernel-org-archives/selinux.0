Message-ID: <46C3621F.2060005@manicmethod.com>
Date: Wed, 15 Aug 2007 16:29:19 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Mark Goldman <mgoldman@tresys.com>, selinux@tycho.nsa.gov,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [POLICYREP] [Patch 0/3] remove modular policy support for	policy
 rep branch
References: <20070815194633.208081111@tresys.com>> <1187208870.20485.123.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1187208870.20485.123.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-08-15 at 15:46 -0400, Mark Goldman wrote:
>   
>> This patchset removes module support from libsepol.  This
>> patchset is in support of the policyrep work.
>>
>> Patch one removes the files that are solely for supporting modular
>> policies. 
>>
>> Patch two eliminates the various structures that supported modular
>> policies. All functional changes occur in this patch.
>>
>> Patch three puts dispol in libsepol's utils directory.
>> Dispol was not modified in this move.
>>     
>
> So then how will you add back read-side support for providing
> compatibility with older module/package files?
>   
Policyrep will have compatibility code that reads the old module format 
into the new representation. Hopefully this will allow one to combine 
'old' style modules and new modules during the transition phase.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
