Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1E1l2S7018271
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 20:47:03 -0500
Received: from dmzmta103.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1E1kf5h018528
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 01:47:01 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1E1jX9O022538
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 20:45:33 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1E1jEFA004473
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 20:45:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: CORBA and network labeling capabilities
Date: Wed, 13 Feb 2008 17:45:50 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02AF95E6@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF94F9@blums0008.bluelnk.net> <200802130847.21044.paul.moore@hp.com> <FB39F4E77226B448BC1388D3BE4E00CD02AF9597@blums0008.bluelnk.net> <200802131632.05679.paul.moore@hp.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Paul Moore" <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul,

Thanks for your help. I've got labeled IPSec working on the loopback
interface. I've still got some policy work to do to get everything
working like I want, but the labeled IPSec portion appears to be
working.

The key was enabling XFRM as you mentioned below and updating my setkey
commands as follows:

spdflush;
flush;
spdadd 127.0.0.1 127.0.0.1 any
-ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s4:c0.c255"
-P in ipsec esp/transport//require;
spdadd 127.0.0.1 127.0.0.1 any
-ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s4:c0.c255"
-P out ipsec esp/transport//require;

The key differences are using 127.0.0.1 for both the src and dest
addresses, and using "any" for the upperspec.


> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Wednesday, February 13, 2008 1:32 PM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: CORBA and network labeling capabilities
> 
> On Wednesday 13 February 2008 3:37:26 pm Clarkson, Mike R (US SSA)
> wrote:
> > Thanks for your response. I do need the full TE information, so I
> > tried to set up labeled IPSec over localhost/loopback. Have you done
> > this before?
> 
> Yes, but I can't say I recommend it.  It's painful but if you need the
> full SELinux context it's your only option at present.
> 
> > I'm an IPSec novice. I'm trying to set up IPSec in transport mode,
> > using raccoon to set up the SAs, but I don't seem to be getting SAs.
> > I'm not sure why.
> 
> The first thing that jumps to mind is that XFRM (the Linux IPsec
> implementation) is probably disabled on the loopback device (the
> default setting).  Run the two following commands to enable XFRM over
> loopback:
> 
>  # echo 0 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
>  # echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy
> 
> > Here is my raccoon.conf file and
> > the file that I "setkey -f":
> >
> > raccoon.conf:
> > path pre_shared_key "/root/ipsec/psk.txt";
> > remote anonymous {
> >         exchange_mode main;
> >         proposal {
> >                 encryption_algorithm 3des;
> >                 hash_algorithm md5;
> >                 authentication_method pre_shared_key;
> >                 dh_group modp1024;
> >         }
> > }
> > sainfo address 25.25.25.25 any address 127.0.0.1 any {
> >         pfs_group modp768;
> >         encryption_algorithm 3des;
> >         authentication_algorithm hmac_md5;
> >         compression_algorithm deflate;
> > }
> > sainfo address 127.0.0.1 any address 25.25.25.25 any {
> >         pfs_group modp768;
> >         encryption_algorithm 3des;
> >         authentication_algorithm hmac_md5;
> >         compression_algorithm deflate;
> > }
> 
> Nothing looks wrong, but it's been a while since I have configured
used
> IPsec so I'm probably not the best syntax checker.  However, I'm
> attached a sample racoon.conf file that is part of the audit-test
> suite* that was used for the HP LSPP evaluation which made use of
IPsec
> over loopback.
> 
>  * http://sourceforge.net/projects/audit-test
> 
> > Setkey commands:
> > spdflush;
> > flush;
> > spdadd 127.0.0.1 25.25.25.25 ip4
> > -ctx 1 1 "system_u:object_r:default_t:s0"
> > -P in ipsec esp/transport//require;
> > spdadd 25.25.25.25 127.0.0.1 ip4
> > -ctx 1 1 "system_u:object_r:default_t:s0"
> > -P out ipsec esp/transport//require;
> >
> > Do you see errors?
> 
> I'm not sure your spdadd lines are correct, as an example here are two
> lines that I've used in the past for a TCP server running
> on %REMOTE_IPV4% on port 5300.
> 
> spdadd %LOCAL_IPV4% %REMOTE_IPV4%[5300] tcp
>         -ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023"
>         -P out ipsec ah/transport//require;
> spdadd %REMOTE_IPV4%[5300] %LOCAL_IPV4% tcp
>         -ctx 1 1 "system_u:object_r:ipsec_spd_t:s0-s15:c0.c1023"
>         -P in ipsec ah/transport//require;
> 
> The main difference is the "tcp" instead of "ip4", but that doesn't
mean
> what you have it wrong.  When in doubt check the audit log for AVC
> denials and the racoon debugging output.  If you run across something
> interesting send me some mail to the list and we can probably help you
> figure it out.
> 
> --
> paul moore
> linux security @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
