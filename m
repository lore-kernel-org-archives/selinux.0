Subject: Re: [PATCH 1/1] selinux: add support for installing a dummy policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
        SELinux <selinux@tycho.nsa.gov>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
In-Reply-To: <alpine.LRH.1.10.0808251911050.32555@tundra.namei.org>
References: <20080822193413.GA8401@us.ibm.com>
	 <alpine.LRH.1.10.0808230852320.24779@tundra.namei.org>
	 <20080823023812.GA30915@us.ibm.com>
	 <alpine.LRH.1.10.0808251911050.32555@tundra.namei.org>
Content-Type: text/plain
Date: Mon, 25 Aug 2008 08:16:55 -0400
Message-Id: <1219666615.2721.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-08-25 at 19:12 +1000, James Morris wrote:
> On Fri, 22 Aug 2008, Serge E. Hallyn wrote:
> 
> > Good point.  Where would people who'd want to use this be most
> > likely to look, in a scripts/selinux/README, or in
> > Documentation/selinux or Documentation/security/selinux or
> > somesuch?
> 
> There's Smack documentation under Documentation/, so perhaps next to that, 
> with a pointer to it in scripts/selinux/README.

In that case, we really ought to have a general introduction to SELinux
there first, and then include description of this dummy policy and a
pointer to the reference policy as part of that text.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
