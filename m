Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81J2m40019887
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 15:02:48 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81J29lZ022466
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 19:02:09 GMT
Subject: Re: Using scripting languages to "macro" policy
From: Erich Schubert <erich@debian.org>
To: Aleks Kissinger <aleks0@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46ffa45f0609010930h403bf000k6cbf561c1334dfef@mail.gmail.com>
References: <46ffa45f0609010930h403bf000k6cbf561c1334dfef@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 01 Sep 2006 21:02:31 +0200
Message-Id: <1157137351.9799.23.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Aleks,
When you are planning a different system to write policy, please
consider that people might want to use tools to edit or automatically
the policy source. This is already a serious limitation of the current
M4 policy.
Russel Coker recently had the example on how to merge two domains into
one.
There are conflicts, so it can't be done fully automatic. But you can't
automate too much with the current M4 policy. It basically boils down to
doing it all manually. If you want it somewhat automated, you probably
will have to process the two policy files with M4 and lose all the
benefits of the macros since you can't go back into pre-M4-processed
code.

It would be very good to have a policy language which does NOT embed
code.
Like some XML files for the policy and a set of transformation utilities
to process them. When done in a good way, the XML policy source files
could then be processed with all kinds of XML-capable tools, that don't
need extensive knowledge of the policy.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
 Nothing prevents happiness like the memory of happiness. --- A. Gide //\
 Trauet euren Träumen, denn das Tor der Ewigkeit ist darin verborgen. V_/_
                           --- Kahlil Gibran



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
