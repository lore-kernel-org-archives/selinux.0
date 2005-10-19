Message-ID: <43569109.9010301@cornell.edu>
Date: Wed, 19 Oct 2005 14:31:37 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ron Kuris <rk@unify.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Loading things into policy
References: <43559474.1080905@cornell.edu> <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil> <43568C6E.5040106@cornell.edu> <43568CE4.4030901@unify.com>
In-Reply-To: <43568CE4.4030901@unify.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Another interesting point is that your pseudo-code suffers from a race
> condition: what if two processes try to add() at the same time?
>   
That's actually not a problem, because you'd be in a transaction when 
you executed this code. If I was implementing modify internally to be 
based on add and set, I'd just need to do a transaction check around 
that code.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
