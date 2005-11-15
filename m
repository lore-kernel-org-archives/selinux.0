Message-ID: <437A05C5.4080505@tresys.com>
Date: Tue, 15 Nov 2005 10:59:01 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Stub pserver backend
References: <437907D7.8090002@cornell.edu> <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil> <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil> <4379E4D1.2010900@redhat.com> <437A0749.5060407@cornell.edu>
In-Reply-To: <437A0749.5060407@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>> Giving me the tools in libsemanage to build the manipulation of ports, 
> 
> Okay, will work on that..
> 
>> seusers 
> 
> The seuser APIs are already available, and should work in libsemanage.
> Although MLS validation is not happening, the modification should work, 
> and should verify that the SElinux user exists.
> Not sure if python bindings are currently available.

the swig wrappers don't currently have any write (transaction) 
functionality, nor are the seuser keys and create functions wrapped, 
these will need to be done.
> 
>> and potentially
>> user modules (local.pp) from python.
> 
> Same for user APIs. Those things do not go into modules currently - 
> they're written back out into flat files. Why do we want those into a 
> module? I think Stephen also mentioned a while ago that modules cannot 
> yet support all of the objects that we are managing. Is this still the 
> case?
> 

We don't want users in modules, it isn't even supported with MLS. The 
flat file implementations are already working, we just need to wrap the 
interfaces to write the python utilities.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
