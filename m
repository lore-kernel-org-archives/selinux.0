Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBA1L0Rb025794
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 20:21:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBA1KGlU001340
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 01:20:16 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hBA1KFSX001331
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 01:20:15 GMT
Date: Wed, 10 Dec 2003 01:20:43 +0000
From: Dale Amon <amon@vnl.com>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: the /etc/selinux problem
Message-ID: <20031210012043.GF27704@vnl.com>
References: <20031203111746.A27632@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031203111746.A27632@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 03, 2003 at 11:17:47AM +0100, Tom wrote:
> There is a hen-egg problem in /etc/dpkg/postinst.d/selinux when you
> upgrade (don't know about fresh installs). Here's what I did to get it
> solved:
> 
> dpkg --purge selinux-policy-default
> manually rm -r /etc/selinux and rm -r /usr/share/selinux/policy
> now vi /etc/dpkg/postinst.d/selinux and put an exit 0 right at the
> start.
> now dpkg -i selinux-policy-default_1.2.real-13_all.deb
> 
> should now work. Remove the exit 0 from the script. You may have to

Yeah, but there's got to be a better way. Hopefully
Russell will figure out how to make his package work
in these 'corner cases' like you and I have been 
seeing lately.

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
