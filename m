Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05887
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 12:51:34 -0400 (EDT)
Date: Tue, 1 Oct 2002 12:51:02 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: new policy patch
In-Reply-To: <200209272342.49247.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210011250310.14489-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 27 Sep 2002, Russell Coker wrote:

> The attached patch has my latest changes.  A minor dpkg patch, some qmail
> changes that are particularly needed for mailman and other things that
> require mail being piped, samba changes for /etc/samba/secrets.tdb, type
> labelling for the suseradd program, a squid cron job policy change, and a
> change that hopefully fixes the su gph problem Brian reported.

Thanks, merged except for the suseradd stuff, which has moved into
suseradd.fc.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
