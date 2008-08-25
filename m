Date: Mon, 25 Aug 2008 19:12:14 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, SELinux <selinux@tycho.nsa.gov>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] selinux: add support for installing a dummy policy
In-Reply-To: <20080823023812.GA30915@us.ibm.com>
Message-ID: <alpine.LRH.1.10.0808251911050.32555@tundra.namei.org>
References: <20080822193413.GA8401@us.ibm.com> <alpine.LRH.1.10.0808230852320.24779@tundra.namei.org> <20080823023812.GA30915@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Aug 2008, Serge E. Hallyn wrote:

> Good point.  Where would people who'd want to use this be most
> likely to look, in a scripts/selinux/README, or in
> Documentation/selinux or Documentation/security/selinux or
> somesuch?

There's Smack documentation under Documentation/, so perhaps next to that, 
with a pointer to it in scripts/selinux/README.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
