Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA04010
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 15:29:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA21548
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 19:27:58 GMT
Received: from unicorn.lemuria.org (b067252.adsl.hansenet.de [62.109.67.252])
        by jazzband.ncsc.mil  with ESMTP id TAA21543 for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 19:27:57 GMT
Date: Tue, 8 Oct 2002 21:29:18 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: /proc woes
Message-ID: <20021008212917.A6663@lemuria.org>
References: <20021008171123.A6113@lemuria.org> <Pine.GSO.4.33.0210081439380.25356-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210081439380.25356-100000@raven>; from sds@tislabs.com on Tue, Oct 08, 2002 at 02:43:12PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 08, 2002 at 02:43:12PM -0400, Stephen Smalley wrote:
> > Rebooting the machine fixed it, so this may have happened during either
> > make relabel or make load (I installed a new policy today), though it's
> > still a mystery to me how and I'm one of the people who believe that a
> > reboot shouldn't be a valid solution. :)
> 
> I can't see any reason why a 'make relabel' or a 'make load' would yield
> this behavior.  'make relabel' only runs setfiles on mounted ext[23] or
> reiserfs filesystems to create or update the persistent label mappings.
> 'make load' doesn't relabel anything, although it might invalidate
> security contexts if you removed types (like proc_t), leaving existing
> objects in unlabeled_t (but not file_t).

Well, I *am* somewhat puzzled myself, but I've seen it happen. I will
experiment a little tomorrow afternoon to see if I can recreate it
(probably by replaying the bash history) and find out what caused this.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
