Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NJCRgA000099
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 15:12:28 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NJ25RO010249
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 19:02:05 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506231840.j5NIegqc030612@gotham.columbia.tresys.com>
References: <200506231840.j5NIegqc030612@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 15:00:08 -0400
Message-Id: <1119553208.16753.33.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Are you intending to do away with genhomedircon so that everything will be in
> libselinux?

libsepol...

The problem is that genhomedircon is in python, and useradd is in C.
Furthermore genhomedircon doesn't do what I want.

>  Why are you going to have to run around the file system? Isn't this
> a matter for taking the file contexts file that still has ROLE and HOMEDIR
> statements and processing that?

If I have a separate file for each user, I have to concat them together
for matchpathcon, is that not the case? I guess I can do that, but I'd
rather not..

If you take the more general case of removing an application - imagine
you want to remove mozilla, and have its contexts gone - you have
to reconstruct the entire file_contexts file from all the .fc files.

> Can you give an overview of these patches - what you are trying to accomplish in
> more detail and the design?

Well I was trying to accomplish the following:

- add -R flag to useradd, and have it automatically validate
and add user roles, and generate user contexts (and add user to running
policy)

- have userdel undo the above

- have usermod modify user roles in file and policy, and on default
role change, recreate the contexts.

- expose the net_contexts file through the libsepol library

In addition I am doing the following changes, which affect you:

- modify all libsepol functions to work via policydb and 
not (data,len) image (because there's no reason to policydb_read
on each function call...)

- make policydb an opaque data structure to address the
exposure created above

- separate genusers policy and parsing, to allow for alternative
data source in the future for the user information than the flat file.


This is accomplished by defining a "record" structure for
each configuration group (for example, the user record contains
the user's name, roles, default role, and mls info (and I've
bundled home dir for other purposes)). The fscon record
contains a regexp, a class (-b, -p), and a context. I'm
currently trying to break out the context as its own record,
since that makes sense to me.

Each record has a bunch of _file methods that define how
it can be parsed from a file, and written to a file.

Then I have a central routine called record_iterate,
and another one called record_modify_file that loop
over a file, and parse records (based on a table
of functions that explains how to do that),
and execute arbitrary handlers. Modify_file
is pretty similar to iterate, except it 
copies records to a second stream while
it's iterating, and then overwrites
the original at the end. Those functions
support events like delete, and match
that can be signaled by the handler, and support
configuring whether certain errors are fatal..




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
