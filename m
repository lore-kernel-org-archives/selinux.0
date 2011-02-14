Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1EGxLee007414
	for <selinux@tycho.nsa.gov>; Mon, 14 Feb 2011 11:59:21 -0500
Received: from g4t0015.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1EGxKM9001016
	for <selinux@tycho.nsa.gov>; Mon, 14 Feb 2011 16:59:20 GMT
Subject: Re: [PATCHSET RFC] selinux: rework labeled IPsec networking
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214131651.GA15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 14 Feb 2011 11:59:17 -0500
Message-ID: <1297702757.5470.3.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:16 +0100, Steffen Klassert wrote:
> This patchset attempts to fix some problems I faced when I tried to use
> labeled IPsec and secmark. In particular, packet forwarding with labeled
> IPsec did not behave as I expected. I know, labeled IPsec was not designed
> to do packet forwarding in the first place, but it's possible to use it
> to secure packet forwarding too. I marked the patchset as RFC because
> I'd like to get some feedback before I continue to work on this.
> 
> There is one issue on packet forwarding with labeled IPsec for which I
> found no easy solution. If we receive IPsec encrypted packets via some
> interface and want to forward it decrypted via some other interface, we
> can (and we do) check in the postrouting hook if the SA that decrypted the
> packet is allowed to talk to the sending interface. We can do this because
> we have the secpath of the decryption. The other way arround, If we receive
> plain IP packets via some interface and want to forward it, IPsec encrypted
> via some other interface, we can't do this check because we have no secpath
> in this case. The only solution I see here, is to implement a secpath for
> outbound IPsec packets. The secpath pointer in the skb is free in this case,
> so would be possible. But that's a bigger task and I don't want to start
> with something like that before I'm getting feedback on all of this.
> 
> The patchset is also availabe at branch 'selinux-networking' of
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/klassert/linux-2.6-stk.git

Hi Steffen,

Thanks for the patches, I'm going to try and review them sometime today
or tomorrow (probably in a few different chunks).  

For future reference, it was good that you sent these to the LSM list,
but you should probably also include the SELinux list (CC'd) on patches
that are SELinux specific (as I believe all of these are).

 * http://www.nsa.gov/research/selinux/subscribe.shtml

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
