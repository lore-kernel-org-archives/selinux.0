From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: [PATCH] Dynamic port labeling V2
Date: Fri, 4 Dec 2009 11:12:41 +1100
Cc: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        selinux@tycho.nsa.gov, "George S. Coker, II" <gscoker@alpha.ncsc.mil>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
References: <1259616460.2444.9.camel@moss-stripedbass.epoch.ncsc.mil> <4B181228.6080600@manicmethod.com>
In-Reply-To: <4B181228.6080600@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200912041112.56570.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 4 Dec 2009, Joshua Brindle <method@manicmethod.com> wrote:
> Aside from the conversation Dave and Casey are having I still think this
> isn't quite right. First, while you can atomically change a single port
> label with the add command above you can't atomically change multiple
> entries, which I think is completely necessary (you don't want to have
> strange labeling states when changing a set of ports to a new label.

Why is it necessary to change multiple ports at the same time?

We support atomic changes of multiple booleans at the same time due to 
possible interactions between them.  But I don't think that we have any such 
issues with port contexts.

> Also, while having a text parser in the kernel makes it easier to use
> with echo I think it is alot of code in the kernel for no good reason.
> There is no reason not to make a userspace tool that converts the
> textual representation into a serialized struct and feed it to the
> kernel. We typically tell users not to mess around in /selinux anyway,
> since we have a libselinux interface to do that.

It does seem likely that significant code complexity can be avoided by not 
having a plain text interface in this case.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
