Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4SLhjI4018114
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2003 17:43:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4SLhYtV004421
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2003 21:43:34 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
        by jazzband.ncsc.mil  with ESMTP id h4SLhYal004418 for <selinux@tycho.nsa.gov>; Wed, 28 May 2003 21:43:34 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4SLhN05027755
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2003 17:43:28 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h4SLhMvV027753
	for selinux@tycho.nsa.gov; Wed, 28 May 2003 17:43:22 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4LKDmI4018106
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 16:13:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4LKDOuO002024
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 20:13:24 GMT
Received: from unicorn.lemuria.org (c145125.adsl.hansenet.de [213.39.145.125])
	by jazzswing.ncsc.mil  with ESMTP id h4LKDNlV002009
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 20:13:23 GMT
Date: Wed, 21 May 2003 22:11:22 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: patched wdm (success)
Message-ID: <20030521221114.C15451@lemuria.org>
References: <20030521193333.B14730@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030521193333.B14730@lemuria.org>; from tom@lemuria.org on Wed, May 21, 2003 at 07:33:40PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 21, 2003 at 07:33:40PM +0200, Tom wrote:
> I'm cleaning it up a little further right now and will put it up for
> download later. I'm having some minor troubles with the debian build
> system, I'm sure I'll figure it out.

http://selinux.lemuria.org

patched source code and debian package for testing/unstable. Also,
updated xdm.fc (Russell, want to include this in the default policy?)


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
