Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h96I0VWt006823
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 14:00:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h96I0U7d020956
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 18:00:30 GMT
Received: from unicorn.lemuria.org (c152019.adsl.hansenet.de [213.39.152.19])
        by jazzband.ncsc.mil  with ESMTP id h96I0TRn020953 for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 18:00:30 GMT
Date: Mon, 6 Oct 2003 19:55:24 +0200
From: Tom <tom@lemuria.org>
To: Andreas Schuldei <andreas@schuldei.org>, selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Updated Release
Message-ID: <20031006195521.E9448@lemuria.org>
References: <1065114741.27477.3042.camel@moss-huskies> <20031003064750.GA4555@markus.schuldei.org> <1065188703.4080.114.camel@moss-spartans.epoch.ncsc.mil> <20031004114020.GA7845@markus.schuldei.org> <1065450015.3919.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1065450015.3919.13.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Mon, Oct 06, 2003 at 10:20:20AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 06, 2003 at 10:20:20AM -0400, Stephen Smalley wrote:
> Upgrading an existing system from the old SELinux to the new SELinux
> seamlessly is complicated; see the earlier discussions on the list
> regarding it, e.g.
> http://marc.theaimsgroup.com/?l=selinux&m=106156668426416&w=2

On Debian, it's not that hard if you can live with running it in 
non-SELinux or at least permissive mode during the update. I've just 
done it to my notebook last week. Here's a short step-by-step guide:

http://selinux.lemuria.org/install-2.6.html

It doesn't explicitly say so, but the system was a 2.4.21 SELinux
system when I started out.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
