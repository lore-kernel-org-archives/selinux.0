Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00576
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 11:12:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA00035
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 16:11:31 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id QAA00031 for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 16:11:31 GMT
Date: Thu, 21 Mar 2002 16:24:52 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Getdate error
Message-ID: <20020321162452.GQ10482@vnl.com>
References: <20020321121121.GJ10482@vnl.com> <Pine.GSO.4.33.0203211009170.19336-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0203211009170.19336-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 21, 2002 at 10:16:54AM -0500, Stephen Smalley wrote:
> The semicolons are missing in the upstream sources, but this doesn't
> appear to create a build problem for us.  bison appears to insert
> an extra semicolon automatically anyway.  We're using bison version 1.28,
> the standard one on RH7.1 and RH7.2.

I've got 1.34. Perhaps it's stricter?

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
