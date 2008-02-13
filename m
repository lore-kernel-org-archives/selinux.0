Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1DKbXoM013721
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 15:37:33 -0500
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1DKbXTp023168
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 20:37:33 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1DKb9s5018453
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 15:37:10 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1DKaqX0021859
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 15:36:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: CORBA and network labeling capabilities
Date: Wed, 13 Feb 2008 12:37:26 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02AF9597@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02AF94F9@blums0008.bluelnk.net> <200802130847.21044.paul.moore@hp.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Paul Moore" <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> 
> Hi Mike,
> 
> If you can live with only MLS label information you can use
NetLabel/CIPSO
> to
> convey security attributes over the network, including
localhost/loopback.
> The problem is that the standard CIPSO protocol doesn't have a way to
> convey
> the SELinux type enforcement information so only the effective MLS
> sensitivity label can be transferred over the network.  Labeled IPsec
does
> work over localhost/loopback but as you can imagine it is not an
elegant
> solution.  Which method you chose largely depends on your
requirements,
> typically the need for full TE information and performance.
> 

Hi Paul,

Thanks for your response. I do need the full TE information, so I tried
to set up labeled IPSec over localhost/loopback. Have you done this
before? I'm an IPSec novice. I'm trying to set up IPSec in transport
mode, using raccoon to set up the SAs, but I don't seem to be getting
SAs. I'm not sure why. Here is my raccoon.conf file and the file that I
"setkey -f":

raccoon.conf:
path pre_shared_key "/root/ipsec/psk.txt";
remote anonymous {
        exchange_mode main;
        proposal {
                encryption_algorithm 3des;
                hash_algorithm md5;
                authentication_method pre_shared_key;
                dh_group modp1024;
        }
}
sainfo address 25.25.25.25 any address 127.0.0.1 any {
        pfs_group modp768;
        encryption_algorithm 3des;
        authentication_algorithm hmac_md5;
        compression_algorithm deflate;
}
sainfo address 127.0.0.1 any address 25.25.25.25 any {
        pfs_group modp768;
        encryption_algorithm 3des;
        authentication_algorithm hmac_md5;
        compression_algorithm deflate;
}

Setkey commands:
spdflush;
flush;
spdadd 127.0.0.1 25.25.25.25 ip4
-ctx 1 1 "system_u:object_r:default_t:s0"
-P in ipsec esp/transport//require;
spdadd 25.25.25.25 127.0.0.1 ip4
-ctx 1 1 "system_u:object_r:default_t:s0"
-P out ipsec esp/transport//require;


Do you see errors?

Thanks,
  Mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
