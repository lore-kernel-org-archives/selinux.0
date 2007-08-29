Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7TF7vOv007516
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 11:07:57 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7TF7tn2008397
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 15:07:56 GMT
Message-ID: <D709A20F2164C84E8B7014B0301F5EF8521568@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, Joshua Brindle
	 <method@manicmethod.com>
Cc: Joe Nall <joe@nall.com>, Darrel Goeddel <sedgoeddel@gmail.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        Eric Paris
	 <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Wed, 29 Aug 2007 11:07:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Very well said. This should make for a nice chapter/section in SELinux by
Example.

> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Wednesday, August 29, 2007 9:56 AM
> To: Joshua Brindle
> Cc: Joe Nall; Darrel Goeddel; Venkat Yekkirala; selinux@tycho.nsa.gov;
> James Morris; Darrel Goeddel; Stephen Smalley; kaigai@ak.jp.nec.com;
> Eric Paris
> Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
> 
> 
> On Wednesday, August 29 2007 10:26:55 am Joshua Brindle wrote:
> > Paul Moore wrote:
> > > On Wednesday, August 29 2007 12:11:14 am Joshua Brindle wrote:
> > >> Because of
> > >> what I said above I think we should 1) not do node based 
> fallbacks and
> > >> 2) not do nic alias-level fallbacks. This is the safe 
> option (as already
> > >> pointed out) and minimizes trust in untrustworthy things 
> (eg., addresses
> > >> coming from the network).
> > >>
> > >> OTOH it may make some peoples lives easier to allow 
> this. It is a false
> > >> sense of security though so I vote for doing nic level 
> fallbacks only
> > >> and if someone *really* wants to do this they can just 
> plug several nics
> > >> into the same network (hopefully they'd recognize the 
> horrible things
> > >> they are doing if it is explicit like that).
> > >>
> > >> It sounds like the decision is still up in the air 
> though, does anyone
> > >> inherently disagree with me here?
> > >
> > > I guess every decision is technically up in the air until the
> > > changes/patches are included in a released kernel, 
> however, I'm pretty
> > > confident that host level granularity of both fallback 
> labels and flow
> > > control peer label filtering is "the right thing".
> > >
> > > I understand your point about not extending trust beyond 
> the level of the
> > > physical wire, that is very easy to 
> rationalize/understand.  However,
> > > from a practical real-world scenario (see my home network 
> behind a NAT
> > > box example, as well as others) I think there is real 
> value in extending
> > > the labeling beyond the wire to the host/network level.  
> SELinux has
> > > always made some allowances to facilitate adoption and 
> ease of use, i.e.
> > > unconfined_t, but has been careful to make sure that 
> these concessions
> > > were always at the discretion of the system 
> administrator.  Fallback
> > > labeling and peer flow controls are configuration options 
> which are only
> > > available to the system administrator and providing host level
> > > granularity can be a significant benefit to a lot of people.
> >
> > concessions are fine when the ramifications are understood, 
> unconfined_t
> > is pretty obvious.
> 
> I tend to think host level fallback labels are pretty obvious 
> too, at least as 
> obvious as unconfined_t if not more so.  The only way to 
> truly understand the 
> ramifications of unconfined_t are to actually look at the 
> policy and examine 
> all of the interactions between unconfined_t and all of the 
> types/attributes 
> defined in policy.  Short circuiting this by making an 
> assumption based on 
> the connotative meaning of the name "unconfined" is just as 
> dangerous, if not 
> more so in my opinion, then host level fallbacks.  Explaining the 
> ramifications of host level fallback labels are pretty 
> simple, here is my 
> quick take:
> 
>  "Choosing to enable multiple fallback labels per interface, i.e.
>   network or host level fallbacks, can be dangerous as it is possible
>   for malicious computers to masquerade as other computers with a
>   different fallback label.  Only use network or host level fallback
>   labels when you can guarantee the security of the network."
> 
> > But when there are security people that believe host 
> > based labeling buys anything then it may be an 
> inappropriate concession.
> 
> I think the key difference between the two sides here is the 
> acceptable level 
> or risk, or the level of assurance.  From what I gather, Joe 
> and the TCS guys 
> are deploying systems in installations where they are able to 
> put a fair 
> amount of trust in the network such that host level fallback 
> labels do not 
> introduce an unacceptable amount of risk.  Your argument 
> assumes a network 
> with no trust where host level fallback labels present a very 
> unacceptable 
> risk.
> 
> Both arguments are correct, the question is what level of 
> functionality do we 
> want to provide?
> 
> > I mean, if I can get on your network and in a matter of seconds take
> > over both your IP and MAC address it isn't good. Worse, I could use
> > something like ettercap and MiM you without you even 
> knowing (and even
> > inject data into the stream).
> 
> Yep, I think we're all familiar with ARP cache poisoning and 
> all the other 
> wonderful things you can do the network.
> 
> > The last email from Joe shows that even security centric 
> people are fine
> > with this situation in a 'medium assurance' environment, if medium
> > assurance means trivially bypassable please count me out. A single 
> > shared network is in no way medium assurance IMO, there is 
> no inherent
> > security when you are on a single network (save for fancy 
> switches that
> > do mac filtering and ip locking per port, how many people 
> actually use
> > those features though).
> 
> I'm making this argument up a bit as I go, so bear with me ...
> 
> You essentially define a network by the machines connected to 
> it, which means 
> that if you can control the machines on that network then you 
> effectively 
> control the network.  Joe is arguing the case for 
> installations where he does 
> control all of the machines on the network.
> 
> > One interesting thing that just occurred to me is vlans. 
> I'm not sure
> > how vlans are implemented on Linux (do they get their own interface
> > names?) but they are much better than the alternative which 
> lets anyone
> > do anything on a single network.
> 
> Like everything else I think this depends on the 
> configuration.  If you have 
> multiple vlans on a single wire and unknown machines on that 
> wire than vlan 
> separation is no different from IP address separation.
> 
> -- 
> paul moore
> linux security @ hp
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
