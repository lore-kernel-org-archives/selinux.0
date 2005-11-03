Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA3DJBMA014460
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 08:19:11 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA3DDPp3003688
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 13:13:25 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id jA3DDKEG002955
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 08:13:20 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id jA3DDKku002954
	for selinux@tycho.nsa.gov; Thu, 3 Nov 2005 08:13:20 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA339wMA011539
	for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2005 22:09:58 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA334GKZ029668
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 03:04:16 GMT
Received: by wproxy.gmail.com with SMTP id i27so117596wra
        for <selinux@tycho.nsa.gov>; Wed, 02 Nov 2005 19:04:45 -0800 (PST)
Message-ID: <e12e59640511021904y1940f1a1i140aabff7f857f0b@mail.gmail.com>
Date: Thu, 3 Nov 2005 11:04:45 +0800
From: Wei Shen <cquark@gmail.com>
To: Remmolt Zwartsenberg <remmolt.zwartsenberg@silkroadtech.com>
Subject: Re: A question on integrating IPSec to Selinux
Cc: selinux@tycho.nsa.gov
In-Reply-To: <WSNCEXC0010dSHpVyLr00001d77@wsncexc001.silkroadtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e12e59640511020830q18817c3dsb01d3051970baf9f@mail.gmail.com>
	 <WSNCEXC0010dSHpVyLr00001d77@wsncexc001.silkroadtech.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear Remmolt,

I do not quite understand your reply. Do you mean the space in a
playload is too precious to insert in any other information?

I know the contents of a payload. Now that a local MAC label is
already added in current implementation, why will an "optional" remote
label cause significant problems? If one desires not to request a
expected label, the responder just chooses a default one for him as in
current way.

In fact, I think it's a cheap method comparing to in which a client
must prepare different payloads to meet the requirement of his
expected label in the server side (he then must know more details
about the IPSec policy configuration of the server), or modifying each
application protocol and server individually.

Thanks!

Wei

On 11/3/05, Remmolt Zwartsenberg <remmolt.zwartsenberg@silkroadtech.com> wrote:
>
> You need to backtrack to the bowels of the origin of the TCP/IP protocol!
>
> A payload inside an IP packet can get as small as a datagram...
>
> The datagram may be a very significant public or private key in a 2, 3 or 4
> way constellation.
>
> Of course the protocol is important, but equally so are the peers behind
> the  handshakes.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
