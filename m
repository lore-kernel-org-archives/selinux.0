Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JEVWRb010580
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 10:31:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JEVTAR011780
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:31:29 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
        by jazzband.ncsc.mil  with SMTP id i4JEVSHn011777 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:31:28 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 19 May 2004 14:21:44 -0000
Date: Wed, 19 May 2004 14:19:02 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Frank Mayer <mayerf@tresys.com>, dac@tresys.com
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: adduser script
Message-ID: <20040519141902.GG4221@lkcl.net>
References: <20040519091721.GA8839@lkcl.net> <00bf01c43d98$482f4fc0$4c0c010a@columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00bf01c43d98$482f4fc0$4c0c010a@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 07:56:11AM -0400, Frank Mayer wrote:
> See seuser and the seuser* scripts in the setools package
 
 ah _ha_.

 okay.

 these are a very good base for adoption / adaption into adduser.

 unfortunately, the programs call useradd directly, which is what
 adduser-ng does [in a plugin].

 frank, would you be willing to split out the functionality
 of seuseradd etc. that deals with /etc/selinux/users into
 _separate_ programs?

 and make seuseradd etc. call those programs?

 at the moment, the structure is like this:

 seuseradd ---> useradd [-> accesses /etc/passwd]
            |
			|-> direct access to /etc/selinux/users

 and adduser-ng does this, with plugins being optional:

 adduser-ng ---> useradd [-> accesses /etc/passwd]
             |
			 |-> exim4plugin [-> accesses /etc/aliases]
			 |
			 |-> eximplugin [-> accesses /etc/aliases]
			 |
			 |-> PasswdUser plugin [-> direct access to /etc/shadow]
   
  
  what i would like to see is this:

 seuseradd ---> useradd [-> accesses /etc/passwd]
            |
			|-> addseuser [-> direct access to /etc/selinux/users]


 then i could _very_ easily do this, with oh about 1/2 a days' work:

 adduser-ng ---> useradd [-> accesses /etc/passwd]
             |
			 |-> exim4plugin [-> accesses /etc/aliases]
			 |
			 |-> eximplugin [-> accesses /etc/aliases]
			 |
			 |-> PasswdUser plugin [-> direct access to /etc/shadow]
             |
			 |-> addseuser [-> direct access to /etc/selinux/users]


 where addseuser is the functionality of the present seuseradd
 that manages /etc/selinux/users, split out into a separate program.

 etc.  same for seuserdel etc.


 go on, go on, you know you want to :)

 pleeease?

 everyone gains, because then the [standard] program adduser could be
 used to manage selinux users.

 sincerely,

 l.


> owner-selinux@tycho.nsa.gov wrote:
> > Subject: adduser script
> > 
> > 
> > has anyone considered writing an adduser script modification
> > for selinux that adds users to /etc/selinux/users?
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
