Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KID8Rb021448
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KIAgB2016110
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:10:42 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id i4KIAfwi016107
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:10:41 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KID3WG026075
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:03 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i4KID3d3026073
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 14:13:03 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KFG3Rb019527
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 11:16:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KFG0AR004138
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:16:00 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4KFFxHn004063 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:16:00 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: FAM uses seteuid and setegid
Date: Fri, 21 May 2004 01:14:53 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040520121538.GA8810@lkcl.net>
In-Reply-To: <20040520121538.GA8810@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405210114.53119.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 May 2004 22:15, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> so, famd is designed to "effectively" set its user and group ids,
> such that any file access is done as these, whilst still remaining
> actually running as root.

Famd is badly designed for security.  There has been talk of replacing that 
functionality with other code, the general concept is that for a local FAM 
you just have the first process to call it fork off a child process which 
executes a famd in the user context, then other processes with the same UID 
can connect to the same famd.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
