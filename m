Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k28IUiVa030012
	for <selinux@tycho.nsa.gov>; Wed, 8 Mar 2006 13:30:51 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k28ITBI0016406
	for <selinux@tycho.nsa.gov>; Wed, 8 Mar 2006 18:29:11 GMT
Subject: Re: Patch to add a "netuser" role and user
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1141773189.5082.39.camel@wintermute.xmldesign.de>
References: <1141773189.5082.39.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 13:30:11 -0500
Message-Id: <1141842611.30819.182.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-08 at 00:13 +0100, Erich Schubert wrote:
> Hi,
> the following patch adds a "netuser" user and role.
> This is pretty much the same to user_u/user_r/user_t
> except that these users can bind non-privileged tcp ports
> (like user_u with the user_tcp_server boolean, no ssh port forwarding
> though)
> 
> Maybe this patch (when reviewed) could serve as an example on how to add
> new user roles?

The patch is a reasonable example for adding roles, but I'm not sure
that it should be added.  I can't think of a compelling need for it,
especially since its basically user_r with user_tcp_server enabled, as
you mention above.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
