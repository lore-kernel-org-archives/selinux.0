Message-ID: <43D0D3FA.6090606@cornell.edu>
Date: Fri, 20 Jan 2006 05:13:46 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: LDAP vs Dbase semantics
References: <43CE880B.3020908@cornell.edu> <43D0D0C0.7030603@cornell.edu>
In-Reply-To: <43D0D0C0.7030603@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> So.... that creates lots of problems. How do we handle modifications?
> We can fetch all the data in a local copy, work on it, then send it 
> back (ignoring the fact that the flush() operation might fail in an 
> irreversable way). That seems like a bad idea, because it eliminates 
> our ability to use the LDAP read optimizations. We're replacing a 
> server with some dumb local-store solution, like the linked list 
> thing, which is the worst data structure possible.
...but then again, do we care? This is a management library, not to be 
queried 100 times a second.
Maybe I should just put all the users in a linked list and be done with 
it...

Still doesn't solve the problem of what to do when flush() fails...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
