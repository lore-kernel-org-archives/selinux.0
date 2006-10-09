Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99EXjvO018673
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 10:33:45 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99EX6jU000051
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 14:33:06 GMT
Date: Mon, 9 Oct 2006 10:33:42 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com, sds@tycho.nsa.gov, eparis@redhat.com,
        jbrindle@tresys.com
Subject: Re: [PATCH 0/1] selinux: secid reconciliation fixes V01: Intro
In-Reply-To: <452A5CAB.6010003@hp.com>
Message-ID: <Pine.LNX.4.64.0610091032140.28526@d.namei>
References: <452A3ECF.5030105@trustedcs.com> <452A5CAB.6010003@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Oct 2006, Paul Moore wrote:

> Venkat Yekkirala wrote:
> > This patchset is relative to davem's net-2.6 git tree as of a few weeks back,
> > and is an incremental fix to the secid-reconciliation patch series plus
> > the ipsec leak patches.
> > 
> > This patchset includes the fix sent out this past Friday night.
> > 
> > This patchset is more immediately intended for the kernels undergoing
> > LSPP certification, but needs to be reviewed for very-near-future
> > upstreaming into 2.6.19.
> 
> >From what I understand the merge window for 2.6.19 is closed, it closed last
> week with the release of 2.6.19-rc1.  While 2.6.19 is still open for bugfixes,
> its not entirely clear to me this would qualify.  Perhaps James could give us
> his opinion.
> 
> Regardless, there is always 2.6.20 and of course RHEL5 although I wonder at this
> point if that ship has passed too.

Yep, any new features now would go into a 2.6.20 queue.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
