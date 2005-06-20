Subject: Re: dumb newbie questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: SELinux@tycho.nsa.gov, "R. Steven Rainwater" <srainwater@ncc.com>
In-Reply-To: <1119280474.2766.9.camel@celtics.boston.redhat.com>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <1119213695.17213.29.camel@localhost.localdomain>
	 <1119238487.5253.23.camel@localhost.localdomain>
	 <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
	 <1119278717.30000.10.camel@rodan.ncc.com>
	 <1119280474.2766.9.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 12:28:32 -0400
Message-Id: <1119284912.24660.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-20 at 11:14 -0400, Ivan Gyurdiev wrote: 
> SELinux is not supposed to be transparent. 
> That was my misunderstanding when I first encountered it,
> and I have accepted this requirement since then. 

Hmmm...well, SELinux is designed to provide transparency as much as
possible (e.g. it allows default domain transitions and file type
transitions to reduce the need to modify applications, and the ability
to configure policy means that you get to choose where to make
functionality vs. security tradeoffs).

> If you are interested in the extra security offered, then
> you have to put in some extra effort in making your
> applications run on top of this system. Hopefully as
> the policy becomes more mature, this will be less
> of an issue.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
