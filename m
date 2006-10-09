Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99H1xPH022529
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 13:01:59 -0400
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99H1K1s017757
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 17:01:20 GMT
Date: Mon, 9 Oct 2006 13:01:56 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, paul.moore@hp.com,
        sds@tycho.nsa.gov, eparis@redhat.com, jbrindle@tresys.com
Subject: RE: [PATCH 0/1] selinux: secid reconciliation fixes V01
In-Reply-To: <36282A1733C57546BE392885C0618592015CFD55@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0610091301080.29976@d.namei>
References: <36282A1733C57546BE392885C0618592015CFD55@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Oct 2006, Venkat Yekkirala wrote:

> I did in fact test inside SELinux, and that's how I found
> out these were igmp packets. These were getting labeled implicitly
> with unlabeled_t, and now after labeling thse distinctly, policy won't
> have to grant access to the network to unlabeled packets. An alternative
> is to not flow control any traffic that doesn't have a sock associated
> with it.

This might be worth considering as an intermediate step, and multicast 
support can be added later.  Just need to make sure it doesn't break 
anything else.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
