Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA29460
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 10:26:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA03025
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 14:25:15 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id OAA03021 for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 14:25:14 GMT
Date: Mon, 29 Apr 2002 13:49:03 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: f980215 <f980215@mailandnews.com>, selinux@tycho.nsa.gov
Subject: Re: how to hide one file or one directory
Message-ID: <20020429124903.GB30926@vnl.com>
References: <002401c1ef4f$907499a0$780aa8c0@r213> <Pine.GSO.4.33.0204290911150.19520-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204290911150.19520-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 29, 2002 at 09:26:50AM -0400, Stephen Smalley wrote:
> is worth the cost.  Even if you hide names, you still need to control all
> attempted accesses to the file, and a process can still probe for the
> existence of a file by trying to create a file with the same name.
 
Yes, and even more easily you can find things on LIDS
systems with file name completion:

cd /etc
ls l*<tab>

will show you that the lids config file is there. 

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
