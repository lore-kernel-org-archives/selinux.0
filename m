Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA03870
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 10:00:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA10804
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 13:59:00 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id NAA10800
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 13:58:58 GMT
Date: Tue, 1 Oct 2002 16:00:26 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: policy version
Message-ID: <20021001160026.A24885@lemuria.org>
References: <20021001153015.A24185@lemuria.org> <Pine.GSO.4.33.0210010944400.1579-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210010944400.1579-100000@raven>; from sds@tislabs.com on Tue, Oct 01, 2002 at 09:51:56AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 01, 2002 at 09:51:56AM -0400, Stephen Smalley wrote:
> If you mean the 'Unlabeled outbound packet' messages, those are only
> warnings not denials, and should not prevent the flow of network traffic.
> I can likely remove these printk's entirely; they were to help track down
> an earlier problem with assigning labels to outbound packets.  When in
> enforcing mode, any outgoing unlabeled packets will be denied by the
> corresponding permission checks.

My bad - I just realized that something else was preventing the network
traffic.


Thanks a lot for your help, I think I may be able to salvage this
machine without a reinstall now.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
