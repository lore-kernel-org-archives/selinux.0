Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1MrXRb011289
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 17:53:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB1Mqrp5018204
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 22:52:53 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hB1Mqrt0018201
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 22:52:53 GMT
Date: Mon, 1 Dec 2003 22:53:31 +0000
From: Dale Amon <amon@vnl.com>
To: Tom <tom@lemuria.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policy under version control
Message-ID: <20031201225331.GR11972@vnl.com>
References: <20031129132619.GE26960@lukas.schuldei.com> <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil> <20031201202813.I16359@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031201202813.I16359@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2003 at 08:28:14PM +0100, Tom wrote:
> It seems that in the long run we won't be able to do with a single
> default policy. We'll need a couple, or a modular approach. Something
> very much like Debian's tasksel or other tools for other distributions
> where you have 5-10 fields you can check what your machine is going to
> be, and the relevant policy is then assembled automatically.

I keep my own patch diff file between mine and Russell's default
package.

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
