Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JHr6Rb012615
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 13:53:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JHr4AR027045
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 17:53:04 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
        by jazzband.ncsc.mil  with SMTP id i4JHr3Hn027042 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 17:53:03 GMT
Date: Wed, 19 May 2004 17:18:55 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: adduser script
Message-ID: <20040519171855.GD17846@lkcl.net>
References: <20040519145327.GK4221@lkcl.net> <00f101c43dbb$c1111f40$4c0c010a@columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00f101c43dbb$c1111f40$4c0c010a@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 12:10:06PM -0400, Frank Mayer wrote:
> Luke Kenneth Casson Leighton wrote:
> > On Wed, May 19, 2004 at 07:56:11AM -0400, Frank Mayer wrote:
> >> See seuser and the seuser* scripts in the setools package
> >> 
> > oh!  a bit more investigation: am i right in thinking that
> > seuser _is_ the program i was expecting (it is responsible
> > for modifying and managing /etc/selinux/*) and that the
> > seuser* scripts _are_ only calling seuser as required,
> > therefore seuser* _are_ already equivalent to adduser-ng?
> 
> Yes based on your description, although I'm not familiar with adduser-ng.  The
> seuser program only manages the selinux aspect of users, and the scripts
> integrates seuser and the system user* utilities.
 
 excellent.

 btw fyi:
 
	lkcl@debian:~$ apt-cache show adduser-ng

	Description: Add and remove users and groups
	 This package is meant to be a replacement for the adduser script.
	 It's written in perl with flexibility and modularity kept in mind.
	 .
	 The major advantages are:
	 .
	  * built-in plugins for user and groups administration,
	  * different set of User Interfaces,
	  * very flexible configuration,
	  * good documentation on how to write your own plugins.
	 .
	 Homepage: http://adduser.linux.pl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
