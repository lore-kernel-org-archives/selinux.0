Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NFaQrT018858
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 11:36:26 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NFaOwb001531
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 15:36:25 GMT
Subject: Re: conflict between libselinux and libsepol
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1093274975.20301.15.camel@nexus.verbum.private>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>
	 <1093030667.4212.4.camel@nexus.verbum.private>
	 <1093035295.4212.9.camel@nexus.verbum.private>
	 <1093274109.27211.102.camel@moss-spartans.epoch.ncsc.mil>
	 <1093274975.20301.15.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1093275301.27211.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Aug 2004 11:35:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-23 at 11:29, Colin Walters wrote:
> My personal habit has always been to do "make policy && make reload".
> But maybe we should move the validation to the $(FCPATH) target?

You likely actually want it to occur on some intermediate target that
depends on both $(LOADPATH) and $(FCPATH) and rewrite the install and
reload targets to depend on that intermediate target, so that validation
always occurs on an updated (policy, file_contexts) pair.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
