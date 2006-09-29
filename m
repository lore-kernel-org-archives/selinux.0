Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TJX5pN000774
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 15:33:05 -0400
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TJWVu8008670
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 19:32:31 GMT
Date: Fri, 29 Sep 2006 15:33:02 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@gentoo.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
In-Reply-To: <451D6EB1.3040006@hp.com>
Message-ID: <Pine.LNX.4.64.0609291517170.7975@d.namei>
References: <36282A1733C57546BE392885C0618592015CF2BE@chaos.tcs.tcs-sec.com>
 <451D4A51.4000603@hp.com> <Pine.LNX.4.64.0609291247170.6007@d.namei>
 <451D5B3F.70206@hp.com> <Pine.LNX.4.64.0609291430130.7553@d.namei>
 <451D6EB1.3040006@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Sep 2006, Paul Moore wrote:

> > Say that the SA is labeled "secret" and you have two FTP clients 
> > connecting to a server via xinetd on this SA.  Each client additionally 
> > labels their packets via CIPSO as secret:c1 and secret:c2 respectively.  
> > xinetd launches an FTP server for each at the correct level.
> 
> I believe Venkat can address this.

Ok, I'd still really like to see a worked example of just Netlabel + 
secmark/connseckmark, to see what happens to the connection marks.  It 
seems that the connection mark should always be correct, and restored to 
the packet.  In which case, what happens when a CIPSO label on an 
established or related packet doesn't match, or you get no CIPSO label 
(e.g. ICMP from intermediate router) ?  Or, is would you be always 
overwriting secmark/connsecmark labeling, and if so, how/why are you using 
them?

Venkat,

With xfrm labeling, the external packets are always going to be protocol 
ESP or AH, and we can't connection track the inner protocols.  So, 
external labeling when using xfrm labeling seems somewhat superfluous, 
except for the case of setting a label based on the interface the packets 
arrived on.  Correct?  If so, all you can realistically do with the flow 
permissions is bind the ESP/AH packets to types of interfaces (which does 
seem useful for some folk).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
