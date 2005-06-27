Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5RF8hgA024653
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 11:08:43 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5RF7aMC010664
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 15:07:36 GMT
Message-Id: <200506271508.j5RF7tqc018129@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Mon, 27 Jun 2005 11:07:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119635788.31852.25.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Friday, June 24, 2005 1:56 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> 
> > > Also, there's no reason why delete should have to gather data like
> > > add for expansions - I don't want to require the same interface
> > > for delete as for add... you're saying I should require information on
> > > all home directories (and/or any future expansion that we may
> > > decide to add) just to delete some user...
> > >
> >
> > Yep.
> 
> ...why? this seems like a bad idea...
> gathering this information may or may not be trivial/cheap
> in the future... what if you have 100000 users, and their
> /etc/passwd data is kept in LDAP.
> 

You only have to do this for the users that are on a given system I guess.

> Delete should not require info that does not pertain to
> its designated operation (removing contexts for a single user,
> not adding contexts for *all* users in the process)
> 

That's true - this is what lead you down the path of separate files per user,
which I didn't understand until now.

> >  Also, to bring this in line with my other suggestion about how to handle
> > users in general, it seems like the way to go is to have a chunk of file
> > contexts for each SELinux user (what I am calling user roles) that is
> generated
> > at policy development time.
> 
> You can't generate per user contexts at policy development time - the
> users can and will change after that time.
> 
> > This can be applied to each home directory at user
> > add/change time.
> >
> That sounds like the template system that we have currently - how
> is this proposal different?
> 
> > That means that genhomedircon can basically stick around - it
> > is only a build requirement. This just means we have to have a special
> setfiles
> > mode for home directory labeling that uses the correct home directory file
> > contexts.
> 
> So you're saying that the per user contexts shouldn't even be
> *generated* - you should interpret the expansions in matchpathcon?
> 
> This is making matchpathcon too smart...but I haven't looked
> at that code, so I don't know if that's a good idea.
> 
> Please don't assume path expansions have anything to do with the home
> dir. I've already added one that expands to the user name, and may
> add others in the future.

How can the path expansions not include home dir? Otherwise, how do you resolve
conflicts between multiple users? I can't see how it is possible to do ROLE (or
USER or LINUX_USER) expansion for any path that is not in a home directory.

I think that we are hitting many of the same problems that existed with your
home directory labeling scripts. I don't have any good solutions, but let me try
to characterize the problem.

The current file_contexts contains labeling information for both application
policies and _every_ user's home directory that is authorized to log into the
system. There are many limitations:

1) We don't support non-local users - genhomedircon reads /etc/passwd.
2) Large numbers of users will make file_contexts very large with mostly
redundant data.

The current suggestion is two-fold:

1) Add APIs to libsepol to allow convenient addition of file_context information
for each user.
2) Modify applications (adduser) to use this API.

This retains the basic assumption that all user home directory labeling
information will be in the file_contexts. It has some drawbacks:

- A user must be added on that machine to have the labeling information present
(a problem for network mounted home dirs).
- Individual user information (which is now decoupled from the policy via the
suggested user management approach) still is present in file_contexts.
- It is not clear what would happen when a loadable policy module is added that
has home directory labeling information - will there be sufficient user
information around to regenerate the file_contexts?
- How can a policy switch be done - how does the per-user information migrate to
the new policy for the switch?

An alternative option is to leave the home directory keywords unexpanded and
have matchpatchcon expand them on demand. This requires knowledge of what is a
home directory, which is difficult to get. We can either store that information
somewhere or require the caller to provide, e.g., setfiles could get a flag that
to allow the admin to specify which directories are home directories.

Anyone else have some insight? It really files like we are over-engineering this
problem and there is some simple solution once we fully understand the problem.
I have the gut feeling that pre-expanded file_contexts is the wrong way to go,
but no clear argument as to why. 

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
