Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w28KrLLB019097
 for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2018 15:53:21 -0500
Received: by mail-pg0-f65.google.com with SMTP id g8so2695323pgv.7
 for <selinux@tycho.nsa.gov>; Thu, 08 Mar 2018 12:53:16 -0800 (PST)
To: David Miller <davem@davemloft.net>
Cc: stephen@networkplumber.org, pmoore@redhat.com, netdev@vger.kernel.org,
 viro@zeniv.linux.org.uk, dac.override@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
References: <20180306155920.7b6379ac@xeon-e3>
 <20180308.123440.2224695014753871221.davem@davemloft.net>
 <c2d378b6-80b3-d9e1-7087-95f143875067@gmail.com>
 <20180308.131115.611191617522587758.davem@davemloft.net>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <b5ef30d9-5723-5f92-0f7b-b8d4da9a777a@gmail.com>
Date: Thu, 8 Mar 2018 12:53:14 -0800
MIME-Version: 1.0
In-Reply-To: <20180308.131115.611191617522587758.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] net: don't unnecessarily load kernel modules in
 dev_ioctl()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 03/08/2018 10:11 AM, David Miller wrote:

> Yeah, understood.  At small scale the current behavior maybe made
> sense, but these days it really doesn't.
> 
> No objections to the knob if you want to submit it.
> 

Thanks David, I have rebased my patch and sent it.

New numbers on net-next are looking very nice, thanks to Kirill work.
