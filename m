Message-ID: <43306E1D.2070508@cornell.edu>
Date: Tue, 20 Sep 2005 16:16:29 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, jbrindle@tresys.com
Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
References: <432FBD08.2050903@cornell.edu>	 <1127243186.14569.135.camel@moss-spartans.epoch.ncsc.mil>	 <4330648F.7040609@cornell.edu> <1127246178.14569.143.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127246178.14569.143.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>- keep the shared libsepol, and have applications use its interfaces
>directly.
>
To clarify, are you saying that we should have?

semanage_user_add(semanage_handle_t handle, sepol_user_key_t key, 
sepol_user_t data)
semanage_user_del(semanage_handle_t handle, sepol_user_key_t key)
semanage_user_modify(semanage_handle_t handle, sepol_user_t key, 
sepol_user_t data)

The sepol and semanage functionality is different - it's just the data 
structure that's shared.

>That's what makes it seem so pointless.  If the wrap functions weren't
>inlined and actually added some semantics around the libsepol
>implementation, then they might make sense
>  
>
I don't know - it's just a design thing to allow future change - Joshua?
I'm not sure if the wrap functions add value, but at least they don't 
cause any harm.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
