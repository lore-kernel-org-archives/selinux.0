Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9HFp9Ns029382
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 11:51:09 -0400 (EDT)
Received: from luminouswebdesign.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9HFmNSN013337
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 15:48:24 GMT
Received: from schaufler-ca.com (luminouswebdesign.com. [216.117.155.141])
	by luminouswebdesign.com (8.12.10/8.12.10) with SMTP id j9HFmj66016679
	for selinux@tycho.nsa.gov; Mon, 17 Oct 2005 11:48:45 -0400
Date: Mon, 17 Oct 2005 11:48:45 -0400
From: "schaufler-ca.com - Casey Schaufler" <casey@schaufler-ca.com>
Message-Id: <200510171548.j9HFmj66016679@luminouswebdesign.com>
To: selinux@tycho.nsa.gov
Subject: 
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:

> From: Russell Coker <russell@coker.com.au>
> To: "SE-Linux" <selinux@tycho.nsa.gov>
> Subject: MLS context?
> Date: Sat, 15 Oct 2005 20:27:54 +1000
>
> What is the canonical term for the MLS part of the
> policy? Currently I've
> been using the term "MLS context" to refer to the
> combination of level (or
> range of levels) and categories (if there are any).

Unix MLS systems use the term "Sensitivity Label"
to describe this unit of data. Some of the less
sophisticated systems also used the term
"MAC Label", although I doubt that is what
you would want on a system with the richer
MAC policy of SELinux. Never ever call this the
"MAC Level", "Sensitivity Level", or "Security
Level". Level is the heiracrhical component.
In the late 1980's and early 1990's the NSA
evaluators would slap us silly anytime we
tried to use any term other than "label". I
know that the CC evaluators are cut from a
different cloth, so maybe you can call it
something else, but if you want to go with
the "conventional" jargon, say "Sensitivity
Label".


> I am NOT going to say "MLS
> range and optional
> categories" 100 times in the course of a talk.

Whiner.

> Two
> words is the maximum, if
> there is no canonical term for this then we need to
> make something up.

Sensitivity Label. Make up something else if
you must distance yourself from prior art.

> Also what term should I use for the human-readable
> version of the above as
> taken from /etc/mcs.conf?

We always called it the Sensitivity Label, too
avoid getting smacked.

------------------------
Casey Schaufler
casey@schaufler-ca.com
650.906.1780








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
