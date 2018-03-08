Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w28I6tac025832
 for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2018 13:06:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3zxz281BW2z19YvD
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 18:05:20 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3zxz2806FMz19YvC
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 18:05:20 +0000 (UTC)
Received: by mail-pl0-f45.google.com with SMTP id s13-v6so3734880plq.6
 for <selinux@tycho.nsa.gov>; Thu, 08 Mar 2018 10:05:18 -0800 (PST)
To: David Miller <davem@davemloft.net>, stephen@networkplumber.org
Cc: pmoore@redhat.com, netdev@vger.kernel.org, viro@zeniv.linux.org.uk,
 dac.override@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
References: <152037526427.18953.14013300464173153064.stgit@chester>
 <20180306155920.7b6379ac@xeon-e3>
 <20180308.123440.2224695014753871221.davem@davemloft.net>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c2d378b6-80b3-d9e1-7087-95f143875067@gmail.com>
Date: Thu, 8 Mar 2018 10:05:12 -0800
MIME-Version: 1.0
In-Reply-To: <20180308.123440.2224695014753871221.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] net: don't unnecessarily load kernel modules in
 dev_ioctl()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 03/08/2018 09:34 AM, David Miller wrote:
> From: Stephen Hemminger <stephen@networkplumber.org>
> Date: Tue, 6 Mar 2018 15:59:20 -0800
> 
>> Actually dev_load by ethernet name is really a legacy thing that
>> should just die,
>>
>> It was kept around so that some very tunnel configuration using special names.
>>
>> 	# ifconfig sit0
>>
>> which probably several web pages still tell users to do...
>> We have much better control now with ip commands so that this is just
>> baggage.
> 
> As you say, some people use this stuff, so we really can't break
> it at this point.

Another problematic legacy behavior is the automatic creation of 
fallback tunnels, which hurts netns creation/deletion.

Some environments want to create a netns for every job/task, and they do 
not care if the init netns has these tunnels or not.

We have a local patch adding yet another knob to control this, since it 
saves a lot of cpu cycles (about 10ms per netns create/delete pair here)

lpk43:~# echo 0 >/proc/sys/net/core/fb_tunnels_only_for_init_net
lpk43:~# time for i in {1..1000}; do unshare -n /bin/false;done

real	0m14.939s
user	0m0.152s
sys	0m1.496s

lpk43:~# unshare -n
lpk43:~# ip link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/ipip 0.0.0.0 brd 0.0.0.0
3: gre0@NONE: <NOARP> mtu 1476 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/gre 0.0.0.0 brd 0.0.0.0
4: gretap0@NONE: <BROADCAST,MULTICAST> mtu 1462 qdisc noop state DOWN 
mode DEFAULT group default qlen 1000
     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
5: erspan0@NONE: <BROADCAST,MULTICAST> mtu 1450 qdisc noop state DOWN 
mode DEFAULT group default qlen 1000
     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
6: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/sit 0.0.0.0 brd 0.0.0.0
7: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN mode DEFAULT 
group default qlen 1000
     link/tunnel6 :: brd ::
8: ip6gre0@NONE: <NOARP> mtu 1448 qdisc noop state DOWN mode DEFAULT 
group default qlen 1000
     link/gre6 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00 brd 
00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
lpk43:~# exit
logout

lpk43:~# echo 1 >/proc/sys/net/core/fb_tunnels_only_for_init_net

lpk43:~# time for i in {1..1000}; do unshare -n /bin/false;done

real	0m4.169s
user	0m0.202s
sys	0m0.875s

lpk43:~# unshare -n

lpk43:~# ip link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
lpk43:~#
