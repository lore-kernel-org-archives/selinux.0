Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1JZSRb009453
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:35:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB1JYmp5001827
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:34:48 GMT
Received: from unicorn.lemuria.org (c152152.adsl.hansenet.de [213.39.152.152])
	by jazzswing.ncsc.mil  with ESMTP id hB1JYlt0001801
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:34:47 GMT
Date: Mon, 1 Dec 2003 20:28:14 +0100
From: Tom <tom@lemuria.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policy under version control
Message-ID: <20031201202813.I16359@lemuria.org>
References: <20031129132619.GE26960@lukas.schuldei.com> <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Mon, Dec 01, 2003 at 10:13:35AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2003 at 10:13:35AM -0500, Stephen Smalley wrote:
> There is already a sourceforge CVS tree, and patches can be posted to
> the selinux list.

The problem I see with read-only CVS and a post-to-mailinglist approach 
is that it's non-trivial to maintain various sets of the same policy.

It seems that in the long run we won't be able to do with a single
default policy. We'll need a couple, or a modular approach. Something
very much like Debian's tasksel or other tools for other distributions
where you have 5-10 fields you can check what your machine is going to
be, and the relevant policy is then assembled automatically.


One of the things that I heard arch can do very well is allow people to
make local branches of a repository while still linking to it so that
their local changes automatically stay in sync with the upstream
repository.

That's just one idea. The more I talk and work with SE, and I work
mostly from a user perspective in that I very rarely dabble in the SE
code itself, the more I belief that the policy is the major point
deciding over broad acceptance or not.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
