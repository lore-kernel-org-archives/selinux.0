Message-ID: <434BE9C4.3030604@cornell.edu>
Date: Tue, 11 Oct 2005 12:35:16 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: [ SEMANAGE ] Replace semanage debugging system
References: <434B62B8.4080309@cornell.edu>	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>	 <1129039592.3308.110.camel@moss-spartans.epoch.ncsc.mil>	 <434BCC58.7030509@cornell.edu>	 <1129041009.3308.125.camel@moss-spartans.epoch.ncsc.mil>	 <434BD2CB.8050007@cornell.edu>	 <1129042012.3308.139.camel@moss-spartans.epoch.ncsc.mil>	 <434BD7DE.3080206@cornell.edu> <1129043943.3308.162.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129043943.3308.162.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>> Why not just use the handle directly, and drop the separate message
>>> structure entirely?
>>>   
>>>       
>> It's disorganized... the handle contains all kinds of things - I don't 
>> like adding random fields to it. It'd be more orderly to add a 
>> structure, and functions to work with it, in a separate file. I would 
>> think that nested structs have no runtime overhead...
>>     
>
> Hmmm...well, I thought that one of the purposes of the handle was for
> error handling, and you are adding the callback and callback arg there
> in place of the old error buffer. 
The handle's kind of used for everything right now.... It's a central 
merge point for anything that might need (or benefit from)
preserved state over multiple function calls. I don't feel very strongly 
about this -  I can pass back the handle if you prefer that - it's just 
an organizational preference (I might change my mind tomorrow when I see 
how it looks :)
>  More generally, I was wondering if
> the callback might want the handle without needing to explicitly specify
> it as part of the callback arg.
>   
The callback's job should be to print out the error. If it wants the 
handle, it's certainly free to pass it as part of the argument, but I'm 
not sure what it would be doing with it. I imagine the callback doing 
error _reporting_, while the normal function stack handles error _response_.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
