Date: Wed, 06 Dec 2017 15:13:03 -0500 (EST)
Message-Id: <20171206.151303.1526119083235256934.davem@davemloft.net>
To: richard_c_haines@btinternet.com
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, paul@paul-moore.com,
 vyasevich@gmail.com, nhorman@tuxdriver.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, marcelo.leitner@gmail.com
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171206101736.3217-1-richard_c_haines@btinternet.com>
References: <20171206101736.3217-1-richard_c_haines@btinternet.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [PATCH V2] selinux: Add SCTP support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Richard Haines <richard_c_haines@btinternet.com>
Date: Wed,  6 Dec 2017 10:17:36 +0000

> The SELinux SCTP implementation is explained in:
> Documentation/security/SELinux-sctp.rst
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

No general objections from the networking side, so:

Acked-by: David S. Miller <davem@davemloft.net>

from me.  But if I were you I'd wait for some review from the
SCTP maintainers and experts. :-)
