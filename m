Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1DLWOpe021252
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 16:32:24 -0500
Received: from g4t0016.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1DLWDSj027445
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 21:32:14 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Subject: Re: CORBA and network labeling capabilities
Date: Wed, 13 Feb 2008 16:32:05 -0500
Cc: selinux@tycho.nsa.gov
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF94F9@blums0008.bluelnk.net> <200802130847.21044.paul.moore@hp.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF9597@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02AF9597@blums0008.bluelnk.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VH2sHIb/EEQ2pmg"
Message-Id: <200802131632.05679.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_VH2sHIb/EEQ2pmg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 13 February 2008 3:37:26 pm Clarkson, Mike R (US SSA) 
wrote:
> Thanks for your response. I do need the full TE information, so I
> tried to set up labeled IPSec over localhost/loopback. Have you done
> this before?

Yes, but I can't say I recommend it.  It's painful but if you need the 
full SELinux context it's your only option at present.

> I'm an IPSec novice. I'm trying to set up IPSec in transport mode,
> using raccoon to set up the SAs, but I don't seem to be getting SAs.
> I'm not sure why.

The first thing that jumps to mind is that XFRM (the Linux IPsec 
implementation) is probably disabled on the loopback device (the 
default setting).  Run the two following commands to enable XFRM over 
loopback:

 # echo 0 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
 # echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy

> Here is my raccoon.conf file and  
> the file that I "setkey -f":
>
> raccoon.conf:
> path pre_shared_key "/root/ipsec/psk.txt";
> remote anonymous {
>         exchange_mode main;
>         proposal {
>                 encryption_algorithm 3des;
>                 hash_algorithm md5;
>                 authentication_method pre_shared_key;
>                 dh_group modp1024;
>         }
> }
> sainfo address 25.25.25.25 any address 127.0.0.1 any {
>         pfs_group modp768;
>         encryption_algorithm 3des;
>         authentication_algorithm hmac_md5;
>         compression_algorithm deflate;
> }
> sainfo address 127.0.0.1 any address 25.25.25.25 any {
>         pfs_group modp768;
>         encryption_algorithm 3des;
>         authentication_algorithm hmac_md5;
>         compression_algorithm deflate;
> }

Nothing looks wrong, but it's been a while since I have configured used 
IPsec so I'm probably not the best syntax checker.  However, I'm 
attached a sample racoon.conf file that is part of the audit-test 
suite* that was used for the HP LSPP evaluation which made use of IPsec 
over loopback.

 * http://sourceforge.net/projects/audit-test

> Setkey commands:
> spdflush;
> flush;
> spdadd 127.0.0.1 25.25.25.25 ip4
> -ctx 1 1 "system_u:object_r:default_t:s0"
> -P in ipsec esp/transport//require;
> spdadd 25.25.25.25 127.0.0.1 ip4
> -ctx 1 1 "system_u:object_r:default_t:s0"
> -P out ipsec esp/transport//require;
>
> Do you see errors?

I'm not sure your spdadd lines are correct, as an example here are two 
lines that I've used in the past for a TCP server running 
on %REMOTE_IPV4% on port 5300.

spdadd %LOCAL_IPV4% %REMOTE_IPV4%[5300] tcp
        -ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023"
        -P out ipsec ah/transport//require;
spdadd %REMOTE_IPV4%[5300] %LOCAL_IPV4% tcp
        -ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023"
        -P in ipsec ah/transport//require;

The main difference is the "tcp" instead of "ip4", but that doesn't mean 
what you have it wrong.  When in doubt check the audit log for AVC 
denials and the racoon debugging output.  If you run across something 
interesting send me some mail to the list and we can probably help you 
figure it out.

-- 
paul moore
linux security @ hp

--Boundary-00=_VH2sHIb/EEQ2pmg
Content-Type: text/plain;
  charset="iso-8859-1";
  name="racoon.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="racoon.conf"

#
# This file contains the IKE configuration for the IPsec subsystem

path include "/etc/racoon";
path pre_shared_key "/etc/racoon/psk.txt";
path certificate "/etc/racoon/certs";

######################################################################
# LSPP Test Configuration
######################################################################

remote anonymous
{
	exchange_mode main,aggressive;
	doi ipsec_doi;
	situation identity_only;

	my_identifier address;

	lifetime time 2 hours;
	initial_contact on;
	proposal_check obey;

	proposal {
		encryption_algorithm 3des;
		hash_algorithm sha1;
		authentication_method pre_shared_key;
		dh_group 2;
        }
}

sainfo anonymous
{
	pfs_group 2;
	lifetime time 1 hour;
	encryption_algorithm 3des, aes;
	authentication_algorithm hmac_sha1;
	compression_algorithm deflate;
}

--Boundary-00=_VH2sHIb/EEQ2pmg--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
