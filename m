Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA29749
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 09:43:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA24860
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 14:42:43 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id OAA24856 for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 14:42:43 GMT
Date: Thu, 21 Mar 2002 14:56:02 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Getdate error
Message-ID: <20020321145602.GO10482@vnl.com>
References: <20020321121121.GJ10482@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020321121121.GJ10482@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had to fix this in three places:

	selinux/utils/fileutils-4.1/lib
	selinux/utils/sh-utils-2.0.11/lib
	selinux/utils/tar-1.13.19/lib

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
