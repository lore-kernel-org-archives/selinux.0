Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KIDCRb021464
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KIAjB2016119
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:10:46 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id i4KIAjwi016113
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:10:45 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KID7WG026087
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:07 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i4KID7dp026085
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 14:13:07 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KI5CRf021358
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:05:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KHYjAR014857
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:34:46 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4KHXYHn014368 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:33:35 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: FAM uses seteuid and setegid
Date: Fri, 21 May 2004 03:32:23 +1000
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <20040520121538.GA8810@lkcl.net> <20040520162445.GM8810@lkcl.net> <1085070739.521.201.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1085070739.521.201.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405210332.23918.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 May 2004 02:32, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Thu, 2004-05-20 at 12:24, Luke Kenneth Casson Leighton wrote:
> > > Famd is badly designed for security.  There has been talk of replacing
> > > that functionality with other code, the general concept is that for a
> > > local FAM you just have the first process to call it fork off a child
> > > process which executes a famd in the user context, then other processes
> > > with the same UID can connect to the same famd.
> >
> >  that's much more sensible.
>
> Yes, but unfortunately it doesn't help with remote FAM usage, which
> isn't uncommon.

We can still use the current version of famd for remote use, it just becomes 
an option that does not need to be installed.  Previously famd was required 
for any fully functional desktop system, which is not what we want.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
