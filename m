Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA07036
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 11:39:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA02277
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 16:36:42 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id QAA02273
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 16:36:40 GMT
Date: Wed, 22 Jan 2003 17:39:25 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: Wayne Salamon <wsalamon@tislabs.com>, selinux@tycho.nsa.gov
Subject: Re: Apache/mysql policy status ?
Message-ID: <20030122173922.A28736@lemuria.org>
References: <Pine.LNX.4.33.0301221047140.24032-200000@vox.gw.tislabs.com> <200301221722.03566.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301221722.03566.russell@coker.com.au>; from russell@coker.com.au on Wed, Jan 22, 2003 at 05:22:03PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 22, 2003 at 05:22:03PM +0100, Russell Coker wrote:
> On Wed, 22 Jan 2003 17:06, Wayne Salamon wrote:
> >   Attached is the new patch. I haven't addressed the MySQL or PHP issues.
> 
> Apart from the MySql issue it all looks fine to me.  I'll merge it into my 
> tree now while awaiting a better solution to the MySql issue.

I'll start working on one, for both mysql and apache. I was very busy
with other stuff today, and will likely be for the rest of the week, so
it'll be a while.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
