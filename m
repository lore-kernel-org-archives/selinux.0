Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u51J1Da6030954
 for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2016 15:01:14 -0400
Received: by mail-oi0-f67.google.com with SMTP id h125so6059215oib.2
 for <selinux@tycho.nsa.gov>; Wed, 01 Jun 2016 12:01:06 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Jun 2016 15:01:05 -0400
Message-ID: <CAHC9VhS0oH8p55_3yOcQGJWx8WmokHW=kSrKOM6tKPM1XoPjGA@mail.gmail.com>
Subject: Possible problem with e6afc8ac ("udp: remove headers from UDP packets
 before queueing")
From: Paul Moore <paul@paul-moore.com>
To: samanthakumar@google.com
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I'm currently trying to debug a problem with 4.7-rc1 and labeled
networking over UDP.  I'm having some difficulty with the latest
4.7-rc1 builds on my test system at the moment so I haven't been able
to concisely identify the problem, but looking through the commits in
4.7-rc1 I think there may be a problem with the following:

  commit e6afc8ace6dd5cef5e812f26c72579da8806f5ac
  Author: samanthakumar <samanthakumar@google.com>
  Date:   Tue Apr 5 12:41:15 2016 -0400

   udp: remove headers from UDP packets before queueing

   Remove UDP transport headers before queueing packets for reception.
   This change simplifies a follow-up patch to add MSG_PEEK support.

   Signed-off-by: Sam Kumar <samanthakumar@google.com>
   Signed-off-by: Willem de Bruijn <willemb@google.com>
   Signed-off-by: David S. Miller <davem@davemloft.net>

... it appears that this commit changes things so that sk_filter() is
only called when sk->sk_filter is not NULL.  While this is fine for
the traditional socket filter case, it causes problems with LSMs that
make use of security_sock_rcv_skb() to enforce per-packet access
controls.

Hopefully I'll get 4.7-rc1 booting soon and I can do a proper
bisection test around this patch, but I wanted to mention this now in
case others are seeing the same problem.

-- 
paul moore
www.paul-moore.com
