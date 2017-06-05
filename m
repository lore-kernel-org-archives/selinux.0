Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v55G0YV4004539
 for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2017 12:00:38 -0400
Date: Mon, 05 Jun 2017 12:00:15 -0400 (EDT)
Message-Id: <20170605.120015.1136981458406571990.davem@davemloft.net>
To: paul@paul-moore.com
Cc: richard_c_haines@btinternet.com, netdev@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] net/ipv6: Fix CALIPSO causing GPF with datagram support
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAHC9VhRwzC=XTRj5gNfd11T=XzpYSrVfu-jnx9f4__duMAji1Q@mail.gmail.com>
References: <20170605154440.2434-1-richard_c_haines@btinternet.com>
 <CAHC9VhRwzC=XTRj5gNfd11T=XzpYSrVfu-jnx9f4__duMAji1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 Jun 2017 11:55:34 -0400

> On Mon, Jun 5, 2017 at 11:44 AM, Richard Haines
> <richard_c_haines@btinternet.com> wrote:
>> When using CALIPSO with IPPROTO_UDP it is possible to trigger a GPF as the
>> IP header may have moved.
>>
>> Also update the payload length after adding the CALIPSO option.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> ---
>>  net/ipv6/calipso.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> 
> Thanks Richard.  DaveM, I assume you'll be pulling this into your tree?

Sure.
