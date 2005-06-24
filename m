Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OFdbgA007077
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 11:39:37 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OFdUUD018795
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 15:39:36 GMT
Message-Id: <200506241539.j5OFd8qc016279@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Fri, 24 Jun 2005 11:39:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119558539.16753.74.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Thursday, June 23, 2005 4:29 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> 
> > Why have a file per user?
> 
> I thought that's what you were suggesting - store per user contexts
> in their own file, and then re-generate the end result from that.
> 
> Alternatively it could all be in one big file, but then I
> don't have any information what came from where. Regenerating
> the regexps from the template (1) requires delete
> to have the same information as add, which is otherwise
> not necessary. Currently that consists of the home dirs, but
> in the future it could consist of other stuff too, and
> (2) requires me to match every line in homedirs against
> every template expression, which just seems unnecessary.
> 

What's wrong with:

1) Read file contexts with ROLE, etc. still present.
2) Extract all context lines with ROLE.
3) Write all plain context lines to new file.
4) Iterate through users and append to the new file all of the extracted context
lines with ROLE, etc statements replaced.
5) Replace old file contexts file with new one.

Shouldn't be that expensive and is about as simple as possible.

> > > > Can you give an overview of these patches - what you are trying to
> > > accomplish in
> > > > more detail and the design?
> > >
> > > Well I was trying to accomplish the following:
> > >
> > > - add -R flag to useradd, and have it automatically validate
> > > and add user roles, and generate user contexts (and add user to running
> > > policy)
> > >
> > > - have userdel undo the above
> > >
> > > - have usermod modify user roles in file and policy, and on default
> > > role change, recreate the contexts.
> > >
> >
> > We were planning on deprecating seuser because of general bit rot. It does
> do
> > all of this (through wrappers, etc) so if any of that code is useful feel
> free
> > to grab it (it's GPL).
> 
> Is seuser a library or a command line tool? I want to write a library..
> 
> I'm not sure how much help I need, since I have already made sufficient
> progress on this - I can successfully complete add, and
> then delete and modify shouldn't be all that hard, once
> I decide what to do about finding the user contexts.
> 
> I still need to add more validation, and rollback...
> 

There is a library that is for manipulating the policy to add users. It's all
libapol based, though.

> > > - make policydb an opaque data structure to address the
> > > exposure created above
> > >
> >
> > Great - and then various helper functions can be added incrementally until
> there
> > is a full API.
> 
> Right....however I'm making an incompatible change here.
> policydb_destroy has been changed to free the policy, which
> requires all policydb structures to be created on the heap
> via policydb_create. I have to fix existing users.
> 

You could also provide an alloca interface if there is a compelling reason for
callers to have the db on the stack.

> >
> > Hmm . . . why have the records so directly tied to files? Seems like the API
> > needs to be a little higher level to actually make it work with something
> like
> > an LDAP backend.
> 
> They are not... the record structure itself is located in a separate
> file. The create/destroy/set/get methods are packaged with the record.
> The record thing isn't much more than a wrapper around a struct.
> I don't use internal selinux datums for this, because I want to stay
> close to the format used in the outside world (human readable strings).
> 
> The parse/print methods are packaged separately, because they are
> file dependent. The record_iterate and record_modify_file are obviously
> file dependent. Someone can implement the top level functions
> in a different way with a different backend.
> 
> > Thanks for the overview - it has clarified some things for me. I'm trying to
> get
> > a handle on how we want things to look in the future. One concern is that
> this
> > api uses libsepol - e.g. it makes it clear to the caller that it is
> manipulating
> > a policy file. We have been discussing / imagining an API that will be
> forward
> > portable to the policy server where the act of adding a user might involve
> and
> > IPC call to the server and be significantly more abstract than a policy
> > manipulation.
> 
> Take a look at attached headers, and see if you can make suggestions.
> Yes, I know I should probably prefix those records with something sane,
> but I haven't done that yet.
> 

After some thought - I have an alternative suggestion that I will put in another
email.

Karl

> I'm considering removing the user/type/role/mls fields from
> port and fscon, and making that part of the common context_record.h
> instead.
> 
> > Not certain, therefore, that libsepol is the correct place for the
> > client api (e.g. the one used by useradd). Thoughts?
> 
> It's difficult to me to write forward portable code, when I don't
> know the future :)

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
