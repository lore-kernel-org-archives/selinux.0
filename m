Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NJnfgA000527
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 15:49:41 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NJdERO013654
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 19:39:18 GMT
Message-Id: <200506231939.j5NJdXqc031369@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Thu, 23 Jun 2005 15:39:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1119553208.16753.33.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Thursday, June 23, 2005 3:00 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> 
> > Are you intending to do away with genhomedircon so that everything will be
> in
> > libselinux?
> 
> libsepol...
> 
> The problem is that genhomedircon is in python, and useradd is in C.

Not objecting - just checking.

> Furthermore genhomedircon doesn't do what I want.
> 
> >  Why are you going to have to run around the file system? Isn't this
> > a matter for taking the file contexts file that still has ROLE and HOMEDIR
> > statements and processing that?
> 
> If I have a separate file for each user, I have to concat them together
> for matchpathcon, is that not the case? I guess I can do that, but I'd
> rather not..
> 

Why have a file per user?

> If you take the more general case of removing an application - imagine
> you want to remove mozilla, and have its contexts gone - you have
> to reconstruct the entire file_contexts file from all the .fc files.
> 

The module infrastructure already handles this - it produces a flat
file_contexts file. Seems like this could be run through what is essentially
genhomedircon to produce another flat text file for matchpathcon. This would
obviously be backward compatible with the current source policies.

> > Can you give an overview of these patches - what you are trying to
> accomplish in
> > more detail and the design?
> 
> Well I was trying to accomplish the following:
> 
> - add -R flag to useradd, and have it automatically validate
> and add user roles, and generate user contexts (and add user to running
> policy)
> 
> - have userdel undo the above
> 
> - have usermod modify user roles in file and policy, and on default
> role change, recreate the contexts.
> 

We were planning on deprecating seuser because of general bit rot. It does do
all of this (through wrappers, etc) so if any of that code is useful feel free
to grab it (it's GPL).

> - expose the net_contexts file through the libsepol library
> 

Changes or just query?

> In addition I am doing the following changes, which affect you:
> 
> - modify all libsepol functions to work via policydb and
> not (data,len) image (because there's no reason to policydb_read
> on each function call...)
> 

Definitely a good idea.

> - make policydb an opaque data structure to address the
> exposure created above
> 

Great - and then various helper functions can be added incrementally until there
is a full API.

> - separate genusers policy and parsing, to allow for alternative
> data source in the future for the user information than the flat file.
> 
> 
> This is accomplished by defining a "record" structure for
> each configuration group (for example, the user record contains
> the user's name, roles, default role, and mls info (and I've
> bundled home dir for other purposes)). The fscon record
> contains a regexp, a class (-b, -p), and a context. I'm
> currently trying to break out the context as its own record,
> since that makes sense to me.
> 
> Each record has a bunch of _file methods that define how
> it can be parsed from a file, and written to a file.
> 
> Then I have a central routine called record_iterate,
> and another one called record_modify_file that loop
> over a file, and parse records (based on a table
> of functions that explains how to do that),
> and execute arbitrary handlers. Modify_file
> is pretty similar to iterate, except it
> copies records to a second stream while
> it's iterating, and then overwrites
> the original at the end. Those functions
> support events like delete, and match
> that can be signaled by the handler, and support
> configuring whether certain errors are fatal..
> 

Hmm . . . why have the records so directly tied to files? Seems like the API
needs to be a little higher level to actually make it work with something like
an LDAP backend.

Thanks for the overview - it has clarified some things for me. I'm trying to get
a handle on how we want things to look in the future. One concern is that this
api uses libsepol - e.g. it makes it clear to the caller that it is manipulating
a policy file. We have been discussing / imagining an API that will be forward
portable to the policy server where the act of adding a user might involve and
IPC call to the server and be significantly more abstract than a policy
manipulation. Not certain, therefore, that libsepol is the correct place for the
client api (e.g. the one used by useradd). Thoughts?

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
