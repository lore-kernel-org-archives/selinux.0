Message-ID: <1386344766.2469.76.camel@d30>
Subject: Re: avtab dense hash table
From: Dominick Grift <dominick.grift@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Pavel Roschin
 <roshin@scriptumplus.ru>, selinux@tycho.nsa.gov
Date: Fri, 06 Dec 2013 16:46:06 +0100
In-Reply-To: <52A1DBA8.2050708@redhat.com>
References: <20131205130431.7fe3c727.roshin@scriptumplus.ru>
			 <52A08A87.2030009@tycho.nsa.gov> <1386258595.2469.18.camel@d30>
		 <52A0ED28.6050804@tycho.nsa.gov> <1386279472.2469.51.camel@d30>
	 <52A1D65C.3070607@tycho.nsa.gov> <52A1DBA8.2050708@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-12-06 at 09:14 -0500, Daniel J Walsh wrote:

> 
> We have been doing some consolidation in Fedora.  We have combined spam tools
> into a single domain spamassassin.  Might have been better to create a new
> policy for this.
> 
> We have also created antivirus which combined all of the antivirus tools.
> 
> The next big one I would like to see combined are mail servers and mail
> clients.  (Elimination of all the different postfix domains, would eliminate
> large numbers of bugs over the years.)
> 
> 

Yes i am aware of the antivirus policy in Fedora. I did not merge that
into refpolicy (yet) because at that point i did not feel comfortable
with it. I probably thought it was too early to merge it, and wanted to
wait for some of the bugs to be ironed out in fedora first.

Some other consolidation changes i am not comfortable with (yet).
fortunately those mostly apply to refpolicy-base, and so it is not up to
be to decide whether to adopt those or not.

There are also some things i plain do not like the way it is implemented
now. For example modules that have combinations of domains that might
not strictly depend on each other. (one possible example might be rhcs
module). I like to keep domains separate as much as possible because
that provides flexibility. e.g. I could remove one or a few without
having to remove them all.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
