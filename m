Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79IiXrT027304
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 14:44:33 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i79IiVIn004448
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 18:44:31 GMT
Subject: Re: lots of allow xxx_device_t device_t:filesystem { associate }
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040809175246.GK3868@lkcl.net>
References: <20040809175246.GK3868@lkcl.net>
Content-Type: text/plain
Message-Id: <1092077016.29199.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 09 Aug 2004 14:43:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-09 at 13:52, Luke Kenneth Casson Leighton wrote:
> i'm getting an awful lot of the above due to udev creating
> inodes in /dev which i decided to associate with device_t.

allow device_type device_t:filesystem associate;
should cover most cases.

> now i have had to add about 15 or 20 lines so far each for pretty
> much every xxx_device_t under the sun, and am concerned that i
> am taking the wrong approach.

Other than the associate permission, what else do you need to add?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
