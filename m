Message-ID: <436F811C.1010306@tresys.com>
Date: Mon, 07 Nov 2005 11:30:20 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Cleanup : move some things around
References: <436DDB51.2080903@cornell.edu>	<1131377599.20591.32.camel@moss-spartans.epoch.ncsc.mil>	<436F7F36.5080308@cornell.edu> <1131379914.20591.70.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131379914.20591.70.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2005-11-07 at 11:22 -0500, Ivan Gyurdiev wrote:
> 
>>>I'd prefer to hold cleanups until we have stabilized the functionality
>>>and interfaces as desired for test1.  I'm also not clear on why we want
>>>a sepol handle in the ps case.  
>>>  
>>
>>.. because we'll be using the sepol records either way, so we need the 
>>sepol handle..
>>Not using the sepol records requires copying them over into libsemanage.
> 
> 
> Hmmm..well, let's take that up again later.  Right now we need to deal
> with finalizing the boolean support (e.g. having libsemanage use
> security_set_boolean_list with permanent=0 to set the runtime boolean
> values upon commit rather than loading the generated binary policy
> file), and getting the migration steps in place for test1.
> 
> I committed your semanage_set_reload_bools() patch and my
> semanage_is_managed() patch to sourceforge cvs, but not the cleanup
> patch.
> 

Please see my other email about the semanage_set_reload_bools() patch, I 
  believe it is flawed in a couple ways and should be reverted.

Joshua



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
