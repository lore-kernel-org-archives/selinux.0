Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UDgkNs028344
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 09:42:46 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UDapmd000592
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 13:36:51 GMT
Message-ID: <433D4197.3010100@cornell.edu>
Date: Fri, 30 Sep 2005 09:45:59 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: Re: [ 7/9 ] [ SEMANAGE ] Backend separation (Init 3)
References: <433CA7CA.6000207@cornell.edu> <433CAD8A.8040004@cornell.edu>
In-Reply-To: <433CAD8A.8040004@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think this patch is definitely on the right track to separating the 
cached dbase/list from its backend. Also, remember that I initially 
wanted to iterate the flat file per function call. I later decided this 
was a bad idea, after talking to Karl, but pointed out that in some 
cases we don't want to load the whole database in memory, because it 
might be too large.

One such case are rules. In particular, rule tables are compressed 
within the policydb (via pointers to strings that are shared), and you 
can't really implement a list() function based on records and keep that 
compression at the same time - it's an internal policy detail and those 
records are specifically designed _not_ to expose those - each record 
should be standalone from the policy/other records.

In the general case, what we really want is... an iterate() function in 
the backend. This addresses the concern of loading a large database in 
memory by pushing the work to the backend. We still need the iterate() 
function on the list in memory, because that's faster. However, we 
should add the ability to mark a dbase "noncachable", and then look at 
that in dbase_* functions, and if it says noncachable, we should not 
attempt to construct a memory cache of the database, but instead should 
use the backend iterate() function. Of course, if what you're really 
doing is calling the list() function (as opposed to 
query/count/exists/iterate/*),  this won't gain you anything, but 
really, for rules, who wants to look at the entire ruleset of a zillion 
rules? What we probably want is a method to loop over them, and apply 
programmatic changes or analyze them.  I can add noncachable support on 
certain functions one by one - no need to cover all of them now.. no 
need to implement this on the FILE case either, which is what I was 
doing initially...

I think this is one of my planned architecture changes before I try to 
implement operations on a rule record.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
