Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA07933
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 12:57:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA04731
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 16:55:45 GMT
Received: from centauri.ee.ucla.edu (centauri.ee.ucla.edu [128.97.92.179])
        by jazzband.ncsc.mil  with ESMTP id QAA04721 for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 16:55:44 GMT
Date: Mon, 15 Jul 2002 09:56:53 -0700 (PDT)
From: Simon Han <simonhan@ee.ucla.edu>
To: Stephen Smalley <sds@tislabs.com>
cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: locales
In-Reply-To: <Pine.GSO.4.33.0207150804500.29432-100000@raven>
Message-ID: <Pine.GSO.4.10.10207150946250.8335-100000@centauri.ee.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Mon, 15 Jul 2002, Stephen Smalley wrote:

> 
> On Mon, 15 Jul 2002, Russell Coker wrote:
> 
> > I suggest making the following change seeing as so many programs
> > require read access to the locale files:
> >
> > (still to resolve: execute permission for /usr/lib/gconv/*.so)
> 
> Access to writeable_t is granted by the general_file_write_access()
> macro.  'allow domain' rules should be minimized or completely avoided, as
> they prevent people from writing domains that are truly limited to least
> privilege.
> 

Just happen to check 'allow domain' rules.  In 'global_macros.te' file,
there is a 'general_file_read_access' macro, in which there is a line like
this

base_file_read_access(domain)

This looks strange to me.  
It seems that every te files that uses 'general_file_read_access' will
call 'base_file_read_access(domain)'
and end up having lots identical rules in policy.conf.
I have tried the following

% grep "allow domain root_t:dir" policy.conf | wc -l

and gives me 96 instance.

Just wonder if 'base_file_read_access(domain)' is supposed to be 

base_file_read_access($1)

Thanks for helping,
Simon


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
