Date: Thu, 23 May 2013 00:53:54 +0200
From: Laurent Bigonville <bigon@debian.org>
To: SELinux@tycho.nsa.gov
Subject: Last version of policycoreutils using Fedora only API
Message-ID: <20130523005354.418a2541@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

The last release of policycoreutils is using a function
(selinux_current_policy_path()) that is only available in Fedora. I
guess this shouldn't have made upstream.

An idea how this could be sorted for other distributions?

Cheers

Laurent Bigonville

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
