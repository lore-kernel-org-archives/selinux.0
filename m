Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAUEaPRb002940
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 09:36:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAUEZep5011844
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 14:35:40 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAUEZdt0011841
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 14:35:39 GMT
Date: Sun, 30 Nov 2003 14:36:06 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy error of the day
Message-ID: <20031130143606.GC11972@vnl.com>
References: <20031129123120.GI18062@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031129123120.GI18062@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Nov 29, 2003 at 12:31:20PM +0000, Dale Amon wrote:
> Ah...Russ... did you do something naughty? I note all of these are
> failing after the postinst.d/selinux. I wonder if you are 
> expecting these installs to be occuring under selinux rather
> than on a non-selinux 'factory' machine in a chroot:

I haven't heard back from you. Any ideas on what went
wrong? I can work around it if necessary by putting a
rm postinst.d/selinux in my script at that point so
that package installation doesn't get broken, but
sweeping things under the rug is hardly ever a good 
idea.

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
