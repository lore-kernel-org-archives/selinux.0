Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAIGAH9w002039
	for <selinux@tycho.nsa.gov>; Sat, 18 Nov 2006 11:10:17 -0500
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAIG8cvx016971
	for <selinux@tycho.nsa.gov>; Sat, 18 Nov 2006 16:08:38 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 00/13] NetLabel cleanups for 2.6.20 [GIT]
Date: Sat, 18 Nov 2006 11:10:24 -0500
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
References: <20061117223842.399078000@hp.com> <XMMS.LNX.4.64.0611172308070.13574@d.namei>
In-Reply-To: <XMMS.LNX.4.64.0611172308070.13574@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611181110.25281.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 17 November 2006 11:12 pm, James Morris wrote:
> On Fri, 17 Nov 2006, paul.moore@hp.com wrote:
> > This patchset consists of a lot of small-ish cleanups for NetLabel and in
> > some cases labeled networking in general.  I've tested these patches for
> > the past few days and I haven't seen any regressions so please consider
> > them for the net-2.6.20 git tree.
>
> Thanks, excellent!
>
> There was one minor compilation issue caused by including linux/skbuff.h
> in an SELinux header, which I fixed (see below).

<scratching head>
Huh, sorry about that ... thanks for accepting the patches and making the fix.
</scratching head>

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
