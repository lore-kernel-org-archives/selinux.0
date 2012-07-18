Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6I0KK5o000553
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2012 20:20:20 -0400
From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: William Roberts <bill.c.roberts@gmail.com>,
        "selinux@tycho.nsa.gov"
	<selinux@tycho.nsa.gov>
CC: rpcraig <rpcraig@tycho.ncsc.mil>
Subject: RE: Change-Id: I61d34a9fd6975f23023f70f205a510e3357d843c
Date: Wed, 18 Jul 2012 00:20:14 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E3836507E650@ALA-MBB.corp.ad.wrs.com>
References: <CAFftDdrefoeyaFQsr-OXQdAXU9CRgvqbMg+gZ+WUEuRnb2dfEQ@mail.gmail.com>
In-Reply-To: <CAFftDdrefoeyaFQsr-OXQdAXU9CRgvqbMg+gZ+WUEuRnb2dfEQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I am also wondering if we really need mac_permisions.xml to be
> in in it's own repo. I think it should be in sepolicy since it
> is part of the policy of the device, like seapp_contexts.

I would like to see all policy be contained within a single git project.  It
could be divided into subdirectories, such as external/sepolicy/base and
external/sepolicy/mmac or something.  But having it all in one place
would be more convenient for overall system policy analysis.

________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of William Roberts [bill.c.roberts@gmail.com]
Sent: Tuesday, July 17, 2012 4:43 PM
To: selinux@tycho.nsa.gov
Cc: rpcraig
Subject: Change-Id: I61d34a9fd6975f23023f70f205a510e3357d843c

I think we need to discuss this change id further.
Commit sha b263780156624c38b23d638be6a2d8bdd17511f8 on master selinuxproject/master.

It really provides two functions:

1. x.509 cert to seinfo string mapping for seapp_contexts so the zygote spawns it in the right domain...
2. install time permission checking

I think these should be submitted as two different patch sets to AOSP respective of their functionality. I think the x.509 cert checks will get pulled in and I am not sure on the install time permission checking.

I am also wondering if we really need mac_permisions.xml to be in in it's own repo. I think it should be in sepolicy since it is part of the policy of the device, like seapp_contexts.

What are the communities opinions on these comments?

--
Respectfully,

William C Roberts




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
