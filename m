Subject: Re: dumb newbie questions
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <1119285617.30000.88.camel@rodan.ncc.com>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <1119213695.17213.29.camel@localhost.localdomain>
	 <1119238487.5253.23.camel@localhost.localdomain>
	 <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
	 <1119278717.30000.10.camel@rodan.ncc.com>
	 <1119280474.2766.9.camel@celtics.boston.redhat.com>
	 <1119281369.30000.56.camel@rodan.ncc.com>
	 <1119282248.2766.31.camel@celtics.boston.redhat.com>
	 <1119285617.30000.88.camel@rodan.ncc.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 12:59:13 -0400
Message-Id: <1119286753.5061.11.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Okay, this is begining to make a little sense. So looking at my test
> script again, when it's sitting in my home directory ls -alZ shows this:
> 
> -rwxrwxr-x rsr:rsr root:object_r:user_home_t  test.pl
> 
> If I run it there it works fine. But when I move it anywhere in the
> /var/www tree, ls -alZ shows this:
> 
> -rwxrwxr-x rsr:rsr root:object_r:httpd_sys_content_t test.pl

You need to make the distinction between move (as in mv)
and copy (as in cp). The former doesn't change context (just like
it doesn't change permissions). 

> And here it doesn't run (for me or root) but it will run for Apache.

That might be a bug in policy...
cc-ed dwalsh

>  So
> that means that when I copy or move a script, the context automagically
> changes to correspond to whatever security rules are allowed within that
> directory? That still sounds to me like "context" means it runs if I put
> it in one directory but doesn't run if I put it in another.

Context in SELinux is mostly determined based on location.
It uses organization based on the directory structure to label things
properly. As Stephen explained, it matches based on regular expressions
on the path.


> I've discovered the chcon utility, so now I'm wondering if what I need
> to do is change the context of my script to something that will allow
> both Apache to run it as a CGI and ALSO allow root or another user to
> run the script normally with stdout.

So, as Eric mentioned, SELinux shouldn't be transitioning to a different
context when executing a web script from the user shell. It sounds
to me like this isn't what's happening, however. It sounds like
unconfined_t simply can't access those files, which I suspect is a bug.

Are you sure the denial you got when running your script as root from a
shell said: scontext=...httpd.. ? It would help if you could double 
check that.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
