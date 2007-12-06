MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/2] policy capability support
Date: Thu, 6 Dec 2007 15:24:01 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880145614C@exchange.columbia.tresys.com>
In-Reply-To: <1196964486.27508.107.camel@moss-spartans.epoch.ncsc.mil>
References: <20071205184848.180973622@tresys.com> <200712051421.39624.paul.moore@hp.com> <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com> <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil> <4757073B.70907@manicmethod.com> <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil> <47570BAC.3050705@manicmethod.com> <1196887806.16006.131.camel@moss-spartans.epoch.ncsc.mil> <4757109B.2080209@manicmethod.com> <1196954491.27508.15.camel@moss-spartans.epoch.ncsc.mil> <475826F2.1000601@manicmethod.com> <1196964486.27508.107.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Joshua Brindle" <method@manicmethod.com>
Cc: "Paul Moore" <paul.moore@hp.com>, <selinux@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Upgrade of base usually reflects a full policy update, whereas
> inserting a random module does not.  And if base doesn't work (e.g.
> doesn't have the capabilities it requires), then the system likely
> won't boot or function at all (modulo legacy rules).  I'm more
> comfortable with letting base dictate the policy capabilities than
> other modules. 

So if I understand correctly you are suggesting we restrict the
declaration of policycaps to base.  I have a version of the patch
set that does this--attempting to set a policycap in a module other
than base results in a syntax error from checkpolicy.  If that is
how we want to proceed I can send it out, the differences from the
last one are minor as you might expect.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
