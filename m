Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KIDBRb021460
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KID8AR019997
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:13:08 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
        by jazzband.ncsc.mil  with ESMTP id i4KID7Hn019992 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:13:07 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KID5WG026081
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:05 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i4KID5Hf026079
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 14:13:05 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KFf7Rb019931
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 11:41:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KFcdB2005064
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:38:39 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4KFcbwi004951
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:38:37 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Date: Fri, 21 May 2004 01:39:49 +1000
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <20040519074242.GK7348@lkcl.net> <1085057380.521.70.camel@moss-spartans.epoch.ncsc.mil> <20040520145258.GF8810@lkcl.net>
In-Reply-To: <20040520145258.GF8810@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405210139.49261.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 May 2004 00:52, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  i _do_ notice in permissive / audit mode that kdeinit attempts to
>  do an su:

Which program was it?  Almost every KDE program runs as kdeinit as an attempt 
at optimising load performance.

It would be nice if we could turn off the kdeinit functionality and have KDE 
use exec like everything else.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
