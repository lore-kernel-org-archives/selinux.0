Message-ID: <437A0FEE.5030105@cornell.edu>
Date: Tue, 15 Nov 2005 11:42:22 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Stub pserver backend
References: <437907D7.8090002@cornell.edu> <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil> <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil> <4379E4D1.2010900@redhat.com> <437A0749.5060407@cornell.edu> <437A05C5.4080505@tresys.com> <437A0BED.1060102@cornell.edu> <437A09A4.4060103@tresys.com>
In-Reply-To: <437A09A4.4060103@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

J
> There is no race condition on reads. Every query returns the 
> transaction number and the client should check the transaction numbers 
> for consistency.
Ah... so that's what commit_num is for...

Well, I haven't been using that in the other interfaces, so unless 
you've added it with the swig patch, there are no transaction numbers 
for objects other than modules - those functions all return STATUS_ERR 
or STATUS_SUCCESS.

Relying on transaction numbers seems uglier than using a transaction - 
do you want the client to keep re-running the queries until they match?
> The policy rebuild is an implementation issue, as little or as much of 
> the cache can be filled at any time, and the transaction number can 
> always be polled to ensure its up to date.
That's a good point - I didn't realize there was a transaction number, 
so taking that into account should allow more optimizations.

> That said, genhomedircon may be placed inside the transaction at some 
> point in the future when the whole policy directory is inside the 
> sandbox, but until then there is no need for this, and it causes tons 
> of extra copying of files, filling of unused databases, parsing of 
> policydb and a possible policy rebuild/reload.
Yes, commit() needs more optimizations - the whole rebuild sequence 
should be skipped if there were no changes..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
