Message-ID: <436091B9.7010604@cornell.edu>
Date: Thu, 27 Oct 2005 04:37:13 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [ SEMANAGE ] Implement dbase_file_set, fix memleak
References: <43601468.60508@cornell.edu>
In-Reply-To: <43601468.60508@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> A short TODO:
> - interface: pass handle into sepol records, or implement status codes
> - stub: implement interface parse/print
> - stub: implement dbase_policydb_list
> - fix: fix port key handling of modify() [ do not replace an entire 
> range on weak match (not exact) ]
> - improvement: track when the policy is modified, and do not rebuild 
> on commit if it wasn't modified
> - add error messages everywhere (and further propagate handle), and 
> make sure they're user-friendly
> - uncomment if0-ed code, add new semanage interfaces to semanage.h, 
> and the map file

Another TODO:
============
- investigate whether database functions should be made reentrant, 
exactly what kind of code can and cannot be executed in the iterate() 
handler, and document that  - things like: are modify() functions 
allowed on the same database in iterate()? Other databases? queries()? 
Out-of-transaction vs in-transaction behavior?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
