Subject: Re: matchpathcon regcomp return code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Johan Fischer <jfischer@cmcrc.com>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov
In-Reply-To: <1128522566.22129.20.camel@sgc.columbia.tresys.com>
References: <43436F35.4040204@cmcrc.com>
	 <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
	 <1128522566.22129.20.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 10:34:57 -0400
Message-Id: <1128522897.24059.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-05 at 10:29 -0400, Christopher J. PeBenito wrote:
> We kept it separate because we were still working with the algorithm.
> More importantly, we don't want to affect the example policy, since it
> altered the order on at least one occasion, as discussed before.  If you
> don't have a problem with this, we can certainly work on a patch for
> matchpathcon.

Yes, I think it would be preferable to have it directly in matchpathcon,
and we can add further pathname regexes as needed to fix any undesired
changes in the actual labeling.  I don't know if you've done anything
further with respect to the idea floated earlier about (optional)
explicit precedence/order specifiers in file contexts, but we might want
to introduce those at the same time.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
