Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01002
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 13:15:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA27169
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:14:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA27162 for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:14:04 GMT
Date: Mon, 26 Aug 2002 13:15:02 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: patch
In-Reply-To: <20020826003627.2259F74D7@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208261257090.24426-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 26 Aug 2002, Russell Coker wrote:

> This patch adds some new attributes and appropriate use of them.  Also it
> corrects some errors in attribute usage.
>
> I hope you'll accept these patches (or equivalent policy) into your tree and
> that we can come to a decision on what to do with devfs_t (whether to keep it
> or remove it) shortly.  Then it will be a lot easier to sort out the rest of
> the diffs.

Thanks, merged and available in the sourceforge CVS, without the
sysadm_devpts_t access.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
