Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JF33Rb010997
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 11:03:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JF31AR014507
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 15:03:01 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
        by jazzband.ncsc.mil  with SMTP id i4JF30Hn014504 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 15:03:00 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 19 May 2004 14:56:11 -0000
Date: Wed, 19 May 2004 14:53:28 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: adduser script
Message-ID: <20040519145327.GK4221@lkcl.net>
References: <20040519091721.GA8839@lkcl.net> <00bf01c43d98$482f4fc0$4c0c010a@columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00bf01c43d98$482f4fc0$4c0c010a@columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 07:56:11AM -0400, Frank Mayer wrote:
> See seuser and the seuser* scripts in the setools package
> 

oh!  a bit more investigation: am i right in thinking that
seuser _is_ the program i was expecting (it is responsible
for modifying and managing /etc/selinux/*) and that the
seuser* scripts _are_ only calling seuser as required,
therefore seuser* _are_ already equivalent to adduser-ng?

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
