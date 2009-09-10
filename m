Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AK4dUH026610
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 16:04:39 -0400
Received: from goalkeeper.city-fan.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AK60jU028477
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 20:06:00 GMT
Date: Thu, 10 Sep 2009 21:04:21 +0100
From: Paul Howarth <paul@city-fan.org>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [refpolicy] new policy for dkim-filter
Message-ID: <20090910210421.150ff80f@metropolis.intra.city-fan.org>
In-Reply-To: <1252611656.2486.44.camel@vogon.seekline.net>
References: <1252611656.2486.44.camel@vogon.seekline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Sep 2009 21:40:56 +0200
Stefan Schulze Frielinghaus <stefan@seekline.net> wrote:

> Attached is a new policy for the dkim-filter application.
> 
> Chris, is the policy OK/ready for merge?

I think it would be better to merge it with the milter policy. That
would then need no changes to the sendmail policy and the milter should
work with postfix too.

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
