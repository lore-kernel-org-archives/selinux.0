Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2FIANDo001108
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 13:10:23 -0500 (EST)
Subject: Re: Patch: Policy for NX server
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: rbg@informatik.uni-muenchen.de
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050212151251.GA5151@jmh.mhn.de>
References: <20050212151251.GA5151@jmh.mhn.de>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 13:05:55 -0500
Message-Id: <1110909955.19764.17.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.
Serviceusers is no longer being used, but since nx_server is using an
actual Unix user, I added the ifdef for user nx to users.

On Sat, 2005-02-12 at 16:12 +0100, Thomas Bleher wrote:
> This patch adds policy for the NX server.
> The server works like this: a new user nx is added; the users connect to
> the host via ssh with username nx; the nxserver is started by ssh and
> connects to the real user via ssh on localhost.
> To start nxserver in the correct context I had to add a new role.
> Only the server is currently protected, not the client or the nxagent. I
> also haven't tested the more advanced features like remote printing.
> 
> Thomas
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
