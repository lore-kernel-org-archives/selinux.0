Subject: Re: How can modular policy ever have worked? [patch]
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: sds@tycho.nsa.gov, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1143331040.6084.15.camel@wintermute.xmldesign.de>
References: <1142691657.4017.23.camel@wintermute.xmldesign.de>
	 <1142865553.16487.21.camel@moss-spartans.epoch.ncsc.mil>
	 <1142867787.6145.18.camel@wintermute.xmldesign.de>
	 <1142870455.16487.68.camel@moss-spartans.epoch.ncsc.mil>
	 <1143331040.6084.15.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 10:48:00 -0500
Message-Id: <1143474480.3962.110.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-03-26 at 00:57 +0100, Erich Schubert wrote:
> Monolithic builds are broken AFAICT now, by the removal of the module
> name from the optional_policy statement... that way, the only optional
> policy you could maybe still build is the one containing all modules.
> When I downgrade policy/support/loadable_module.spt to the version with
> my original patch only, and downgrade to my latest version prior to the
> optional_policy $1 removal, I can build a monolithic policy.

I committed a fix for Rules.monolithic to fix this; disabled modules
interfaces were not being expanded.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
