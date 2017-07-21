Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6LMJJpx011796
 for <selinux@tycho.nsa.gov>; Fri, 21 Jul 2017 18:19:20 -0400
Received: by mail-lf0-f49.google.com with SMTP id d78so27990502lfg.3
 for <selinux@tycho.nsa.gov>; Fri, 21 Jul 2017 15:19:12 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jul 2017 18:19:06 -0400
Message-ID: <CAHC9VhS9QO8jGBodsSeQxxbgoxrmThRgbc3_m17h7gFmfP=GGw@mail.gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: SELinux/IP_PASSSEC regression in 4.13-rcX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I've been seeing a SELinux regression with IP_PASSSEC on the v4.13-rcX
kernels and finally tracked the problem down to the
skb_release_head_state() call in __udp_queue_rcv_skb().  Looking at
the code and the git log it would appear that the likely culprit is
0a463c78d25b ("udp: avoid a cache miss on dequeue
"); it looks similar to IP option problem fixed in 0ddf3fb2c43d2.

>From a SELinux/IP_PASSSEC point of view we need access to the skb->sp
pointer to examine the SAs.  I'm posting this here without a patch
because it isn't clear to me how you would like to fix the problem; my
initial thought would be to simply make the skb_release_head_state()
conditional on the skb->sp pointer, much like the IP options fix, but
I'm not sure if you have a more clever idea.

-- 
paul moore
www.paul-moore.com
