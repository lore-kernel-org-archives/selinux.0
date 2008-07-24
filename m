Date: Thu, 24 Jul 2008 23:28:18 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming, part
 3
In-Reply-To: <Pine.LNX.4.64L.0807210220280.8567@ruuvi.it.helsinki.fi>
Message-ID: <Xine.LNX.4.64.0807242320060.8246@us.intercode.com.au>
References: <Pine.LNX.4.64L.0807210220280.8567@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 Jul 2008, Vesa-Matti J Kari wrote:

> Hello,
> 
> Once again, renamed iterators "idx" to "i", to be in harmony
> with the old unwritten C convention, and with the rest of the code.
> 
> Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

I'm not applying these variable renaming patches, as they peturb the code 
for no established benefit.

I suggest reading the following carefully on how to submit patches:
http://www.zipworld.com.au/~akpm/linux/patches/stuff/tpp.txt

It's also generally best to simply use git to create patches (e.g. via 
git-format-patch).


Something that would be particularly useful at this stage would be to see 
if you can reproduce a long delay in booting the current git tree possibly 
related to SELinux policy loading:

[    6.904650] EXT3-fs: mounted filesystem with ordered data mode.
[    7.076411] type=1404 audit(1216904882.076:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[   59.445985] SELinux: 8192 avtab hash slots, 1815416 rules.
[   60.812559] SELinux: 8192 avtab hash slots, 1979772 rules.

And if so, track down what's causing it.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
