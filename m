Message-ID: <437A09A4.4060103@tresys.com>
Date: Tue, 15 Nov 2005 11:15:32 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Stub pserver backend
References: <437907D7.8090002@cornell.edu> <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil> <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil> <4379E4D1.2010900@redhat.com> <437A0749.5060407@cornell.edu> <437A05C5.4080505@tresys.com> <437A0BED.1060102@cornell.edu>
In-Reply-To: <437A0BED.1060102@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>>
>> the swig wrappers don't currently have any write (transaction) 
>> functionality, nor are the seuser keys and create functions wrapped, 
>> these will need to be done.
> 
> Speaking of transactions, I see the "moving genhomedircon patch outside 
> the active-lock section" patch has been merged. That's fine, but I also 
> pointed out why genhomedircon should be using transactions in read-only 
> mode as well - please see the relevant thread. Using transactions there 
> eliminates an unnecessary policy rebuild, and a race condition (but on 
> the other hand then you have another deadlock to deal with, because 
> you're calling it with the transaction lock held).
> 
> 
There is no race condition on reads. Every query returns the transaction 
number and the client should check the transaction numbers for consistency.

The policy rebuild is an implementation issue, as little or as much of 
the cache can be filled at any time, and the transaction number can 
always be polled to ensure its up to date.

That said, genhomedircon may be placed inside the transaction at some 
point in the future when the whole policy directory is inside the 
sandbox, but until then there is no need for this, and it causes tons of 
extra copying of files, filling of unused databases, parsing of policydb 
and a possible policy rebuild/reload.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
