Date: Mon, 23 Jan 2017 10:47:27 -0500 (EST)
Message-Id: <20170123.104727.1594805087752706376.davem@davemloft.net>
To: steffen.klassert@secunet.com
Cc: cernekee@chromium.org, herbert@gondor.apana.org.au, paul@paul-moore.com,
 sds@tycho.nsa.gov, eparis@parisplace.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, selinux@tycho.nsa.gov, fw@strlen.de,
 fan.du@windriver.com, dianders@chromium.org, dtor@chromium.org
Subject: Re: [PATCH 0/4] Make xfrm usable by 32-bit programs
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170123093517.GM3541@gauss.secunet.com>
References: <20170121000507.34381-1-cernekee@chromium.org>
 <20170123093517.GM3541@gauss.secunet.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Steffen Klassert <steffen.klassert@secunet.com>
Date: Mon, 23 Jan 2017 10:35:17 +0100

> So this creates new incompatibilities what is another argument against
> this approach. If you really need this, try to implement a full compat
> layer. I think this is the only sane solution for this.

A full compat layer is the only reasonable solution to this problem.
