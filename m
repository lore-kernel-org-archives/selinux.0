Message-ID: <433DA664.6040600@cornell.edu>
Date: Fri, 30 Sep 2005 16:56:04 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: [10 / 9] [ SEMANAGE ] FIx placement of function table
References: <433DA069.3090208@cornell.edu> <1128112109.12459.216.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128112109.12459.216.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Hmmm...I just got done merging the others (available in the sourceforge
>CVS), although naturally all of this is still open to debate and can be
>reverted at any time.
>
>I think at this point I'll wait for clarification from Karl et al on
>whether this patch (and the prior ones as well) are consistent with
>their plans for libsemanage.
>  
>
Okay...

It's just a question of where things are supposed to be placed. I think 
Karl agreed earlier that headers should follow the code, and that's what 
I was thinking about, but my first patch moved things to the wrong places.

----
The policy function table being discussed is an interface (to be used 
for the purposes of polymorphism). Because this is an interface, there 
is no associated code - implementations use the specific type, and 
include a header to fill the table . At the same time, 
semanage_private.h was containing random things, so this is probably 
better off on its own, which this patch sets up (or bundled with the 
rest of interfaces.h, but handle.h is probably the wrong place for it).

The other thing I moved was handle code (that's fine IMHO), debug code 
(fine), and a conn object. I can't figure out exactly what the conn 
object is planned for, so that's why I asked... I suspect it's the 
connection state object for direct API (so it goes in direct_api.h)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
