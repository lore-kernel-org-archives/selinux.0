Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJIqcRb019875
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 13:52:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAJIqXqY018331
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 18:52:33 GMT
Received: from southwark.dsl.net (southwark.dsl.net [65.84.81.9])
        by jazzband.ncsc.mil  with ESMTP id hAJIqW0o018328 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 18:52:32 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: <russell@coker.com.au>, "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: setools
Date: Wed, 19 Nov 2003 13:52:30 -0500
Message-ID: <000901c3aece$49f317f0$8100a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <200311192204.07725.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> It should take a command line parameter of a policy.conf file.  I
> want to type "apol /tmp/policy.conf" and save the effort of going
> through a GUI to specify a file to load.

Yup, and we have code to do that but it had a problem and we never 
got around to fixing it.  We'll try to address this in the December 
release.

> The "search using type" option in "Roles" displays types that are not
> domains (and therefore can't be in any role).  The drop-down would
> contain much less data if it only listed viable options.

The reason is we don't want to imply semantics within the tool;
in this case we don't want to assume that there is a attribute
with an identifier of "domain" and that this means types that
allowed to be associated with roles.  However, on other tabs we have 
allowed you to select an attribute to constrain what types are 
displayed in the drop down box.  Thus can enable the "constrain
by attribute" box, select "domain" attribute, and then have the
drop down box only show those types that have that attribute.
We'll work that in the December release. 

> There seems to be no way to say "tell me all interactions between
> staff_t and sshd_t".  Maybe I'm missing something here.

Yes you're probably correct in terms of a single place where all
interactions between two types, especially two domain types, are
identified.  Might be another type of analysis for us to do.  The main
interactions would be type rules (which you can search in the TE Rules
tab), though you might need to do two searched (making each source
and target), and domain transition analysis to find transition paths.
Possibly also shared role assignments and such.  It is starting to 
feel like a separate analysis we can do, and inventory all the 
interactions in one place.  Any idea of the complete list of 
"interactions" two types might have (besides the above)?

This will have to be put on the future enhancement list for possible
inclusion in the next version.

> Anyway apol is good, I recommend that you all try it out.

The December release will have improve information flow analysis,
though we're still a couple of releases from achieving our goal as
outlined in my ACM presentation.  Also the underlying libraries have 
been re-structure to allow non-X (non-TCL/TK) applications to use them.
For example, we'll have a couple of command line tools that do some
of the apol searches from command line for quick and dirty look ups.

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
