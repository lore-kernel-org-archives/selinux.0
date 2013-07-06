Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6678wPm005634
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2013 03:08:58 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so2400920wes.6
        for <selinux@tycho.nsa.gov>; Sat, 06 Jul 2013 00:08:56 -0700 (PDT)
Date: Sat, 6 Jul 2013 08:39:52 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Labeled IPSec trying to match policy for peer label?
Message-ID: <20130706063952.GA29221@siphos.be>
References: <20130705183902.GA26996@siphos.be>
 <2894544.bL1dEvHUlK@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <2894544.bL1dEvHUlK@sifl>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 05, 2013 at 04:50:41PM -0400, Paul Moore wrote:
> > spdadd 10.1.2.0/24 10.1.3.0/24 any -ctx 1 1
> >   "system_u:object_r:ipsec_spd_t:s0" -P out ipsec
> >   esp/tunnel/192.168.100.152-192.168.100.153/require;
> > 
> > spdadd 10.1.3.0/24 10.1.2.0/24 any -ctx 1 1
> >   "system_u:object_r:ipsec_spd_t:s0" -P in ipsec
> >   esp/tunnel/192.168.100.153-192.168.100.152/require;
[...]
> Is the server side running the same SELinux policy as the client?  Does the 
> server have a SPD entry that is labeled, e.g. '-ctx 1 1 
> "system_u:object_r:ipsec_spd_t:s0"'?

Yes, both sides have the same setkey instructions (only the in/out is
switched) and are running the same SELinux policy & type. The racoon
configurations are also the same (of course each one with the right
addresses in the remote { ... } and sainfo { ... } definitions.

I am assuming nothing needs to be changed on racoon when running regular
IPSec or labeled IPSec? In any case, here is one of the configs:

path pre_shared_key "/etc/racoon/psk.txt";
remote 192.168.100.153 
{
        exchange_mode main,aggressive;
        proposal {
                encryption_algorithm 3des;
                hash_algorithm sha1;
                authentication_method pre_shared_key;
                dh_group modp1024;
        }
}

sainfo address 10.1.2.0/24 any address 10.1.3.0/24 any
{
        pfs_group modp768;
        encryption_algorithm 3des, blowfish 448, rijndael;
        authentication_algorithm hmac_sha1, hmac_md5;
        compression_algorithm deflate;
}

I am using ipsec-tools 0.8.0 build with --enable-security-context. There are
a few additional patches applied by the distribution ("sysctl", "def-psk"
and "include-vendoridh")

I'll be trying with ipsec-tools 0.8.1 later today.

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
