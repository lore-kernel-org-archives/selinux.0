Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6R1La99026265
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 21:21:38 -0400
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Subject: Re: Questions about the MLS to "read down"
From: Joe Nall <joe@nall.com>
In-Reply-To: <CAFftDdqjHjjT2Ond9NHd7qkiYyFaEKYv3CZt2HxrPKsTQU-r8Q@mail.gmail.com>
Date: Thu, 26 Jul 2012 20:21:34 -0500
Cc: Haiqing Jiang <hqjiang1988@gmail.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Message-Id: <39957192-36AC-4A3E-A0D4-FDF353F202A6@nall.com>
References: <CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com> <3138EE6F-F894-46F2-A233-E3F014B1257C@nall.com> <CAFftDdqjHjjT2Ond9NHd7qkiYyFaEKYv3CZt2HxrPKsTQU-r8Q@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jul 26, 2012, at 8:15 PM, William Roberts <bill.c.roberts@gmail.com> wrote:

> How did you determine that c42 doesn't dominate c16?

Category dominance is having the same or a superset of the category bits. Using your category bits:

s0:c16,c42 dominates s0:c16,c42, s0:c16, s0:c42 and s0
s0:c42 dominates s0:c42 and s0
s0:c16 dominates s0:c16 and s0

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
