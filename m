Message-ID: <457060BB.5090305@mentalrootkit.com>
Date: Fri, 01 Dec 2006 12:04:59 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: ewalsh@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/5] libselinux: labeling API for userspace object managers
 (try 2)
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil> <456F976D.9020905@tresys.com>
In-Reply-To: <456F976D.9020905@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Eamon Walsh wrote:
>> This is a companion interface to the userspace AVC, for use by userspace
>> object managers to look up contexts for use in labeling their objects.
>> It also provides an alternate interface to the file contexts
>> configuration.
>>
>>   
> If we go forward with this do we really expect every object manager that 
> has context matching more complicated than exact matches to upstream 
> changes to libselinux? This doesn't seem to scale well.. Policy server 
> would need a backend, do you know if dbus and X would need new backends? 
> I still don't think this is the right approach, LDAP and rdbms's, for 
> example, would likely have their initial contexts in the schema.
> 

I agree that this would be problematic - very specific libselinux 
dependencies are going to be a nightmare for distributions. Seems like 
it should be possible to have a callback style api that would allow 
sufficient customization for almost all object managers.

> I can think of few object managers that this scheme works with. Things 
> like groupware apps, chat servers, mail servers, etc are going to have 
> labeling done at runtime (based on who creates an object or where it 
> comes from), databases will certainly store contexts in their schema, 
> etc. This is a pretty large change to make the file context interface a 
> little prettier..
> 

It this only works for file contexts then it doesn't seem worth doing, 
but I think that there is hope that it can be made to work more generally.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
