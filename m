Message-ID: <434BD2CB.8050007@cornell.edu>
Date: Tue, 11 Oct 2005 10:57:15 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: [ SEMANAGE ] Replace semanage debugging system
References: <434B62B8.4080309@cornell.edu>	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>	 <1129039592.3308.110.camel@moss-spartans.epoch.ncsc.mil>	 <434BCC58.7030509@cornell.edu> <1129041009.3308.125.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129041009.3308.125.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> The auxiliary data could be directly embedded in the handle, avoiding
> any need to introduce a new structure (or allocation), with the get
> methods operating directly on the handle much like the old strerror
> interface.  I don't think you want msg_write needing to allocate any
> memory or performing any formatting string writing, as that should all
> be done in the callback if desired.
>   

Okay, so it sounds like the optimal setup is:
- pass variadic list to callback
- remove msg field from message structure (rename?)
- embed message structure into handle to avoid allocation

Then handler takes four arguments instead of the current two:

- void* arg
- message structure (rename?)
- fmt
- variadic list






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
