Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PFh6gA023850
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 11:43:06 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PFb0AP021100
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 15:37:00 GMT
Message-ID: <42E50756.5030302@redhat.com>
Date: Mon, 25 Jul 2005 11:37:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Casey Schaufler <casey@schaufler-ca.com>, gyurdiev@redhat.com,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com> <Lynx.SEL.4.62.0507250019380.21934@thoron.boston.redhat.com>
In-Reply-To: <Lynx.SEL.4.62.0507250019380.21934@thoron.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With the current way that policy is written all devices get the 
netif_type by default.  This type is then only used in the can_network 
macros. 

define(`base_can_network',`
...
#
# Allow the domain to send or receive using any network interface.
# netif_type is a type attribute for all network interface types.
#
allow $1 netif_type:netif { $2_send rawip_send };
allow $1 netif_type:netif { $2_recv rawip_recv };
...


Since we would want to take this ability away from a specific device, we 
would need some kind of
boolean or tunable to take away the netif_type for say the ethernet 
device.   I could envision something
like the following

in types/network.te

define(`network_device_domain', `
type netif_$1_t;
boolean allow_$1_all_communication true;
if (allow_$1_all_communication) {
typeattribute netif_$1_t netif_type;
}
')

Of course you can wrap typeattributes in booleans yet, so this would 
have to be enhanced.
Then the user or iptables would have to add the appropriate rules for 
the selinux domain

define(`can_nitif_communicate', `
allow $1_t netif_$2_t:netif { $3_send rawip_send };
allow $1_t netif_$2_t:netif { $3_recv rawip_recv };
')
can_netif_communicate(httpd_t, eth0, tcp)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
