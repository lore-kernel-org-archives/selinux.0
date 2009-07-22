Date: Wed, 22 Jul 2009 20:06:47 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: James Carter <jwcart2@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, spender@grsecurity.net,
        Daniel J Walsh <dwalsh@redhat.com>, cl@linux-foundation.org,
        Arjan van de Ven <arjan@infradead.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, kees@outflux.net,
        Chad Sellers <csellers@tresys.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: mmap_min_addr and your local LSM (ok, just SELinux)
In-Reply-To: <1248187482.19456.90.camel@moss-lions.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.0907221953190.15799@tundra.namei.org>
References: <1248132223.2654.278.camel@localhost>  <alpine.LRH.2.00.0907211258110.32400@tundra.namei.org> <1248187482.19456.90.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Jul 2009, James Carter wrote:

> Agreed.  That guarantee has been stated from the very beginning for
> SELinux; we shouldn't move away from it.  Are there other places where
> having an LSM weakens security by default?

There's a similar form of hook in vm_enough_memory, but the SELinux module 
calls the DAC capability check first, so it seems ok from a policy 
writer's point of view (i.e. worst case is they revert to DAC).



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
