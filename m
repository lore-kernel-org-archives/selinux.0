Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBJIJ0ma024238
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 13:19:00 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBJIIwXJ027813
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 18:18:58 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id lBJIIsf9015162
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 13:18:54 -0500
Subject: Re: Fixes for sepolgen to parse Fedora 9 Policy
From: Karl MacMillan <kmacmill@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47695B92.6080707@redhat.com>
References: <4768F1FF.5020206@redhat.com>
	 <1198078147.12779.2.camel@clapton.mentalrootkit.com>
	 <47695B92.6080707@redhat.com>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 13:18:54 -0500
Message-Id: <1198088334.19154.13.camel@clapton.mentalrootkit.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2007-12-19 at 12:57 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Ok although, I think we should fix the policy to not cause this app to
> blow up.  When I give my talks about writing policy, it does not
> translate the handling of the utmp file properly because of this.
> 

But how can we? We're talking about old policies in the wild.

What I really want to do is to always parse everything and just catch
exceptions. The problem is that the parser internal state gets screwed
on some parse errors - haven't been able to track down the problem.

> What policies were broken.  I plan on back porting this change to Fedora 8.

I don't have the exact policy versions. For the Fedora 8 supplied
version it should be fine to drop the blacklist, but not in the upstream
version.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
