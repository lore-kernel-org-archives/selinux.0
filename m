Message-ID: <1347640163.11029.61.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Update to docs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
Cc: William Roberts <bill.c.roberts@gmail.com>,
        "selinux@tycho.nsa.gov"
	 <selinux@tycho.nsa.gov>,
        "Craig, Robert P." <rpcraig@tycho.ncsc.mil>
Date: Fri, 14 Sep 2012 12:29:23 -0400
In-Reply-To: <33006C99F5A5194A9B7A7715DFA3E3836519B104@ALA-MBA.corp.ad.wrs.com>
References: 
	<CAFftDdr2YZiyFWfiyABAD_p81Usfz8SFeqaWBR7Uz40mJMFHhg@mail.gmail.com>
	 ,<1347627083.11029.12.camel@moss-pluto.epoch.ncsc.mil>
	 <33006C99F5A5194A9B7A7715DFA3E3836519B104@ALA-MBA.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-09-14 at 16:19 +0000, Radzykewycz, T (Radzy) wrote:
> There have been a couple times when I wanted to remove a rule from the
> system policy for a specific BSP.  So I guess I would vote for
> override if I need to choose one or the other.  But would it be
> reasonable to allow both overrides and concatenates ?  That would be
> my preference.

Maybe we could provide two variables definitions in the makefiles, one
for policy files that should replace/override and one for policy files
that should concatenate/union with the base policy files?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
