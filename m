Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8G6Aq7m022729
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 02:10:52 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8G6AopQ020048
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 06:10:51 GMT
Subject: Re: [PATCH 33/67] policycoreutils: sandbox: FIXME rewrite /tmp
 handling
From: Guido Trentalancia <guido@trentalancia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Fri, 16 Sep 2011 08:10:43 +0200
In-Reply-To: <4E725512.4080206@redhat.com>
References: <4E725512.4080206@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316153443.2364.48.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 15:42 -0400, Daniel J Walsh wrote:
> From 54ed5929b8f8ffac7bdc48d589c5cb38f6798530 Mon Sep 17 00:00:00 2001
> From: Eric Paris <eparis@redhat.com>
> Date: Mon, 15 Aug 2011 19:58:08 -0400
> Subject: [PATCH 33/67] policycoreutils: sandbox: FIXME rewrite /tmp
> handling
> 
> seunshare now creates a runtime temporary directory owned by root and
> with the sticky bit set properly.  Files from the user-specified
> directory
> are copied to the runtime directory and the changes synced back (using
> rsync)
> at the end of the seunshare run.
> 
> review needed to changelog correctness/completeness
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Dan Walsh <dwalsh@redhat.com>
> ---
>  policycoreutils/sandbox/sandbox     |    8 +-
>  policycoreutils/sandbox/seunshare.8 |    2 +-
>  policycoreutils/sandbox/seunshare.c |  488
> +++++++++++++++++++++++++++--------
>  3 files changed, 386 insertions(+), 112 deletions(-)

Is the above perhaps meant to fix CVE-2011-1011 ?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
