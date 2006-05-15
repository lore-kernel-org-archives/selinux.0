Subject: Re: [RFC] SECMARK 1.1
From: Karl MacMillan <kmacmillan@tresys.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        netfilter-devel@lists.netfilter.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, Patrick McHardy <kaber@trash.net>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bleher <bleher@informatik.uni-muenchen.de>
In-Reply-To: <Pine.LNX.4.64.0605140133560.5506@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
	 <Pine.LNX.4.64.0605140133560.5506@d.namei>
Content-Type: text/plain
Date: Mon, 15 May 2006 08:35:55 -0400
Message-Id: <1147696556.22880.100.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-05-14 at 02:03 -0400, James Morris wrote:
> Included below is an incremental patch against the initial secmark posting 
> last week: http://thread.gmane.org/gmane.linux.network/34927/focus=34927
> 
> This posting to gather feedback on changes made since then primarily to 
> address concerns raised by Karl MacMillan on providing fine-grained 
> assurances for network applications which pass connections (e.g. xinetd).
> 
> If all looks ok, I'll rebase the entire patchset (also merging elements 
> from the patch below back into other patches), and submit it for inclusion 
> in 2.6.18.  As it touches a bunch of networking code, it may be best to 
> aim for Dave's tree, although it could also go into -mm.
> 
> Anyway, the way the issue has been addressed is to implement something 
> similar to CONNMARK, but specific to this useage scenario and dealing with 
> security markings instead of network markings.
> 
> In a nutshell:
> 
> 1. A --track option was added to the SECMARK target, which causes the 
>    security mark being applied to the packet to also be applied to a new
>    secmark field on the conntrack (only if it is unmarked).
> 
> 2. A new CONNSECMARK target was added which copies the secmark value to 
>    packets.
> 
> This allows all packets on a connection (or related to it) to be marked 
> with the same security label, so that they can be explicitly 
> differentiated.
> 
> This also turns out to simplify the SELinux policy, while the xtables 
> implementation has been designed to remain as simple as possible (e.g. it 
> only copies lables to packets, and has no options).
> 
> So, here's an example of per-packet network policy for vsftpd with the new 
> code:
> 
>   allow ftpd_t ftpd_packet_t:packet { recv send };
> 
> Assuming it doesn't do DNS lookups, that's it in terms of access control 
> rules for packets.  This covers all established and related packets, 
> including ICMP and the FTP data connetion.
> 

James,

This seems to address my concerns - thanks.

Karl

-- 
Karl MacMillan
Tresys Technology
www.tresys.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
