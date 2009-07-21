Subject: Re: mmap_min_addr and your local LSM (ok, just SELinux)
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, spender@grsecurity.net,
        Daniel J Walsh <dwalsh@redhat.com>, cl@linux-foundation.org,
        Arjan van de Ven <arjan@infradead.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, kees@outflux.net
In-Reply-To: <alpine.LRH.2.00.0907211258110.32400@tundra.namei.org>
References: <1248132223.2654.278.camel@localhost>
	 <alpine.LRH.2.00.0907211258110.32400@tundra.namei.org>
Content-Type: text/plain
Date: Tue, 21 Jul 2009 10:44:42 -0400
Message-Id: <1248187482.19456.90.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-21 at 13:45 +1000, James Morris wrote:
> I strongly believe that we need to maintain the principle, in SELinux and 
> LSM generally, that the interface is restrictive, i.e. that it can only 
> further restrict access.  It should be impossible, from a design point of 
> view at least, for any LSM module to authorize more privilege than 
> standard DAC.  This has always been a specific design goal of LSM.  (The 
> capability module is an exception, as it has a fixed security policy and 
> implements legacy DAC behavior; there's no way to "fix" this).
> 
> In this case, we're not dealing with a standard form of access control, 
> where access to a userland object is being mediated.  We're trying to 
> mediate the ability of a subject to bypass a separate mechanism which aims 
> to protect the kernel itself from attack via a more fundamental system 
> flaw.  The LSM module didn't create that vulnerability directly, but it 
> must not allow the vulnerability to be more easily exploited.
> 
> The security policy writer should have a guarantee that the worst mistake 
> they can make is to mess up their own security model; if they can mess up 
> the base DAC security with MAC policy, we break that guarantee.  There's 
> also an issue of user confidence in the LSM modules, in that they should 
> not be any worse off security-wise if they enable an enhanced protection 
> mechanism.

Agreed.  That guarantee has been stated from the very beginning for
SELinux; we shouldn't move away from it.  Are there other places where
having an LSM weakens security by default?

At least in this case, the guarantee was broke because it was desired to
provide a stronger default.  Eric could have made the default be no
protection at all.

Looking at the thread for the original patch at
http://marc.info/?l=selinux&m=118056208425164&w=4
Steve suggested that the sysctl could be controlled in SELinux by
labeling it.  I am guessing that a new class and permission was created
so that there could be finer-grained controls?  But if 16 bit wine apps
are all that need this, then do we really need such fine control?

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
