Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21JZXcE017352
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:35:33 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l21JauJC019592
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 19:36:56 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: postfix policy changes
Date: Thu, 1 Mar 2007 14:37:10 -0500
Message-ID: <1172777830.19169.64.camel@sgc.columbia.tresys.com>
In-Reply-To: <200702261731.l1QHV599030652@localhost.localdomain>
References: <200702261731.l1QHV599030652@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:31 -0500, dwalsh@localhost.localdomain wrote:
> lmtp and smtp are the same file require same context of setfiles complains
> postfix_pickup_t wants to read postfix_spool_maildrop_t dir

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
