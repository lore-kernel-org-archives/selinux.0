Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9JLDsNs025118
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 17:13:54 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9JLB4jJ005902
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 21:11:05 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DD7FD61AF7
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 07:11:01 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12675-04 for <selinux@tycho.nsa.gov>;
	Thu, 20 Oct 2005 07:10:59 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 71C7D61AF4
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 07:10:58 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 315EA5C
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 07:10:49 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: Re: MLS context?
Date: Thu, 20 Oct 2005 06:36:46 +1000
References: <200510152027.59150.russell@coker.com.au> <1129553314.26309.13.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129553314.26309.13.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Message-Id: <200510200636.51551.russell@coker.com.au>
Content-Type: text/plain;
  charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 17 October 2005 22:48, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sat, 2005-10-15 at 20:27 +1000, Russell Coker wrote:
> > What is the canonical term for the MLS part of the policy?  Currently
> > I've been using the term "MLS context" to refer to the combination of
> > level (or range of levels) and categories (if there are any).
> >
> > Is this an OK term?  If not then what should I use?
>
> The correct term would be the "MLS range", where:
> a) the range includes a low level and a high level, with the high
> defaulting to the low if unspecified,
> b) each level consists of a sensitivity and an optional set of
> categories, e.g. s0:c0,c3 is a level consisting of sensitivity s0 and
> category set {c0, c3}.

One problem with using the term "MLS range" is that it forces me to explain 
ranges much earlier in the discussion than I desire.  Generally I only want to 
explain enough about MLS to allow the people in the audience to decide which 
of MCS and MLS is most appropriate for their needs.

Besides, I can't give a good explanation of ranges at the moment, most of the 
audience could not understand it in the time allotted for a typical lecture, 
and those who could understand such an explanation probably already know it.  
So I want to avoid having the discussion go there.

On Tuesday 18 October 2005 01:48, "schaufler-ca.com - Casey Schaufler" 
<casey@schaufler-ca.com> wrote:
> Unix MLS systems use the term "Sensitivity Label"
> to describe this unit of data. Some of the less
> sophisticated systems also used the term

"Sensitivity Label" works for me.  Logically it makes sense, it doesn't 
specify whether it's one or two fields, it seems to clearly describe the data 
in question in terms that people will understand as well as apparently being 
historically acceptable.

> "MAC Label", although I doubt that is what
> you would want on a system with the richer
> MAC policy of SELinux. Never ever call this the
> "MAC Level",

I certainly would not call such things MAC.  I have recently become aware that 
"MAC" was known in some circles as a synonym for "MLS".  I oppose such use, 
the "M" in "MAC" stands for Mandatory and any other interpretation makes no 
sense to me.

> "Sensitivity Level", or "Security 
> Level". Level is the heiracrhical component.

Again, this is just sensible use of the English language.

> In the late 1980's and early 1990's the NSA
> evaluators would slap us silly anytime we
> tried to use any term other than "label". I

Slapping people silly for mis-use of the English language is a good thing.

> > Also what term should I use for the human-readable
> > version of the above as
> > taken from /etc/mcs.conf?
>
> We always called it the Sensitivity Label, too
> avoid getting smacked.

However that doesn't work well.  I would like to differentiate between the 
human readable form and the canonical form.  Maybe I can just say 
"sensitivity label" when I don't care (or when it doesn't matter) and specify 
canonical or non-canonical as appropriate otherwise.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
