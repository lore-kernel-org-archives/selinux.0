Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u46N7sRA004745
 for <selinux@tycho.nsa.gov>; Fri, 6 May 2016 19:07:54 -0400
Received: by mail-ob0-f169.google.com with SMTP id dm5so59047452obc.1
 for <selinux@tycho.nsa.gov>; Fri, 06 May 2016 16:07:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1455715329-9601-1-git-send-email-huw@codeweavers.com>
References: <1455715329-9601-1-git-send-email-huw@codeweavers.com>
Date: Fri, 6 May 2016 19:07:51 -0400
Message-ID: <CAHC9VhRJSHyJdKUOTG6r3T5sveVh6ACHKpavH=Ke5oO4Fsa+EA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/19] CALIPSO Implementation
From: Paul Moore <paul@paul-moore.com>
To: Huw Davies <huw@codeweavers.com>, netdev@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 17, 2016 at 8:21 AM, Huw Davies <huw@codeweavers.com> wrote:
> This patch series implements RFC 5570 - Common Architecture Label IPv6
> Security Option (CALIPSO).  Its goal is to set MLS sensitivity labels
> on IPv6 packets using a hop-by-hop option.  CALIPSO is very similar to
> its IPv4 cousin CIPSO and much of this series is based on that code.
>
> If anybody actually wants to play with this, then you'll need some patches
> to netlabel-tools that are currently available on the 'calipso' branch at:
> https://github.com/hdmdavies/netlabel_tools.git .  The protocol has changed
> very slightly from the v2 patches, so please update to the latest.
>
> This patch series is based off v4.5-rc4.
>
> Thanks to Paul Moore, Hannes Frederic Sowa, Casey Schaufler and Julia
> Lawall for their comments so far.
>
> Changes between v3 and v2:
>
> * Change CALIPSO_MAP_PASS to 2.
> * Move calipso_init() before ipv6_sysctl_register().
> * Rewrite calipso_tlv_len() to check for overflows.
> * Simplify calispo_opt_find().
> * Simplify calipso_opt_insert().
> * Use calipso_tlv_len() in calipso_sock_getattr().
> * Simplify calipso_skbuff_setattr().
> * Return early from netlbl_domhsh_search_def() when a match is found.
> * Remove nested if from netlbl_domhsh_validate().
> * Don't return from netlbl_domhsh_add() with lock held.
> * Various style changes.
> * Rebased to v4.5-rc4.
>
> Changes between v2 and v1:
>
> * Simplify ipv6_renew_options_kern() to use set_fs(KERNEL_DS).
>   Thanks to Hannes Frederic Sowa for suggesting this.
> * Use the parent socket to account for the listener socket
>   option's memory usage.  Again, thanks for Hannes for this.
> * Added netlbl_cfg_calipso_* functions for SMACK.
> * Rebased to v4.4-rc8.
>
> Huw Davies (19):
>   netlabel: Mark rcu pointers with __rcu.
>   netlabel: Add an address family to domain hash entries.
>   netlabel: Initial support for the CALIPSO netlink protocol.
>   netlabel: Add support for querying a CALIPSO DOI.
>   netlabel: Add support for enumerating the CALIPSO DOI list.
>   netlabel: Add support for creating a CALIPSO protocol domain mapping.
>   netlabel: Add support for removing a CALIPSO DOI.
>   ipv6: Add ipv6_renew_options_kern() that accepts a kernel mem pointer.
>   netlabel: Move bitmap manipulation functions to the NetLabel core.
>   calipso: Set the calipso socket label to match the secattr.
>   netlabel: Prevent setsockopt() from changing the hop-by-hop option.
>   ipv6: Allow request socks to contain IPv6 options.
>   calipso: Allow request sockets to be relabelled by the lsm.
>   ipv6: constify the skb pointer of ipv6_find_tlv().
>   calipso: Allow the lsm to label the skbuff directly.
>   netlabel: Pass a family parameter to netlbl_skbuff_err().
>   calipso: Add validation of CALIPSO option.
>   calipso: Add a label cache.
>   netlabel: Implement CALIPSO config functions for SMACK.

Other than the small nit I just mentioned with respect to CALIPSO
option validation code, this all looks reasonable to me.  I know you
are in the process of doing interop with Solaris TX folks, assuming
that goes well I think we are ready to throw this into linux-next with
an eye towards v4.8.  For the past several weeks I've been including
this patchset in my Fedora COPR test kernels (located below), others
are welcome to try it out if they like.

DaveM, what is your take on this?  I'm happy to get this into
linux-next via the SELinux tree, but it does touch some core network
code (the IPv6 option handling, much in the same way as CIPSO touched
the IPv4 option handling) and I don't want to push this if you aren't
okay with it.  Of course if you want to take this via your tree that's
fine with me too.

-- 
paul moore
www.paul-moore.com
