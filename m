Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NHm5gA029110
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 13:48:06 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NHcDNa003059
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 17:38:15 GMT
Message-Id: <200506231737.j5NHbmqc029627@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Thu, 23 Jun 2005 13:37:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1119495651.8194.28.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Wednesday, June 22, 2005 11:01 PM
> To: selinux@tycho.nsa.gov
> Cc: Daniel J Walsh
> Subject: file contexts and modularity
> 
> So, I know Tresys is working on binary policy modules.
> 

It's not just the modules that are an issue - it is the policy server as well.

> What's the plan for dealing with the file_contexts file?
> 
> In particular, will this continue to be stored
> as a single giant flat file, or will it be broken up
> (or stored differently..)
> 

There are no plans to have the resulting file stored differently for the policy
modules. Each loadable module contains the file_contexts for that module. These
are concatenated together to create the standard file_contexts file that is put
in the same place. This does cause some problems with ordering, which we have a
partial fix for that I will sent out in a separate email.

We haven't made any decisions for the policy server other than we want the
policy server to encapsulate all policy access including file context
information. The details aren't clear to me and I would like some input about
this. See
http://sepolicy-server.sourceforge.net/index.php?page=policy-management-design
for some information about this.

> ============
> 
> I ask, because I am trying to figure out how to
> recover which contexts belong to which user, when parsing
> the file_context.homedirs file, as part of my
> useradd/usermod/userdel patch.
> 
> This isn't as simple as it sounds, since
> I can't use the user field (<<none>> contexts).
> I suppose I could regenerate the right contexts from the
> template, but that seems like bad design. Basically
> it's exactly the same problem as establishing which
> file_contexts relate to which app, so I'm wondering
> what's the planned solution for that? Is there a plan?
> 
> If we're going to keep this in a big flat file,
> there should be some sort of way to indicate
> a container for file contexts... (a dependency
> keyword(s) or something)... or we could split it up
> into multiple files.
> 
> Reminds me of the XML thread for some reason :)
> But on the other hand XML-style requires strict nesting
> relationship, while it would seem better to just do something like:
> 
> regexp class context [ dep_keyword1 dep_keyword2... ]
> (same row, brackets required).
> 
> Keywords could be users, applications, booleans, tunables, whatever..
> 

I think that I missed something - why do you need to know which contexts are
associated with an app or user?

Karl

> --
> Ivan Gyurdiev <ivg2@cornell.edu>
> Cornell University
> 
> 

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
