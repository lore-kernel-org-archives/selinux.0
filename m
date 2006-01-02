Message-ID: <43B96A92.8040907@cornell.edu>
Date: Mon, 02 Jan 2006 13:01:54 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] File Contexts APIs (part 1)
References: <43B086A1.2030007@cornell.edu> <43B97E72.3070306@tresys.com>
In-Reply-To: <43B97E72.3070306@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>  Just out of curiosity, why not prepend entries to the linked list so 
> that they are always in the order of the file (likewise for every 
> other record type). It seems strange that the list could potentially 
> get reversed on every write (reads in reverse and writes in order?)
There's two kinds of reads going on here - there's read-from-file to 
populate the dbase, and iterate/list type of read. Read-from-file 
prepends at the beginning of the list like you say. Write-to-file to 
flush the data is back-to-front. Together those two things should 
guarantee stability of the file ordering.

That's completely independent from ordering of the iterate/list 
operation. That used to be front-to-back, and one of the 21 patches I 
sent flips it to back-to-front. That agrees with the in-file order, but 
that's not important. The important thing is that things are iterated in 
the order in which they are added (add also prepends), which would be 
expected behavior. Since ports are merged into policy in the iterate() 
order, this also guarantees that the port specs added later take 
precedence (because they're appended at the front in libsepol as well). 
So I think it should work. I might have to take another look though, 
because Dan is having some problems with it - not sure if he applied the 
reversal patch.

Another note - the ordering in the semanage sandbox files is an 
implementation detail, and does not have to be the same as it used to be 
in policy. For file_contexts it has to be the same (and it is) if we 
want to just install the contexts file as is. For ports, it's actually 
exactly backwards to net_contexts, but that doesn't matter, because the 
ports file is just used for internal storage within the library, it's 
flipped when it goes into policy.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
