Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB6FuCPC014818
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 10:56:12 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lB6FuB4h021655
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 15:56:11 GMT
Subject: Re: More nsswitch changes.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47558E0A.1090600@redhat.com>
References: <47558E0A.1090600@redhat.com>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 10:55:56 -0500
Message-Id: <1196956556.12626.52.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-04 at 12:27 -0500, Daniel J Walsh wrote:
>  policy/modules/admin/alsa.te          |    6 ++----
>  policy/modules/admin/vpn.te           |   10 ++--------
>  policy/modules/apps/thunderbird.if    |   15 ++-------------
>  policy/modules/services/apache.te     |    2 ++
>  policy/modules/services/mta.if        |   13 ++-----------
>  policy/modules/services/postgresql.te |   10 ++--------
>  policy/modules/services/rshd.te       |    8 ++------
>  policy/modules/services/samba.te      |   14 ++------------
>  policy/modules/services/sendmail.te   |   14 ++------------
>  policy/modules/services/xserver.te    |    5 -----
>  policy/modules/system/authlogin.te    |    8 --------
>  policy/modules/system/mount.te        |    4 ----
>  12 files changed, 18 insertions(+), 91 deletions(-)

I dropped the alsa, apache, because I think the nis/nscd that is
currently in those are potentially wrong.  Back in the example policy,
there was some liberal usage of nis an nscd, and I suspect these are
just carryovers.  The netlink_route_socket usage provides a little more
evidence.  The other ones are merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
