Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m67Il93h028990
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 14:47:09 -0400
Subject: Re: running filecaps ltp test
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, SELinux <selinux@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>, Andrew Morgan <morgan@kernel.org>
In-Reply-To: <20080707184252.GC22937@us.ibm.com>
References: <20080707184252.GC22937@us.ibm.com>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 14:47:04 -0400
Message-Id: <1215456424.27975.165.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-07-07 at 13:42 -0500, Serge E. Hallyn wrote:
> It looks like unconfined_t is not granted setfcap capability.  So
> when running ltp as unconfined_t, the file capabilities test fails.
> I'm just wondering what the right answer is:
> 
> 	1. require running ltp as an administrative type
> 	2. give ltp a custom policy module to create an ltp_t
> 	3. give setfcap to unconfined_t

unconfined_t should have all capabilities already.
Policy version?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
