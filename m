Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB7FrJSN007116
	for <selinux@tycho.nsa.gov>; Fri, 7 Dec 2007 10:53:19 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lB7FrIYl026075
	for <selinux@tycho.nsa.gov>; Fri, 7 Dec 2007 15:53:18 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Patch to update boolean descriptions to match what I had inpolicycoreutils.
Date: Fri, 7 Dec 2007 10:49:59 -0500
Message-ID: <1197042599.12626.113.camel@gorn.columbia.tresys.com>
In-Reply-To: <475850A2.1050402@redhat.com>
References: <475850A2.1050402@redhat.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-06 at 14:42 -0500, Daniel J Walsh wrote:
> Hopefully these descriptions are a little better.

>  policy/global_tunables              |   35 +++++++++++++---------------
>  policy/modules/apps/java.te         |    7 -----
>  policy/modules/services/apache.te   |   44 +++++++++++++++++++++++++++++-------
>  policy/modules/services/bind.te     |    2 -
>  policy/modules/services/ftp.te      |    4 +--
>  policy/modules/services/kerberos.te |    2 -
>  policy/modules/services/openvpn.te  |    2 -
>  policy/modules/services/postfix.te  |   12 +++++++++
>  policy/modules/services/rpc.te      |    4 +--
>  policy/modules/services/rsync.te    |    4 +--
>  policy/modules/services/samba.te    |   12 ++++-----
>  policy/modules/system/mount.te      |    2 -
>  policy/modules/system/userdomain.te |    9 -------
>  13 files changed, 81 insertions(+), 58 deletions(-)

I applied the changes for the tunables that already exist, there were
some other ones that leaked into the patch.  It brought to my attention
that there are a few in global that only apply to unconfined.  I want to
move that to unconfined, but there is a possibility of an upgrade
problem now that unconfined is separated out into its own module on RH.
Does the RPM always install the base and the modules in one single
semodule command?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
