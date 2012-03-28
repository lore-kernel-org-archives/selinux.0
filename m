Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2SGKr8B010932
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2012 12:20:54 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7BAE7214F3
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2012 12:20:53 -0400 (EDT)
Message-ID: <1332951623.15547.26.camel@lenny>
Subject: Re: [PATCH 27/73] libselinux: Enable many more gcc warnings for
From: Colin Walters <walters@verbum.org>
To: Eric Paris <eparis@parisplace.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, eparis@redhat.com,
        selinux@tycho.nsa.gov
Date: Wed, 28 Mar 2012 12:20:23 -0400
In-Reply-To: <CACLa4pv98tYgOihbuMu=em_k86DCcNpaHE2YBGqJpG_-zXyofA@mail.gmail.com>
References: <4F71D850.20203@redhat.com> <1332862097.15547.15.camel@lenny>
	 <CACLa4pv98tYgOihbuMu=em_k86DCcNpaHE2YBGqJpG_-zXyofA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-03-27 at 16:14 -0400, Eric Paris wrote:
> We lose part of the message Colin?

Yeah, sorry:

`-funit-at-a-time'
     This option is left for compatibility reasons. `-funit-at-a-time'
     has no effect, while `-fno-unit-at-a-time' implies
     `-fno-toplevel-reorder' and `-fno-section-anchors'.

     Enabled by default.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
