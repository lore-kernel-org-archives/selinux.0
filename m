Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FLKNWt028913
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 17:20:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9FLKF0p024590
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 21:20:15 GMT
Received: from extern.mail.waldi.eu.org ([82.139.201.30])
	by jazzswing.ncsc.mil  with ESMTP id h9FLK8r7024587
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 21:20:14 GMT
Date: Wed, 15 Oct 2003 23:20:13 +0200
From: Bastian Blank <bastian+selinux=tycho.nsa.gov@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: Re: avc_toggle and avc_enforcing
Message-ID: <20031015212013.GA27905@wavehammer.waldi.eu.org>
References: <3F8BE8E5.9050006@ipen.br> <1066145242.5054.213.camel@moss-spartans.epoch.ncsc.mil> <2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 15, 2003 at 10:21:48AM +1300, Kerry Thompson wrote:
> - initrd now mandatory

i hope you know, that initrd support is not available on some
architectures?
it may be better to rename /sbin/init to /sbin/init.real (yes, some
packaging system supports that) and use a script as /sbin/init. this
script loads the policy and executes the real init.

bastian

-- 
You can't evaluate a man by logic alone.
		-- McCoy, "I, Mudd", stardate 4513.3

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
