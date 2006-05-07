Message-ID: <445E288B.4040908@gentoo.org>
Date: Sun, 07 May 2006 13:04:11 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        netfilter-devel@lists.samba.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC] SECMARK 1.0
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
In-Reply-To: <Pine.LNX.4.64.0605071104590.8588@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> For example, SELinux will now be able to utilize connection tracking, so 
> that only packets which are known to be valid for a specific connection 
> will be allowed to reach the subject.
>
> Sample iptables rules for labeling packets are at:
> http://people.redhat.com/jmorris/selinux/secmark/rules/
>
> And examples of new policy controls may be found here:
> http://people.redhat.com/jmorris/selinux/secmark/policy/
>   
It looks like you are labeling all packets on an established connection 
as tracked_packet_t. What is the rationale for not labeling all ftp 
traffic as ftpd_packet_t? Granted that its very unlikely for established 
connections to go to the wrong process but the SELinux policy should be 
able to clearly show that ftpd and sshd cannot see each others packets 
but these policies say that they can both send/receive tracked_packet_t.

Obviously these are just examples, I'm just curious if there was a 
reason to label established packets differently from the new connection 
packets (and the same as all the other established packets)

I imagine that, at least at first, it would be good to have allow domain 
unlabeled_t:packet { send recv }; in an (enabled) conditional so that 
the migration will be easier.

Also, we need to come up with a mechanism for distributing default 
marking rules that can accompany a policy. The rules could go into a 
section in the .pp file but how does that integrate with various 
firewall systems that take control of the iptables rules?

And finally, what happens if the labeling rule changes during an 
established connection? Do the packets related to that connection retain 
the original label or will they get the new label?

Thanks, this will be very beneficial to the SELinux community

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
