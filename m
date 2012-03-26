Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QLjXqx032319
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 17:45:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 26 Mar 2012 17:45:30 -0400
From: David Quigley <selinux@davequigley.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] libselinux -- Hide unnecessarily-exported library
 destructors
In-Reply-To: <20120326204549.1127d58b@fornost.bigon.be>
References: <20120326204549.1127d58b@fornost.bigon.be>
Message-ID: <ff7d4be27473ad4aed2aa193d409b987@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm not suggesting you take on this work but this is a general 
suggestion. Should we change the default visibility in the compile to 
hidden and just export the symbols we want. This way we don't forget to 
mark things hidden in the future?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
