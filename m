Subject: Re: network packets have become unlabeled_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1145640587.11012.10.camel@localhost>
References: <1145640587.11012.10.camel@localhost>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 14:11:18 -0400
Message-Id: <1145643078.21749.236.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-04-21 at 18:29 +0100, Antoine Martin wrote:
> Hi list,
> 
> Using recent kernels (started around 2.6.16) I can't use the network in
> enforcing mode because all the packets (in and out) are unlabeled.
> ie with ssh:
> audit(1145733148.799:164): avc:  denied  { recvfrom } for
> scontext=system_u:system_r:sshd_t tcontext=system_u:object_r:unlabeled_t
> tclass=association
> 
> audit2allow would like me to add:
> allow mysqld_t unlabeled_t:association { recvfrom sendto };
> allow named_t unlabeled_t:association { recvfrom sendto };
> allow sshd_t unlabeled_t:association { recvfrom sendto };
> (and so on)
> 
> Where is this coming from? Have I missed an option for labeling network
> interfaces? If so, where? SECURITY_NETWORK is set.
> 
> I have done make clean; make reload;
> policy.conf does contain things like:
> type ssh_port_t, port_type, reserved_port_type;
> 
> I'm stuck.

The integration with IPSEC to support implicit labeling of packets based
on security association introduced new checks on sending and receiving
of packets so that you can e.g. prohibit sending/receiving of unlabeled
traffic.  Newer policies include rules to allow this.

Your other option is to disable the CONFIG_SECURITY_NETWORK_XFRM option
in your kernel config, to disable that processing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
