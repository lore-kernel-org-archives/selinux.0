Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATK9Rol030888
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 15:09:27 -0500
Subject: Re: [PATCH] refpolicy: add X object classes to unconfined_t
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Xavier Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <cadfc0e40611290712g7fa802f2oa5b5ebc079e8ead2@mail.gmail.com>
References: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>
	 <450962DB.7050107@tresys.com>
	 <1158324416.8680.5.camel@twoface.columbia.tresys.com>
	 <1158355183.7554.268.camel@moss-huskies.epoch.ncsc.mil>
	 <cadfc0e40611290712g7fa802f2oa5b5ebc079e8ead2@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 15:09:26 -0500
Message-Id: <1164830966.2794.144.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 09:12 -0600, Xavier Toth wrote:
> I've replaced the XSELinuxConfig file with the attached version but
> Xorg still fails to start. Any advice would be appreciated.
> 

Are you running with targeted policy?  In your message to the X list you
indicated you were running MLS policy.  

What's in your Xorg log file?

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
