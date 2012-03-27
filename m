Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2R0b9Qv007540
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 20:37:09 -0400
References: <20120326204549.1127d58b@fornost.bigon.be> <ff7d4be27473ad4aed2aa193d409b987@countercultured.net>
In-Reply-To: <ff7d4be27473ad4aed2aa193d409b987@countercultured.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/2] libselinux -- Hide unnecessarily-exported library destructors
From: Russell Coker <russell@coker.com.au>
Date: Tue, 27 Mar 2012 11:37:19 +1100
To: David Quigley <selinux@davequigley.com>,
        Laurent Bigonville <bigon@debian.org>
CC: selinux@tycho.nsa.gov
Message-ID: <4c271b25-c124-41e2-813f-eba4670a57a0@email.android.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I thought we already had a general agreement to do so, at least that was my impression after the last time I raised a related issue on this list.

But as you say it needs to be done by someone. 

David Quigley <selinux@davequigley.com> wrote:

>I'm not suggesting you take on this work but this is a general 
>suggestion. Should we change the default visibility in the compile to 
>hidden and just export the symbols we want. This way we don't forget to
>
>mark things hidden in the future?
>
>--
>This message was distributed to subscribers of the selinux mailing
>list.
>If you no longer wish to subscribe, send mail to
>majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.

-- 
Sent from my Samsung Galaxy S Android phone with K-9 Mail.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
