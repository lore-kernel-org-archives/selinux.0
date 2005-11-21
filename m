Message-ID: <4381BF81.4090906@cornell.edu>
Date: Mon, 21 Nov 2005 07:37:21 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEPOL] Remove defrole from sepol
References: <437EBD3A.7090606@cornell.edu>
In-Reply-To: <437EBD3A.7090606@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Now we need to add the labeling prefix back into semanage somehow.
What APIs are needed here?

I have a patch that adds another record called semanage_user_aux_t (User 
Auxiliary Data), defined as data keyed on the user that stays out of 
sepol. It currently provides a method to get the defrole. It's backed by 
a flat file formatted: (name:defrole name:defrole ...)

If we have user_aux.local, and user_aux.system, how does the policy rpm 
install the system users - does it need modification APIs for that? Is 
there a third file that combines the local and system one 
(rebuild-from-scratch equivalent for flat files), or do I need to 
implement combined query/exists/iterate/..* operations (with list() and 
iterate() checking for duplicates, and giving preference to a local entry).

=========

P.S. I am suspicious that too many record/dbase functions are currently 
exposed in sepol or semanage - will have to take a look again to make 
sure they're all needed (and none are missing... because I see some that 
aren't there, like the clone function (which likely should likely stay 
hidden)).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
