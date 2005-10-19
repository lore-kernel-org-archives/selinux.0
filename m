Message-ID: <4356905A.7010703@cornell.edu>
Date: Wed, 19 Oct 2005 14:28:42 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Loading things into policy
References: <43559474.1080905@cornell.edu> <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil> <43568C6E.5040106@cornell.edu>
In-Reply-To: <43568C6E.5040106@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Now, you could say you want add(), modify(), and set() to work as I've 
> described above with respect to policy, and not the local file... but 
> that's not the way I've been thinking about it so far. That's a 
> different kind of design - it would need to do an exists() test in 
> both local files, and policy, before it took any action.
Actually that's fairly easy to implement, and I'd do it without caring 
what the backend is for various things (I can do this, because of the 
abstractions, which everyone dislikes so much).

Currently I am planning two separate interfaces - one for local objects, 
and one for in-policy objects. To implement an interface that integrates 
those two, I would:
1) suffix the local objects functions with local (which is probably a 
good idea anyway, since their names are a bit misleading).
2) write new functions that are written on top of the local/in-policy 
interfaces (not implementations).
They'd do a query in both databases for queries. For modifications, 
they'd do exist() test in both databases, and add stuff only in the 
local files database.

...at this point Joshua's argument about why adding ports based on 
existence of other ports in global policy is bad...starts to make some 
sense to me. I did not understand his argument before, because it didn't 
make sense when you were checking existence in the local database only, 
and had a default handler to use on commit() for the in-policy objects.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
