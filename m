Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6S0TVIa024139
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 20:29:31 -0400
Received: from exprod8og119.obsmtp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o6S0TZBB011264
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2010 00:29:36 GMT
Received: by pxi19 with SMTP id 19so816163pxi.12
        for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 17:29:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C4F77D6.1080700@chipblach.net>
References: <4C4F77D6.1080700@chipblach.net>
From: Jason Axelson <jaxelson@referentia.com>
Date: Tue, 27 Jul 2010 14:29:09 -1000
Message-ID: <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com>
Subject: Re: semanage
To: Ralph Blach <chipper19522@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 27, 2010 at 2:20 PM, Ralph Blach <chipper19522@gmail.com> wrote:
> how do I use semanage to list the policy modules.

Hi Chip,

Perhaps you are looking for "semodule -l"? That will list out all the
installed policy modules (besides base).

Jason

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
