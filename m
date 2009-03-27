Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RMaJte012668
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 18:36:19 -0400
Received: from sca-ea-mail-3.sun.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RMaIfp017757
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 22:36:18 GMT
Received: from dm-central-02.central.sun.com ([129.147.62.5])
	by sca-ea-mail-3.sun.com (8.13.6+Sun/8.12.9) with ESMTP id n2RMaFdP002294
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 22:36:15 GMT
Received: from binky.Central.Sun.COM (binky.Central.Sun.COM [129.153.128.104])
	by dm-central-02.central.sun.com (8.13.8+Sun/8.13.8/ENSMAIL,v2.2) with ESMTP id n2RMaF5J064423
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 16:36:15 -0600 (MDT)
Date: Fri, 27 Mar 2009 17:04:24 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090327220423.GB9992@Sun.COM>
References: <20090325163317.GV9992@Sun.COM> <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM> <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49CD2169.3080209@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 27, 2009 at 11:56:41AM -0700, Jarrett Lu wrote:
> I don't yet see a good way to solve this problem using bits on the wire. 
> The agreement on what label encodings or security policy to use seems 
> better solved in an out of band manner. For example, on a (secure) 
> website, you can say "download this label encoding file or configure 
> your MAC system with this policy and use DOI number 5. Then we can talk".

Well, you could use a PKIX certificate extension, or a Kebreros V ticket
authorization-data and ticket extension to point to the actual DOI
rules.

But the simplest thing, given that most nodes will participate in a
single DOI, is to configure this when the node joins the network (when
it gets whatever credentials it needs).  In practice this is exactly
what happens -- out of band delivery of what Solaris TX calls "label
encodings."

> BTW, CALIPSO with IP module has the same issue. While the spec talks a 
> lot about how a CALIPSO  system should behave, CALIPSO can't tell its 
> peers to use a particular label encoding. That's done outside CALIPSO.

BTW, you're using the Solaris TX meaning of "label encoding" but CALIPSO
uses the term "encoding" in a very different way (or two: one in
relation to how to represent releasability, and the other for actual
bits on the wire).  We should be careful to use terminology that we all
understand.  What you've been calling "label encoding" CALIPSO calls, I
think, "a particular set of policies which define the Sensitivity Levels
and Compartments present within the DOI, and by inference, to the "real
world" (e.g. used on paper documents) equivalent labels" -- very wordy,
that!

> I believe it's still worthwhile to request adding a DOI + an opaque 
> field in NFSv4 protocol. The spec should be clear that other 
> arrangements need to be made before interoperability can take place.

I agree.  I believe that negotiation of the "particular set of policies
which..." is something that belongs in the authentication facilities, or
else out of band -- either way that is completely outside the scope of
this document (and even the RPCSEC_GSSv3 document).

> CALIPSO spec has considerations in how routers can support DOI and MLS 
> labels. I don't believe that affects or harms NFSv4 in anyway, as 
> routers won't look at NFSv4 stuff.

Indeed.  What CALIPSO does though, is require that end-points select
packet labels that dominate the labels of the data being sent.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
