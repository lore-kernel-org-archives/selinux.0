Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAEMFmRb027907
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 17:15:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAEMFLBb024053
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 22:15:21 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id hAEMFL4o024050
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 22:15:21 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAEMFkh9023310
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 17:15:47 -0500
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id hAEMFkHp023308
	for selinux@tycho.nsa.gov; Fri, 14 Nov 2003 17:15:46 -0500
Date: Fri, 14 Nov 2003 16:59:58 -0500 (EST)
From: Dean Anderson <dean@av8.com>
To: Russell Coker <russell@coker.com.au>
cc: SELinux@tycho.nsa.gov
Subject: Re: Verify the integrity of downloads
In-Reply-To: <200311131054.48634.russell@coker.com.au>
Message-ID: <Pine.LNX.4.44.0311141638110.28318-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 13 Nov 2003, Russell Coker wrote:

> On Tue, 11 Nov 2003 12:05, Dean Anderson wrote:
> > Certain ISPs in the Netherlands permit scanning that other ISPs think is
> > inappropriate.  Thus, said ISPs are blocked from entering the US by
> > certain American ISPs.  This could affect the NSA public sites, I suppose.
>
> Every ISP that has any customers permits scanning that some ISPs won't
> like.  If you lock down customers too much they go elsewhere.  The
> solution to such problems is to avoid getting hosting through American
> ISPs that put in stupid filters.

Well, Av8 doesn't have any such customers.  Few ISPs do. And mostly, the
ISPs that have such customers respond positively to complaints about such
scanning, and make the customers knock it off.  Some certain Netherlands
ISPs do not.  I would offer to be a mirror site, but very likely, we are
also blocking this Netherlands ISP, or will be soon.

Probably the solution is to avoid getting service through a Netherlands
ISP that permits this scanning.  It should not be overlooked that the
purpose of this scanning is to obtain information and/or crash computers,
or contact virus-infected machines.  There is no legitimate purpose to
this scanning activity.  At best it is mischief and frequently, it is
criminal.

> > On the other hand, it could the user's ISP that is blocking the NSA...
>
> Unlikely.  Blocking web servers makes the ISP an "editor" of the Internet
> content (and therefore legally liable to some degree for what they don't
> censor).  This is why hardly any ISPs block the truely objectionable
> material.

The "editor"-ness would be true of either ISP.  Why is it more likely for
one ISP to be blocking than for the other ISP to be blocking?  I left out
the case that it might be an ISP in the middle. But that is also possible.

But since the netherlands ISP doesn't have to worry about US law, and
presumably doesn't have to worry about the editing of content from the US
government, it seems to me that of the (minimum) two ISPs involved, the
Netherlands ISP probably has the least liability for blocking.

> > One used to be able to tell where the block was by the ICMP error
> > return, but some many ISPs are blocking ICMP these days that it is
> > hard to tell what is wrong, or where.
>
> If we got in contact with the person who reported this problem then we
> could probably track it down in a small amount of time.  The real
> problem here is that we don't even have contact with the person who had
> the problem (and lots of people want to download SE Linux without
> identifying themselves, so presumably they aren't the only one).

True enough. That is why most ISPs don't accept abuse reports that don't
identify the parties involved.  Certain anti-s*am sites send abuse reports
in which the victim's address is removed.

		--Dean


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
