Subject: Re: dumb newbie questions
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1119281369.30000.56.camel@rodan.ncc.com>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <1119213695.17213.29.camel@localhost.localdomain>
	 <1119238487.5253.23.camel@localhost.localdomain>
	 <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
	 <1119278717.30000.10.camel@rodan.ncc.com>
	 <1119280474.2766.9.camel@celtics.boston.redhat.com>
	 <1119281369.30000.56.camel@rodan.ncc.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 11:44:08 -0400
Message-Id: <1119282248.2766.31.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-20 at 10:29 -0500, R. Steven Rainwater wrote:
> On Mon, 2005-06-20 at 10:14, Ivan Gyurdiev wrote:
> > > I quoted the source of my one line perl test script
> > >and error message it generated in a previous post. 
> > 
> > ...and  I've pointed out that your script doesn't run,
> > because httpd scripts are not allowed to write to the 
> > terminal.
> 
> What I wasn't understanding is why selinux thinks it's an httpd script.
> It seemed like a pretty generic "hello world" program to me. I'm
> assuming now, that selinux makes guesses about what sort of program it
> is by where it's located?

No - it doesn't guess anything - it makes this decision 
based on the SELinux context of the file (which eventually
determines the SELinux context of the process).
See my other mail.

This context is stored in the filesystem extended attributes
(xattr).

> What can I say, I chose the subject line for a reason... :-)

:) 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
