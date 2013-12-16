Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rBGEll61015352
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2013 09:47:50 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [GIT PULL] SELinux fixes for 3.13 (part two)
Date: Mon, 16 Dec 2013 09:47:45 -0500
Message-ID: <1517023.B0x2AxIfEM@sifl>
In-Reply-To: <1697743.qxb5mMM8vX@sifl>
References: <1697743.qxb5mMM8vX@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, December 13, 2013 03:04:31 PM Paul Moore wrote:
> Hi James,
> 
> Another pull request to include a single revert patch that was discussed
> earlier this week to address a problem with sync() hanging in certain
> circumstances.  In case you missed the email thread, see the following
> Fedora BZ for more information:
> 
>  * https://bugzilla.redhat.com/show_bug.cgi?id=1033965
> 
> Thanks.
> 
> ---
> The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:
> 
>   Linux 3.12 (2013-11-03 15:41:51 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux_fixes master
> 
> for you to fetch changes up to 5dae4637fecfc3326024f935cf00d460ba7b46bd:
> 
>   selinux: revert 102aefdda4d8275ce7d7100bc16c88c74272b260 (2013-12-13
> 14:55:48 -0500)
> 
> ----------------------------------------------------------------
> Paul Moore (1):
>       selinux: revert 102aefdda4d8275ce7d7100bc16c88c74272b260

It looks like Linus already did the revert on Sunday so you can probably 
disregard this now.

See commit 29b1deb2a48a9dd02b93597aa4c055a24c0e989f in Linus' tree.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
