Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72F0nrT013140
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 11:00:49 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72F0lKV014160
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 15:00:48 GMT
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1091458325.23449.102.camel@moss-spartans.epoch.ncsc.mil>
References: <20040801172751.GD20103@lkcl.net>
	 <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil>
	 <20040802145724.GG4194@lkcl.net>
	 <1091458325.23449.102.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1091458801.23449.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 11:00:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-02 at 10:52, Stephen Smalley wrote:
> What's the objection to patching udev to directly invoke matchpathcon(3)
> and setfscreatecon(3) prior to creating each device node?

BTW, if anyone does so, please pass the actual file mode to
matchpathcon(3), so that proper file type matching can be done against
the file_contexts configuration.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
