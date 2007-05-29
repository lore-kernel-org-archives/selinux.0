Message-ID: <465C7C4D.3030805@tycho.nsa.gov>
Date: Tue, 29 May 2007 15:17:33 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: object class discovery userland
References: <1177077717.15762.32.camel@sgc> <4628F05B.7040309@tycho.nsa.gov>	 <4628F20E.2000208@tycho.nsa.gov>  <1177089541.24870.17.camel@sgc>	 <1177338792.24282.16.camel@moss-spartans.epoch.ncsc.mil>	 <6FE441CD9F0C0C479F2D88F959B01588A71927@exchange.columbia.tresys.com>	 <1177340283.24282.24.camel@moss-spartans.epoch.ncsc.mil>	 <1179929852.10995.51.camel@sgc.columbia.tresys.com>	 <46548D4E.50000@tycho.nsa.gov> <465623DD.6090304@tycho.nsa.gov>	 <6FE441CD9F0C0C479F2D88F959B01588BEFF31@exchange.columbia.tresys.com>	 <465750DF.1050509@tycho.nsa.gov> <1180463067.3340.120.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1180463067.3340.120.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-05-25 at 17:10 -0400, Eamon Walsh wrote:
>> Here's a first go at an interface.  It's an init function that is a
>> replacement for avc_init().  It takes flags, the class/permission
>> mapping to use, and callback functions.
>>
>> This is trying to solve a few other problems at the same time, namely:
>>
>> - selinux prefix on the function name
>> - drops support for memory, threading, and locking callbacks (would just
>> always use malloc and pthread)
>> - adds type code to logging callback
> 
> As you seem to be making this a generic init function, shouldn't it also
> handle the matchpathcon flags and init support as well?  
> 

I have taken this into account wrt the labeling interface that I have 
been working on that would replace matchpathcon and friends.

Specifically, the patchset would add label flags ("SELINUX_LABEL", 
"SELINUX_VALIDATE", etc.) and a validation/canonicalization callback to 
the arguments to selinux_init(); the labeling interface is handle-based 
so there would be a separate create() function that would take the 
backend to open.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
