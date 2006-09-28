Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SEEUSV018169
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 10:14:30 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SEDOoX014214
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 14:13:24 GMT
Date: Thu, 28 Sep 2006 10:14:24 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Cory Olmo <colmo@TrustedCS.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, eparis@redhat.com,
        chanson@TrustedCS.com, dgoeddel@TrustedCS.com
Subject: Re: [Patch 1/3] SELinux: add support for quoted context mount option
In-Reply-To: <20060928082045.d52f4de8.colmo@TrustedCS.com>
Message-ID: <Pine.LNX.4.64.0609281012430.25566@d.namei>
References: <20060928082045.d52f4de8.colmo@TrustedCS.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Sep 2006, Cory Olmo wrote:

> Signed-off-by: Cory Olmo <colmo@TrustedCS.com>

Looks ok to me, and if Stephen acks it, I'll forward it upstream.

> ---
> 
>  hooks.c |   33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)

In the future, please use 'diffstat -p1' for this, from the top directory 
of the kernel.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
