Subject: Re: dumb newbie questions
From: "R. Steven Rainwater" <srainwater@ncc.com>
To: SELinux@tycho.nsa.gov
In-Reply-To: <1119282248.2766.31.camel@celtics.boston.redhat.com>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <1119213695.17213.29.camel@localhost.localdomain>
	 <1119238487.5253.23.camel@localhost.localdomain>
	 <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
	 <1119278717.30000.10.camel@rodan.ncc.com>
	 <1119280474.2766.9.camel@celtics.boston.redhat.com>
	 <1119281369.30000.56.camel@rodan.ncc.com>
	 <1119282248.2766.31.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1119285617.30000.88.camel@rodan.ncc.com>
Mime-Version: 1.0
Date: Mon, 20 Jun 2005 11:40:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-20 at 10:44, Ivan Gyurdiev wrote:
> On Mon, 2005-06-20 at 10:29 -0500, R. Steven Rainwater wrote:
> > I'm assuming now, that selinux makes guesses about what
> > sort of program it is by where it's located?
> 
> No - it doesn't guess anything - it makes this
> decision based on the SELinux context of the file
> (which eventually determines the SELinux context 
> of the process).

Okay, this is begining to make a little sense. So looking at my test
script again, when it's sitting in my home directory ls -alZ shows this:

-rwxrwxr-x rsr:rsr root:object_r:user_home_t  test.pl

If I run it there it works fine. But when I move it anywhere in the
/var/www tree, ls -alZ shows this:

-rwxrwxr-x rsr:rsr root:object_r:httpd_sys_content_t test.pl

And here it doesn't run (for me or root) but it will run for Apache. So
that means that when I copy or move a script, the context automagically
changes to correspond to whatever security rules are allowed within that
directory? That still sounds to me like "context" means it runs if I put
it in one directory but doesn't run if I put it in another.

It also seems that with the "user_home_t" context the program can use
stdout and run normally but with "httpd_sys_content_t" it can't use
stdout and can only be run from Apache.

I've discovered the chcon utility, so now I'm wondering if what I need
to do is change the context of my script to something that will allow
both Apache to run it as a CGI and ALSO allow root or another user to
run the script normally with stdout. But how do I find out what context
to set it to? Is there a list of available contexts and what permissions
they have? 

-Steve



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
