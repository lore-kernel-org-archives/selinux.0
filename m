Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9RCjuq7000409
	for <selinux@tycho.nsa.gov>; Tue, 27 Oct 2009 08:45:56 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n9RClk6P005511
	for <selinux@tycho.nsa.gov>; Tue, 27 Oct 2009 12:47:46 GMT
Subject: Re: Where do I get a good Policy Base ?...
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Dominick Grift <domg472@gmail.com>
Cc: Hasan Rezaul-CHR010 <CHR010@motorola.com>, selinux@tycho.nsa.gov
In-Reply-To: <1256633374.3090.13.camel@localhost>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
	 <4AD9AD06.9030309@redhat.com>
	 <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com>
	 <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com>
	 <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com>
	 <1256037508.4061.3.camel@moss-pluto.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D077A087F@de01exm68.ds.mot.com>
	 <1256633374.3090.13.camel@localhost>
Content-Type: text/plain
Date: Tue, 27 Oct 2009 08:45:15 -0400
Message-Id: <1256647515.6392.18.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-10-27 at 09:49 +0100, Dominick Grift wrote:
> On Mon, 2009-10-26 at 21:16 -0400, Hasan Rezaul-CHR010 wrote:
> > Hi All,
> > 
> > I used to have the following SELinux related package versions on my
> > Linux (2.6.18) system:
[...]
> > And I used a 'strict' Base policy from Fedora Core 6. Made the
> > modifications I needed on top of that, and I was very happy...
> > 
> > 
> > We get our OS packaged/delivered from a third party company, and we're
> > upgrading to Linux 2.6.27, and as part of this upgrade, we are also
> > migrating to much newer versions of the SELinux packages. They are:
[...]
> > My questions are:
> > 
> > 1. I believe the "strict" policy is no longer supported in the above
> > versions of SELinux packages? Is this true ?
> 
> the "strict" policy model is no longer supported. The strict and target
> policy have merged to a policy model that is called "targeted".

No, it doesn't have a specific name.  However, for ease of discussion, a
system with all confined domains is still referred to as "strict",
otherwise its "targeted".


> > 2. The entire set of policies that I have fine-tuned over the years
> > under my  /etc/selinux/strict/modules/active/modules/*.pp  directory in
> > my previous older system, can I make any use of that ?? In other words,
> > can that stuff be re-used at all ? Or do I need to develop policy from
> > scratch again ?
> 
> I am not sure about this but my opinion is that it should  in most cases
> be possible to use older binary modules in newer policy. Reference
> policy should be compatible in my view.

We try hard to maintain compatibility, but FC6 is several years old, so
compatibility may have been broken, especially after the 2.x API break
for UBAC.


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
