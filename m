Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA26668
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 12:41:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PHf5I21718
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 17:41:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h1PHf2f21714 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 17:41:03 GMT
Date: Tue, 25 Feb 2003 12:40:02 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: convention for disabled/unused policy modules
In-Reply-To: <002001c2dcef$633509f0$6600a8c0@columbia.tresys.com>
Message-ID: <Pine.LNX.4.33.0302251238350.1479-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Feb 2003, Frank Mayer wrote:

>
> Someone noted to me that we really should use "unused" rather than
> "Unused".  I agree; I'll update our tool to try :unused" first and only
> then to try "Unused" for backwards compatibility.  Frank
>
>

  Should we also push the corresponding .fc files into a unused directory?
The policy will build either way with the current system, but how would
you like to see it in the distribution?

-- 
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
