Subject: Re: matchpathcon regcomp return code
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Johan Fischer <jfischer@cmcrc.com>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov
In-Reply-To: <1128522897.24059.152.camel@moss-spartans.epoch.ncsc.mil>
References: <43436F35.4040204@cmcrc.com>
	 <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
	 <1128522566.22129.20.camel@sgc.columbia.tresys.com>
	 <1128522897.24059.152.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 13:38:50 -0400
Message-Id: <1128620330.22129.76.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-05 at 10:34 -0400, Stephen Smalley wrote:
> On Wed, 2005-10-05 at 10:29 -0400, Christopher J. PeBenito wrote:
> > We kept it separate because we were still working with the algorithm.
> > More importantly, we don't want to affect the example policy, since it
> > altered the order on at least one occasion, as discussed before.  If you
> > don't have a problem with this, we can certainly work on a patch for
> > matchpathcon.
> 
> Yes, I think it would be preferable to have it directly in matchpathcon,
> and we can add further pathname regexes as needed to fix any undesired
> changes in the actual labeling.  I don't know if you've done anything
> further with respect to the idea floated earlier about (optional)
> explicit precedence/order specifiers in file contexts, but we might want
> to introduce those at the same time.

We haven't added any precedence/order specifiers in the file contexts,
since, the previous problem I mentioned was fixed by adding another more
specific regex.  If we do want to add the optional specifiers, the
question becomes how we want to use it for comparison?  Should it be
used as the last comparison, like a tie-breaker, or as the first
comparison, which would group regexes of the same priority?  Also, what
happens if one regex has a precedence and the other doesn't?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
