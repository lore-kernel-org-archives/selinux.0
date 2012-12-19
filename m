Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBJGxstS010779
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2012 11:59:54 -0500
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        eparis@redhat.com
Cc: netdev@vger.kernel.org, jasowang@redhat.com, mst@redhat.com
Subject: Re: [RFC PATCH v3 0/2] Fix some multiqueue TUN problems
Date: Wed, 19 Dec 2012 11:59:49 -0500
Message-ID: <2198139.EQv1ADVakk@sifl>
In-Reply-To: <20121218225001.16104.34454.stgit@localhost>
References: <20121218225001.16104.34454.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, December 18, 2012 05:53:37 PM Paul Moore wrote:
> A refresh/respin of the LSM/SELinux fixes to work on top of Jason's
> latest API tweak (now living in DaveM's net tree).  In general, I
> believe the hooks and thinking behind the v2 patchset still make sense
> so no changes there, although I did change the SELinux permission from
> "create_queue" to "attach_queue" to match the API changes.
> 
> Comments are welcome and encouraged; we need to get this fixed before
> 3.8 is released.

SELinux (I'm looking at you Eric) and LSM folks - any comments/objections to 
these changes?

> ---
> 
> Paul Moore (2):
>       selinux: add the "attach_queue" permission to the "tun_socket" class
>       tun: fix LSM/SELinux labeling of tun/tap devices

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
