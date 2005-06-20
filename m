Message-Id: <200506201735.j5KHZnqc016886@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>, "'R. Steven Rainwater'" <srainwater@ncc.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, <SELinux@tycho.nsa.gov>
Subject: RE: dumb newbie questions
Date: Mon, 20 Jun 2005 13:35:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119286753.5061.11.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Monday, June 20, 2005 12:59 PM
> To: R. Steven Rainwater
> Cc: Daniel J Walsh; SELinux@tycho.nsa.gov
> Subject: Re: dumb newbie questions
> 
> >  So
> > that means that when I copy or move a script, the context automagically
> > changes to correspond to whatever security rules are allowed within that
> > directory? That still sounds to me like "context" means it runs if I put
> > it in one directory but doesn't run if I put it in another.
> 
> Context in SELinux is mostly determined based on location.
> It uses organization based on the directory structure to label things
> properly. As Stephen explained, it matches based on regular expressions
> on the path.
> 

I'd state this differently - the context is determined based on the intended
usage or contents of the file/resource. This is often related to the location
but not necessarily. For example, most of the files under the document root for
apache are meant to be publicly viewable web pages, but not all (.htaccess for
example).

Karl 

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> > I've discovered the chcon utility, so now I'm wondering if what I need
> > to do is change the context of my script to something that will allow
> > both Apache to run it as a CGI and ALSO allow root or another user to
> > run the script normally with stdout.
> 
> So, as Eric mentioned, SELinux shouldn't be transitioning to a different
> context when executing a web script from the user shell. It sounds
> to me like this isn't what's happening, however. It sounds like
> unconfined_t simply can't access those files, which I suspect is a bug.
> 
> Are you sure the denial you got when running your script as root from a
> shell said: scontext=...httpd.. ? It would help if you could double
> check that.
> 
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
