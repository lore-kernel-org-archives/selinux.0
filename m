Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1ISSXZ028644
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 13:28:28 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1IR1CE022897
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 18:27:07 GMT
Message-ID: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>,
   Frank Mayer <mayerf@tresys.com>
Subject: RE: dynamic context transitions
Date: Mon, 1 Nov 2004 13:28:57 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> On Fri, 2004-10-29 at 15:10, Darrel Goeddel wrote:
> > A process may also
> > jump between multiple MLS labels and perform actions at each.
> <snip>
> > The chain
> > of allowable dynamic  transitions is also controlled on a 
> context-pair
> > basis.  This allows a "dynamic  transition group" to be 
> treated as an
> > equivalence class for policy analysis.
> 
> These two statements seem to be in conflict to me.  Whereas 
> you might be
> able to legitimately collapse multiple domains into a single 
> equivalence
> class for information flow analysis purposes, I don't see how this is
> legitimate for levels.  If they were separate levels in the 
> first place,
> then they should be separate equivalence classes for 
> information flow. 
> Can you clarify?

Let me try to give some background.

The ability for a process to perform actions at multiple MLS labels exists
whether dynamic transitions exist or not. Privilege bracketing does limit
the use and permits removal of the ability from the process.

MLS level transitions will need to be controlled via new permissions on the 
process class (mls_upgrade and mls_downgrade).  Similar permissions will be 
implemented for objects.  Most processes will not have the ability to alter 
their MLS level (just as most will not be able to alter their domain).  For 
processes that have the ability to alter their mls level, they will need to
be 
regarded as having access to all levels of information within the process' 
clearance.

I would assume this would along the lines of the trusted reader/writer
concept. THe app is bounded to an MLS range. Instead of a process being
ranged and running at unclass-confidential, it is bounded by confidential
and effectively is running at either unclassfied or confidential and able to
transition between the two levels.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
