Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01561
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 11:11:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA05720
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 15:09:38 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id PAA05711 for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 15:09:36 GMT
Date: Tue, 8 Oct 2002 17:11:23 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: /proc woes
Message-ID: <20021008171123.A6113@lemuria.org>
References: <20021008163245.A5508@lemuria.org> <Pine.GSO.4.33.0210081037410.25356-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210081037410.25356-100000@raven>; from sds@tislabs.com on Tue, Oct 08, 2002 at 10:40:30AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 08, 2002 at 10:40:30AM -0400, Stephen Smalley wrote:
> > So instead of having a patch, I have a question: My /proc is file_t:
> >
> > dr-xr-xr-x  root     root     system_u:object_r:file_t         proc
> 
> This implies that your /proc is an empty mountpoint and is thus unused.

No, it was populated and in use. (mount showed it mounted, and umount
failed with busy).


Rebooting the machine fixed it, so this may have happened during either
make relabel or make load (I installed a new policy today), though it's
still a mystery to me how and I'm one of the people who believe that a
reboot shouldn't be a valid solution. :)


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
