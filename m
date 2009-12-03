From: Paul Moore <paul.moore@hp.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH] Dynamic port labeling V2
Date: Thu, 3 Dec 2009 17:43:42 -0500
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>, russell@coker.com.au,
        selinux@tycho.nsa.gov, LSM <linux-security-module@vger.kernel.org>
References: <1259616460.2444.9.camel@moss-stripedbass.epoch.ncsc.mil> <4B173283.30601@schaufler-ca.com> <1259856069.8497.56.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1259856069.8497.56.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200912031743.42195.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 03 December 2009 11:01:09 am David P. Quigley wrote:
> On Wed, 2009-12-02 at 19:37 -0800, Casey Schaufler wrote:
> > Now I'm glad the notion has been considered, and I can understand
> > if it seems like too much work or if you just don't see it as a good
> > idea.
> >
> > How about making it a part of the labeled networking code then?
> > That would seem to be a more focused approach that would also,
> > and perhaps better, address the generality concern.
> 
> I'd consider talking to Paul Moore about it and getting his input then
> as I'm just a filesystem guy :)

Okay, I stopped following this thread closely several messages ago but I saw 
"labeled networking" then my name so I figured I should probably say something 
constructive :) [NOTE: I did actually review the first set of patches to 
ensure they flushed the SELinux port caches, which they did - good job]

Anyway, I digress ... labeling network ports isn't really labeled networking 
in the sense that labeled networking tends to be about communicating security 
label information across the network.  While I won't close the door on this 
completely, I will say that someone is going to have to make a very persuasive 
argument as to why port labeling belongs in the labeled networking code ... 
and also preferably how you would establish a LSM agnostic method of labeling 
ports.

Good luck with that last bit :) 

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
