Subject: Re: dumb newbie questions
From: "R. Steven Rainwater" <srainwater@ncc.com>
To: SELinux@tycho.nsa.gov
In-Reply-To: <1119280474.2766.9.camel@celtics.boston.redhat.com>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <1119213695.17213.29.camel@localhost.localdomain>
	 <1119238487.5253.23.camel@localhost.localdomain>
	 <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
	 <1119278717.30000.10.camel@rodan.ncc.com>
	 <1119280474.2766.9.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1119281369.30000.56.camel@rodan.ncc.com>
Mime-Version: 1.0
Date: Mon, 20 Jun 2005 10:29:29 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-20 at 10:14, Ivan Gyurdiev wrote:
> > I quoted the source of my one line perl test script
> >and error message it generated in a previous post. 
> 
> ...and  I've pointed out that your script doesn't run,
> because httpd scripts are not allowed to write to the 
> terminal.

What I wasn't understanding is why selinux thinks it's an httpd script.
It seemed like a pretty generic "hello world" program to me. I'm
assuming now, that selinux makes guesses about what sort of program it
is by where it's located? My hello world program works in my home
directory but not in the httpd perl directory. I still don't entirely
understand why this should be but at least I know about it now and can
look out for it.

What can I say, I chose the subject line for a reason... :-)

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
