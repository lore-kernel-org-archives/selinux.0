Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1K7SRb009919
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 15:07:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1K7RqY025714
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 20:07:27 GMT
Received: from wavehammer.waldi.eu.org (hornet.berlios.de [195.37.77.140])
        by jazzband.ncsc.mil  with ESMTP id hB1K7Q0o025710 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 20:07:26 GMT
Date: Mon, 1 Dec 2003 19:02:42 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: Re: policy problems
Message-ID: <20031201180242.GA5412@wavehammer.waldi.eu.org>
References: <20031130183701.GA14242@wavehammer.waldi.eu.org> <1070288686.12270.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1070288686.12270.68.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2003 at 09:24:46AM -0500, Stephen Smalley wrote:
> Is there a 'type_transition initrc_t inetd_exec_t:process inetd_t;' rule
> in your policy.conf file?  xinetd is running in inetd_t on my system.

it seems to be fixed after a reboot.

bastian

-- 
But Captain -- the engines can't take this much longer!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
