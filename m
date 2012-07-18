Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6ILU8Hs023308
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2012 17:30:08 -0400
Received: by ggnv5 with SMTP id v5so2204459ggn.12
        for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2012 14:30:07 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Initial support for translatable SEAndroid strings
Date: Wed, 18 Jul 2012 14:29:37 -0700
Message-Id: <1342646978-8919-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This patch is to start addressing the concerns of Google when adding
support for the selinux status in the Settings app. They want the
strings in the resource file. If you look at the per language resource
directory, they have strings.xml where strings have msgid fields. I have
been scouring the net trying to figure out how these are generated so I
can move onto finishing the multilanguage support, does anyone know how
to generate msgid values and do multilanguage support in general?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
