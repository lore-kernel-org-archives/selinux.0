Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23848
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 08:43:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PDgxI08336
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 13:42:59 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h1PDgxf08332 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 13:42:59 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Wayne Salamon'" <wsalamon@tislabs.com>
Cc: "'Russell Coker'" <russell@coker.com.au>,
        "'Clem Skorupka'" <ragnor@mitre.org>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: Core policy
Date: Tue, 25 Feb 2003 08:42:30 -0500
Message-ID: <001101c2dcd3$c1d50ad0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.33.0302250628140.1479-100000@vox.gw.tislabs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I also thought of a #DEPENDS tag, but I'm not sure how well it would
be
> maintained by the policy writers. What would be nice is to have some
way
> of annotating policy file relationships in a modular way; possibly an
> #IMPORTS tag that means something to the compiler. If a policy file
uses a
> type defined in another file, unless that file is imported, it's an
error.
> The goal is to have more control over the relationships between policy
> components.

I'm not sure what distinction you're trying to make between #DEPENDS and
#IMPORTS.  #DEPENDS as I suggest would list those modules upon which the
given module is dependent upon.  Much the same concept of #IMPORTS,
except #IMPORTS to me implies some type of compile time checking.  Since
compile here is primarily "cat" I would think we should use a less
active verb.  #USES also crossed my mind, but that's too weak.  It seems
"depends" is the correct verb, though I personally care less about the
verb we use than the semantics we imply with the verb.  I would be happy
if we just captured the dependencies for now and let tools evolve to
manage them.

I don't advocate doing anything to change how these files are
concatenated in the current make process; I think tools will eventually
evolve, and there will be many ways to build a valid policy.conf file
(editors, other make models, operational management infrastructure,
etc.).  Even if we change checkpolicy (which I do not advocate, that's
putting too much knowledge about one particular build process into the
native language compiler), I would still want other development tools to
check dependencies as I configure the policy to avoid the compile-time
errors. 

I do think the current macro model complicates this somewhat (some of
them have built-in dependencies too). 

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
