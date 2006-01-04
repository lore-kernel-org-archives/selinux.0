Message-ID: <43BC07EA.9000309@cornell.edu>
Date: Wed, 04 Jan 2006 12:37:46 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com> <43BAB2D6.4030103@cornell.edu> <43BBF8C6.1070109@cornell.edu> <43BBFA8A.2040601@cornell.edu> <43BC1ECA.1070806@redhat.com> <43BC0681.2090403@cornell.edu>
In-Reply-To: <43BC0681.2090403@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> That's tricky. That depends on what you want modify to do.
> The libsemanage modify_local function is with respect to the local 
> store, but
> anything you write in the store at all will modify policy, so you can 
> go either way
> with your higher level modify. The question is what you're modifying, 
> and does
> the user understand that.
In case I wasn't clear here, overrides are allowed for all object types, 
which means you can modify things that are built into policy.

That's regardless of which function you use to add things to store - add 
vs set vs modify. In fact, all three functions do pretty much the same 
thing, and I've been meaning to get rid of some of them, but now that we 
must preserve a stable API that might be a problem - modify can be used 
to implement all the others. The other two are only useful if you want 
the library to do an exists check for you (which you shouldn't do), or 
for performance reasons, but I'm thinking that set is algorithmically 
guaranteed to take the same time as modify.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
