Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBVNp7kZ000420
	for <selinux@tycho.nsa.gov>; Mon, 31 Dec 2012 18:51:07 -0500
Received: by mail-ea0-f178.google.com with SMTP id k11so5500080eaa.9
        for <selinux@tycho.nsa.gov>; Mon, 31 Dec 2012 15:50:35 -0800 (PST)
Date: Tue, 1 Jan 2013 00:50:09 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: Reloading policy fills audit log with "selinux_audit_rule_match:
 stale rule"
Message-ID: <20121231235008.GA5874@siphos.be>
References: <20121230095158.GA6943@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20121230095158.GA6943@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Dec 30, 2012 at 10:51:58AM +0100, Sven Vermeulen wrote:
> Hi guys,
> 
> When I reload the SELinux policy on my system (semodule -R) or rebuild
> and reload (semodule -B), for every action I do it generates a dozen or so
> errors like the following:
[...]

Okay, ignore this. I am apparently trying to mix a TCB IMA policy with an
LSM policy which gives some grievances. Using the pure TCB policy works just
fine.

So I learned that, and that you cannot easily disable IMA once it is built
in ;-)

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
