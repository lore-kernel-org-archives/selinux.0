Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7VD7YMU005052
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 09:07:34 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n7VD8PhX007383
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 13:08:39 GMT
Subject: Re: [refpolicy] [PATCH 0/2] Policy support for the new TUN hooks
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
In-Reply-To: <20090828211039.2821.58710.stgit@flek.lan>
References: <20090828211039.2821.58710.stgit@flek.lan>
Content-Type: text/plain
Date: Mon, 31 Aug 2009 09:04:38 -0400
Message-Id: <1251723878.8357.123.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-08-28 at 17:13 -0400, Paul Moore wrote:
> Second, and hopefully final, version of the SELinux policy for the new TUN
> hooks.  This version includes all the feedback from Chris discussed on the
> list as well as my sign-off.

Merged.

> ---
> 
> Paul Moore (2):
>       refpol: Policy for the new TUN driver access controls
>       refpol: Add the "tun_socket" object class flask definitions
> 
> 
>  policy/flask/access_vectors         |    2 ++
>  policy/flask/security_classes       |    2 ++
>  policy/modules/admin/vpn.te         |    1 +
>  policy/modules/apps/qemu.if         |    3 +++
>  policy/modules/apps/uml.te          |    6 ++++++
>  policy/modules/services/openvpn.te  |    1 +
>  policy/modules/services/virt.if     |   19 +++++++++++++++++++
>  policy/modules/services/virt.te     |    1 +
>  policy/modules/system/userdomain.if |   23 +++++++++++++++++++++++
>  policy/modules/system/userdomain.te |    2 ++
>  10 files changed, 60 insertions(+), 0 deletions(-)
> _______________________________________________
> refpolicy mailing list
> refpolicy@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/refpolicy
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
