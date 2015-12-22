Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBMGxXmT001309
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 11:59:36 -0500
Date: Tue, 22 Dec 2015 16:59:19 +0000
From: Huw Davies <huw@codeweavers.com>
To: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, Paul Moore <pmoore@redhat.com>
Subject: Re: [RFC PATCH 16/17] calipso: Add validation of CALIPSO option.
Message-ID: <20151222165919.GA31791@merlot>
References: <1450784813-18304-17-git-send-email-huw@codeweavers.com>
 <5679551C.4000105@stressinduktion.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5679551C.4000105@stressinduktion.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 22, 2015 at 02:50:20PM +0100, Hannes Frederic Sowa wrote:
> On 22.12.2015 12:46, Huw Davies wrote:
> >  
> > +/* CALIPSO RFC 5570 */
> > +
> > +static bool ipv6_hop_calipso(struct sk_buff *skb, int optoff)
> > +{
> > +	const unsigned char *nh = skb_network_header(skb);
> > +
> > +	if (nh[optoff + 1] < 8)
> > +		goto drop;
> > +
> > +	if (nh[optoff + 6] * 4 + 8 > nh[optoff + 1])
> > +		goto drop;
> > +
> > +	if (!calipso_validate(skb, nh + optoff))
> > +		goto drop;
> > +
> > +	return true;
> > +
> > +drop:
> > +	kfree_skb(skb);
> > +	return false;
> > +}
> > +
> 
> Formally, if an extension header could not be processed, the packet
> should be discarded and an icmp error parameter extension should be
> send. I think we shouldn't let those packets pass here.

Thanks for your comments Hannes, I'm looking into your other
suggestions.

I'm confused about this one.  AFAICS, this will drop packets that we
can't process.  We don't send the icmp error, but I can certainly add
that.  Is that what you mean?

Thanks,
Huw.
