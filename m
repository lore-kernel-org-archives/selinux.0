MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/2] policy capability support
Date: Wed, 5 Dec 2007 16:41:03 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801455FEE@exchange.columbia.tresys.com>
In-Reply-To: <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>
References: <20071205184848.180973622@tresys.com> <200712051421.39624.paul.moore@hp.com> <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com> <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil> <4757073B.70907@manicmethod.com> <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Joshua Brindle" <method@manicmethod.com>
Cc: "Paul Moore" <paul.moore@hp.com>, <selinux@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Yes, I'm still against (automatic, default) unioning of the
> capabilities by the linker - that is clearly not a safe default. 
> semodule could possibly override that behavior based on an option
> though, at which point the %post scriptlet in the policy rpm could
> use that option if we wanted to force it w/o user intervention.

What do we want the behavior of this option to be?  As I see it we
have two choices:

1) perform a union instead of requiring equivalence

2) add capabilities as needed to binary modules in the store.

The advantage of 2) is that it would only need to happen once which
makes it more "upgrade friendly".

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
