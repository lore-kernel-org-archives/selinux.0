Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8IN9Xh9024357
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 19:09:33 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8IN93ic008422
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 23:09:04 GMT
Date: Mon, 18 Sep 2006 19:09:27 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        chanson@TrustedCS.com, Paul Moore <paul.moore@hp.com>
Subject: Re: [PATCH 1/7] secid reconciliation-v02
In-Reply-To: <1158608654.14194.37.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0609181908080.8538@d.namei>
References: <45019F57.9070501@trustedcs.com> <1158608654.14194.37.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 18 Sep 2006, Stephen Smalley wrote:

> I think answering the above questions would help to make clearer whether
> the patches are on the right track, as well as motivate their acceptance
> if they are.

I would also recommend working with Paul Moore to make a final patchset 
which addresses all of the issues for xfrm labeling and CIPSO, so that we 
can get this stuff completed upstream and in the distros.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
