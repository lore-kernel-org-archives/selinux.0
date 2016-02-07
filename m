Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u17JuP3h022105
 for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2016 14:56:25 -0500
From: Paul Moore <pmoore@redhat.com>
To: Huw Davies <huw@codeweavers.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v2 00/18] CALIPSO Implementation
Date: Sun, 07 Feb 2016 14:56:18 -0500
Message-ID: <2084590.x0rrIneakS@sifl>
In-Reply-To: <1452246774-13241-1-git-send-email-huw@codeweavers.com>
References: <1452246774-13241-1-git-send-email-huw@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, January 08, 2016 09:52:36 AM Huw Davies wrote:
> This patch series implements RFC 5570 - Common Architecture Label IPv6
> Security Option (CALIPSO).  Its goal is to set MLS sensitivity labels
> on IPv6 packets using a hop-by-hop option.  CALIPSO is very similar to
> its IPv4 cousin CIPSO and much of this series is based on that code.
> 
> I'm particularly interested in feedback relating to adding
> struct ipv6_txoptions* to struct inet_request_sock.
> (ipv6: Allow request socks to contain IPv6 options.)
> 
> Thoughts about this or any of the other patches are most welcome.
> 
> If anybody actually wants to play with this, then you'll need some patches
> to netlabel-tools that are currently available on the 'calipso' branch at:
> https://github.com/hdmdavies/netlabel_tools.git
> 
> Thanks to Paul Moore, Hannes Frederic Sowa and Casey Schaufler for their
> comments so far.
> 
> Changes between v2 and v1:
> 
> * Simplify ipv6_renew_options_kern() to use set_fs(KERNEL_DS).
>   Thanks to Hannes Frederic Sowa for suggesting this.
> 
> * Use the parent socket to account for the listener socket
>   option's memory usage.  Again, thanks for Hannes for this.
> 
> * Added netlbl_cfg_calipso_* functions for SMACK.
> 
> * Rebased to v4.4-rc8.

Thanks for fixing this patchset up and sending out a v2.  I took a closer look 
and just sent out my comments, let me know if you have any questions.

Once we get to a v3 patchset, I think it's time to reach out Oracle and try 
some interop with Solaris TX.  Let me know when you are ready and I'll put 
everybody in touch to try to get some testing going.

-- 
paul moore
security @ redhat
