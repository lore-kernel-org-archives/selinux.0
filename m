Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA11276
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 07:34:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA14351
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 12:32:21 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA14347
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 12:32:20 GMT
Date: Fri, 6 Dec 2002 07:33:46 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Chris Vance <cvance@tislabs.com>, <selinux@tycho.nsa.gov>
Subject: Re: new policy
In-Reply-To: <200212052251.47349.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0212060724020.27022-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Dec 2002, Russell Coker wrote:

>
> If something is specific to a particular distribution then it should be
> surrounded by an appropriate ifdef.  Otherwise the policy for all
> distributions bloats causing wasted disk space everywhere.  If you want to
> put SE Linux on devices such as iPaq's then you don't want to be doing such
> things.
>

  No, the policies should be separate, in my opinion. Creating strong,
static couplings between pieces of the policy that have no logical
connection is bad. It's a variant of using data as meta-data, which has
caused more problems than (put your favorite bad thing here).

> Actually there's probably quite a few things that are Debian specific in the
> main policy because I'm writing lots of policy and no-one is checking whether
> it's the same way in other distributions.  We should probably work on these
> things.
>

  Yes, by keeping them out of the supported, RedHat policy that is part of
the distribution. Otherwise, we need a reliable means of detecting what
system we are on in order to build the policy. Checking the existence of a
policy piece you think is only on one type of system isn't the solution.

-- 
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
