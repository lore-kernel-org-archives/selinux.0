Date: Mon, 23 Jan 2017 11:57:22 -0500 (EST)
Message-Id: <20170123.115722.2044116177906799668.davem@davemloft.net>
To: David.Laight@ACULAB.COM
Cc: cernekee@chromium.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, selinux@tycho.nsa.gov, fw@strlen.de,
 fan.du@windriver.com, dianders@chromium.org, dtor@chromium.org
Subject: Re: [PATCH 0/4] Make xfrm usable by 32-bit programs
From: David Miller <davem@davemloft.net>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB026BC58@AcuExch.aculab.com>
References: <20170121000507.34381-1-cernekee@chromium.org>
 <063D6719AE5E284EB5DD2968C1650D6DB026BC58@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 23 Jan 2017 16:45:39 +0000

> Provided you've got the length of the user's buffer the compat code
> ought to be trivial (if tedious).

Wireless guys had to deal with a similar problem with nl80211.

You don't know who is going to get the message when you build it,
because you can't possibly know what applications are listening
on the netlink sockets for notifications and even if you did
that set changes dynamically and could be different by the time
the notification is delivered.

The long and short of it is that you must always generate both the
native 64-bit as well as the 32-bit compat version of every message,
then at delivery time you enqueue the appropriate one to each
receiving socket.

This is how nl80211 solved the problem, and it's what XFRM should do
as well.
