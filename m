Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IIx0rT019361
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 14:59:00 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5IIwvrD005373
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 18:58:57 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 18 Jun 2004 18:29:13 -0000
Date: Fri, 18 Jun 2004 18:26:24 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: kde (users) requires read permission to /var/spool/cups(/certs/0)
Message-ID: <20040618182624.GB362@lkcl.net>
References: <20040613103203.GF2861@lkcl.net> <200406141546.29122.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406141546.29122.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 14, 2004 at 03:46:29PM +1000, Russell Coker wrote:
> On Sun, 13 Jun 2004 20:32, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > don't exactly know what this is about, but if i boot in
> > non-enforcing mode then i can add a local cupsys-managed
> > printer WITHOUT having to type in a password (a desirable
> > thing for a single user home office system), and i get this
> > in the audit logs:
> >
> > 	allow user_t print_spool_t:dir { search };
> > 			#EXE=/usr/bin/kdeinit  NAME=cups   :  search
> 
> On my system that directory is more 0700 so a user can't search it anyway.  
> Are you sure that kde is doing the right thing?
 
 ... and therefore, if you add a printer, you get asked for
 a username / password, yes?

 however, if you add the user to the lpadmin group, and you then
 also allow that user to access that directory (perms 0750, perhaps? )
 then i think you will find that you do not get asked for a username
 or a password.

 for the system that i am setting up, this is a desirable scenario
 [not being asked for user/pass] because i will not BE giving out
 usernames or passwords - very much a WYSIWYG philosophy.

 l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
