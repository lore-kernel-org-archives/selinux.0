Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1LjcXZ000871
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 16:45:38 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1LjWfI010338
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 21:45:37 GMT
Message-ID: <36282A1733C57546BE392885C06185924D91DC@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Chad Hanson
	 <chanson@TrustedCS.com>
Cc: Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Frank Mayer <mayerf@tresys.com>
Subject: RE: dynamic context transitions
Date: Mon, 1 Nov 2004 16:45:07 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> > I would assume this would along the lines of the trusted 
> reader/writer
> > concept. THe app is bounded to an MLS range. Instead of a 
> process being
> > ranged and running at unclass-confidential, it is bounded 
> by confidential
> > and effectively is running at either unclassfied or 
> confidential and able to
> > transition between the two levels.
> 
> I think I would need to see your MLS implementation to fully 
> assess the
> implications, but I'm not clear as to why this requires 
> changing levels
> dynamically vs. just giving the process the capability to write down
> while remaining at a single level.  Also, I'd be a bit concerned about
> what happens while the process is running at the lower level, e.g.
> attempted access by untrusted processes running at that lower level.
> 

This all depends on how modular an application or daemon maybe. In some
cases a write down is satsifactory. At others times, when using file
polyinstantiation, it maybe simpler to change labels instead of writing
down. In a larger daemon, it maybe that you want do processing at the label
of data before upgrading/downgrading the data.  There are a number of
applications which do things in different manners depending on the
circumstance. Your example above of untrusted process at lower level trying
to access the trusted process at the same level is another strong point for
utilizing TE to help provide stronger protections for solutions than exist
today.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
