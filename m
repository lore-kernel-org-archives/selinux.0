Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KGHHRb020256
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:17:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KGEpB2007633
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:14:51 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
	by jazzswing.ncsc.mil  with SMTP id i4KGEowi007624
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:14:50 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 20 May 2004 16:17:01 -0000
Date: Thu, 20 May 2004 16:14:23 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <rcoker@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Message-ID: <20040520161423.GJ8810@lkcl.net>
References: <20040519074242.GK7348@lkcl.net> <1085057380.521.70.camel@moss-spartans.epoch.ncsc.mil> <20040520145258.GF8810@lkcl.net> <200405210139.49261.rcoker@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405210139.49261.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 21, 2004 at 01:39:49AM +1000, Russell Coker wrote:
> On Fri, 21 May 2004 00:52, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> >  i _do_ notice in permissive / audit mode that kdeinit attempts to
> >  do an su:
> 
> Which program was it?  Almost every KDE program runs as kdeinit as an attempt 
> at optimising load performance.
 
 sadly i cannot tell.  i have been meaning to ask:

 is it possible to run things to present more debug info at the TIME
 that an avc message is placed in the logs?

 for example, when the above kdeinit occurs, to do, oh, i dunno,
 a ps -ax --forest.

 i don't really care how long it takes, what i care about is identifying
 the parent process(es).

 ... alternatively, do you know how could i tell?

 l.

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
