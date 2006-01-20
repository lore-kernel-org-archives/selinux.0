Message-ID: <43D0D0C0.7030603@cornell.edu>
Date: Fri, 20 Jan 2006 05:00:00 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: LDAP vs Dbase semantics
References: <43CE880B.3020908@cornell.edu>
In-Reply-To: <43CE880B.3020908@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am looking at LDAP, and I don't like it so far...

Apparently it doesn't support transactions, one of the things expected 
and assumed of a semanage dbase backend. According to the OpenLDAP 
roadmap, they will support LDAPv3 extensions, including "LDAP 
transactions" in 2006 Q1. Please correct me if this is wrong, and I've 
missed transactions somewhere...

So.... that creates lots of problems. How do we handle modifications?
We can fetch all the data in a local copy, work on it, then send it back 
(ignoring the fact that the flush() operation might fail in an 
irreversable way). That seems like a bad idea, because it eliminates our 
ability to use the LDAP read optimizations. We're replacing a server 
with some dumb local-store solution, like the linked list thing, which 
is the worst data structure possible.

Alternatively we can store deltas (user requests for change), and then 
on flush() we can try to apply them all. That creates its own set of 
problems, because current semantics are that semanage changes are 
immediately visible in the dbase they're applied to (not so in the case 
of storing deltas, not unless we apply them on every read request). 
Furthermore, this increases the possibility of failure, since the client 
can easily generate an invalid sequence of requests, and none of them 
will get verified until flush(), not even something simple like "does 
the user exist"). I.E. rquests 1-55 passed, 56 failed, because the 
client did something wrong, now we have to _try_ to reverse the other 55 
(if we have enough info to do so).

Hmm....


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
