Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB4Cp8Rb027168
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 07:51:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB4Cp5RX006825
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 12:51:06 GMT
Date: Thu, 4 Dec 2003 12:51:04 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, Dale Amon <amon@vnl.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy error of the day
Message-ID: <20031204125104.GR25416@vnl.com>
References: <20031129123120.GI18062@vnl.com> <200312010708.37773.russell@coker.com.au> <1070288825.12270.72.camel@moss-spartans.epoch.ncsc.mil> <1070288999.12270.76.camel@moss-spartans.epoch.ncsc.mil> <20031201143409.GI11972@vnl.com> <20031204124047.GQ25416@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031204124047.GQ25416@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actually not as much immediate worry as I thought:
the most important machine is all reiserfs so unless
I build with my xattr patches, it is guaranteed safe.
However I may want to add those patches so I can test
build rfs loop images, so the question still stands...
running into the issue is just delayed a bit.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
