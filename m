Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBJLjikj026839
 for <selinux@tycho.nsa.gov>; Thu, 19 Dec 2013 16:45:44 -0500
From: Paul Moore <pmoore@redhat.com>
To: Andy Ruch <adruch2002@yahoo.com>
Subject: Re: selinux control for network interface using SOCK_RAW
Date: Thu, 19 Dec 2013 16:45:19 -0500
Message-ID: <1600831.ZeRduynSxN@sifl>
In-Reply-To: <1387486120.26231.YahooMailNeo@web163402.mail.gq1.yahoo.com>
References: <1387381759.80678.YahooMailNeo@web163404.mail.gq1.yahoo.com>
 <1762865.mJVkh9reke@sifl>
 <1387486120.26231.YahooMailNeo@web163402.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, December 19, 2013 12:48:40 PM Andy Ruch wrote:
> I considered what you said about the capability not being
> available to restrict the AF_PACKET traffic on a per interface basis. It led
> me to investigate my selinux policy further beyond just my application. I
> saw that several applications had the ability to use AF_PACKET sockets,
> including applications like virtd, xen, dnsmasq, ping, traceroute, and
> more. My system also runs virtual machines so I grew more concerned that
> I’m not able to restrict virtd’s network access if it were compromised.
>  
> You described the fix as adding a new LSM hook and SELinux glue. How
> difficult would this be to add?

Off the top of my head, it would require the following at a minimum:

* LSM hooks in the AF_PACKET code to perform access control before the packet 
is handed off to the network device layer, see "net/packet/af_packet.c".

* SELinux/LSM glue code to implement the SELinux access controls for the 
outbound AF_PACKET traffic, see "selinux_ip_postroute()".  I think the only 
outbound access control that makes sense in this case would be the 
netif:egress control, although there may be some use for secmark, I just 
haven't thought much about secmark in a non-IP case.

* Check to ensure that inbound AF_PACKET traffic ends up going through the 
socket filter code and hitting the security_sock_rcv_skb() LSM hook, if not, 
an additional LSM hook would be needed in the AF_PACKET code to deal with 
inbound traffic.

* SELinux/LSM glue code to implement the SELinux access controls for the 
outbound AF_PACKET traffic, see "selinux_socket_sock_rcv_skb()".  Similar to 
the outbound access control, I believe netif:ingress is the key control with a 
possibility for secmark as well.

* Add a new SELinux policy capability ("selinux_policycap_packet"?) to 
enable/disable all of the new controls listed above.

Policy wise, I don't think there would be any extra work required as we would 
be reusing the existing network ingress/egress controls and doing so in such a 
way that preserves their intent.  If anything, I think the changes would be 
more in line with what the policy author originally intended.

I'm somewhat interested in this now, if you're not going to follow-up on this 
with any patches please let me know and I'll toss is on my todo pile, but be 
warned, the pile is tall and gets taller with each passing day :)

> And if it was fixed, what would be the process for getting it released into
> RHEL 6?

That is something that is best discussed with your RH support contact and not 
with the SELinux community at large.  Feel free to contact me off list if 
needed.

-- 
paul moore
security and virtualization @ redhat
