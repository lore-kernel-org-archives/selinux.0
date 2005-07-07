Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j67CLsgA010070
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 08:21:54 -0400 (EDT)
Received: from web33203.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j67CJf3a005683
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 12:19:41 GMT
Message-ID: <20050707121927.21316.qmail@web33203.mail.mud.yahoo.com>
Date: Thu, 7 Jul 2005 05:19:27 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: Re: Useradd patchset - seeking comments..
To: selinux@tycho.nsa.gov
In-Reply-To: <1120684883.24068.16.camel@celtics.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Ivan Gyurdiev <gyurdiev@redhat.com> wrote:

> Here [ http://ivan.ivg2.net/selinux/patches/ ]
> is an updated patchset that attempts to 
> accomplish the following:
> 
> - provide library routines to easily edit and modify
> the various selinux data files (users file, file contexts,
> template file, map file... ) through libselinux,
> and make some changes to allow alternative backends
> in the future.
> 
> - integrate the utilities useradd/usermod/userdel
> with libselinux interface for manipulating users
> (currently useradd/userdel...still have to work
> on usermod). 

  Please be sure that anything in libselinux is general enough to work in ALL
the distros. Currently each new Debian user has to figure out what
/etc/default/useradd is; why it would be there; and what format it needs to
have. That is a RHism. As a script, at least, each Debian explorer can track
down the script, and have a chance of figuring it out. 

  But if you put the dependancy in 'compiled code', (and leave it all
undocumented (man libselinux = nada)) then you are excluding all other systems
that don't operate in just that one way. You will have created a linkage or
dependancy between what selinux provides and what it extects the user's system
to supply.

  Not a good idea for something that wants to be a solution for the community
in general, rather than a single vendor. If you look back at the development of
Xwindows, you see that it's behavior can be controlled by environment
variables, as well as multiple optional file names and paths.

  And just as a simple question, what if there are multiple storage loactions
for home directories? /u1/home;/u2/home/;/staff/private/home; What then? How
about:

  setenv SE_USER_HOMES  /u1/home;/u2/home/;/staff/private/home;

or better; a /etc/selinux/config line

  SE_USER_HOMES=/u1/home;/u2/home/;staff/private/home;

and then document selinux configuration options ( man 5 selinux ).

  
> 
> - alter the 1:1 user-to-seluser map scheme to
> what was discussed per Karl's proposal. Groups
> are disallowed. Syntax is subject to change.
> 
> - simplify the code necessary to work with
> and load policy in libsepol - this involves
> changing policydb to an opaque data structure,
> and deprecating functions that manipulate the
> policy (data, len) image. Also, there is a convenient
> create_policydb function in libselinux.
> 
> Patchset is not finished, but I want to see if you
> have any comments... 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"


		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
