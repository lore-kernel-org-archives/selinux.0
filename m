Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8KFOPLC016660
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 11:24:25 -0400
To: =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc: pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
 davem@davemloft.net, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, jmorris@namei.org,
 serge@hallyn.com, selinux <selinux@tycho.nsa.gov>,
 linux-security-module@vger.kernel.org
References: <20180919231402.4482-1-cgzones@googlemail.com>
 <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
 <CAJ2a_Ddd19txwUiKkOwpdWUSq9+VWFSR6Cqe4zgXKggWUPi4hw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f65fb0db-d79f-3867-f48c-cec2f61e027b@schaufler-ca.com>
Date: Thu, 20 Sep 2018 08:23:30 -0700
MIME-Version: 1.0
In-Reply-To: <CAJ2a_Ddd19txwUiKkOwpdWUSq9+VWFSR6Cqe4zgXKggWUPi4hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] netfilter: nf_tables: add SECMARK support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/20/2018 12:18 AM, Christian Göttsche wrote:
>> I've only had a cursory look at your patch, but how is it
>> different from what's in xt_SECMARK.c ?
> xt_SEXMARK.c is for xtables, use-able in iptables; this is for nftables (nft)

Thank you. I am enlightened.
