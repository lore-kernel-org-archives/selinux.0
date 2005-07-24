Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6O5U4gA015863
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2005 01:30:06 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6O5P2gA016989
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2005 05:25:02 GMT
Date: Sun, 24 Jul 2005 01:25:01 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
cc: gyurdiev@redhat.com, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
In-Reply-To: <42E0E706.5050903@redhat.com>
Message-ID: <Lynx.SEL.4.62.0507240048310.16350@thoron.boston.redhat.com>
References: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>
 <1121978850.15334.2.camel@celtics.boston.redhat.com>  <42E00E51.7050001@tresys.com>
  <1121979985.15334.5.camel@celtics.boston.redhat.com>  <42E0105F.9030607@tresys.com>
  <1121981131.15334.13.camel@celtics.boston.redhat.com>  <42E0310B.5070404@tresys.com>
 <1122033206.19625.7.camel@localhost.localdomain> <42E0E706.5050903@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Jul 2005, Daniel J Walsh wrote:

> User has two network devices (Internal and External)  He wants to allow only 
> Apache to listen on the external device, and only communicate via LDAP over 
> the internal device?  How would he set that up?  (IF someone says he will 
> rewrite policy, I will scream, and then ask you to write policy to allow 
> this. )

name_bind allows control over which local IP address type the domain can 
bind to, but not network device.

You can then control which type of netdev the domain sends and receives 
packets over via {udp,tcp,raw}_{send,rcv} in the netif class.

There's also some control over port use (i.e. LDAP) on a per packet basis.

All of these currently require policy modifications.  The per packet 
controls are probably better served via iptables integration as the 
iptables framework is more expressive and has more useful features.  It 
would also not require SELinux policy modification (but iptables updates 
instead).

I'm not sure how to make name_bind user-customizable, or if you really 
need it in this case if packet level controls are doing their job,

> MLS System, wants to have two Apache systems,  One listening at port 80 for 
> Top Secret communications, another at port 81 for secret.  How do you do 
> this?

IPsec is likely the best way to do this, but what you're really asking for 
is more general:

   How do you handle policy for multiple instances of the same software
   running in different domains with different configurations?

Hierarchical & loadable policy modules?

For something as common and complex as Apache, you could have a reference 
policy which is modifiable by some GUI tool which understands the httpd 
config file and also provides abstractions for further user customization, 
and writes out a loadable module and fc file.

> You want to setup a Zone Transfer between your two named servers.  You want 
> to guarantee that named_t on one machine is talking to named_t on another 
> machine over an encrypted line?

IPsec labeling.

> I believe the only way for users to do these things successfully is to have 
> integration of SELinux with iptables, and no writing/rewriting of policy will 
> solve the problem.

iptables integration would only help with the per-packet controls 
mentioned in the first scenario.


- James
-- 
James Morris
<jmorris@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
