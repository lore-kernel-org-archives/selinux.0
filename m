Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KCnoRb018246
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 08:49:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KCnlAR020739
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:49:47 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4KCnlHn020736 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:49:47 GMT
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040520121157.GA2146@jmh.mhn.de>
References: <20040519074242.GK7348@lkcl.net>
	 <20040519100822.GA31914@colombo.cip.ifi.lmu.de>
	 <20040519115039.GB4221@lkcl.net>  <20040520121157.GA2146@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1085057380.521.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 08:49:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 08:11, Thomas Bleher wrote:
> I just rechecked, and it is indeed working fine on a SuSE box
> (kdebase3-kdm-3.2.2-8) without any patches, just using the selinux pam
> module.

Interesting.  We weren't able to use pam_selinux with gdm, as
pam_open_session was called from a different process.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
