Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2FQ0XZ006469
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 10:26:00 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2FPxAw025982
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 15:26:00 GMT
Message-ID: <36282A1733C57546BE392885C06185924D9256@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Frank Mayer <mayerf@tresys.com>,
   "'Stephen Smalley'"
	 <sds@epoch.ncsc.mil>
Cc: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   Chad Hanson
	 <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: dynamic context transitions
Date: Tue, 2 Nov 2004 10:25:53 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Frank Mayer wrote:
> OK, then TE is deemed a more fundamental protection scheme, like rings,
and MLS
> a higher-level access control policy dependent upon TE's protection
features.
> I'm OK with that model, as long as we treat the TE more basic and
important than
> MLS, and not contort TE to fix MLS problems.  
> 
> I better understand the desire now, it truly isn't related to MLS, but TE
> privilege management in general.  The problem truly is the lack of an
efficient
> means to switch between domains. I would suggest our continued exploring
more
> controlled means of managing privilege (such the type hierarchy I
mentioned)
> than the ability to state arbitrary relationships (if we must go down this
> path).  Frank
> 

I don't have a problem with a hierarchy because it is similiar to defining
the dyntransition relationship. I would however want the ability to go up
and down in the hierarchy as well move laterally within the hierarchy.  I
would also like to make a sub-tree of the hieararchy be able to detach
itself and have the process bound into the sub-tree. We are using the domain
changes only for privilege management and have no reason to switch out of an
application domain hierarchy. In fact, a hierarchy mechanism is what we need
to easily implement the policy for a given application. 

-Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
