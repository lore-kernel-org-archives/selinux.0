Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5DEc0BX030848
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 10:38:10 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5DEXlXP141424
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 10:38:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23gbjuwbbt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 10:38:07 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <ubraun@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 15:38:06 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 552AF2190046
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 15:37:34 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5DEc2wN6226414
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 14:38:02 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5DEc29w032292
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 10:38:02 -0400
Subject: Re: [PATCH] iucv: properly clone LSM attributes to newly created
 child sockets
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Paul Moore <pmoore@redhat.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Date: Mon, 13 Jun 2016 16:38:01 +0200
In-Reply-To: <CAHC9VhQPhSAudMSJ6j7cYYdZvYYwpyxMhT6yoGYeXm_oBThSaQ@mail.gmail.com>
References: <OFBFC201CF.D9C45214-ONC1257FCD.0059BB30-C1257FCD.0059C94A@notes.na.collabserv.com>
 <1465812526.4401.4.camel@BR9GV9YG.de.ibm.com>
 <CAHC9VhQPhSAudMSJ6j7cYYdZvYYwpyxMhT6yoGYeXm_oBThSaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1465828681.4401.24.camel@BR9GV9YG.de.ibm.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2016-06-13 at 08:38 -0400, Paul Moore wrote:
> On Mon, Jun 13, 2016 at 6:08 AM, Ursula Braun <ubraun@linux.vnet.ibm.com> wrote:
> >> From: Paul Moore <paul@paul-moore.com>
> >>
> >> Much like we had to do for AF_BLUETOOTH and AF_ALG, make sure we
> >> properly clone the parent socket's LSM attributes to newly created
> >> child sockets.
> >>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >> net/iucv/af_iucv.c |    5 ++++-
> >> 1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> >> index fc3598a..a0d1e36 100644
> >> --- a/net/iucv/af_iucv.c
> >> +++ b/net/iucv/af_iucv.c
> >> @@ -22,6 +22,7 @@
> >> #include <linux/skbuff.h>
> >> #include <linux/init.h>
> >> #include <linux/poll.h>
> >> +#include <linux/security.h>
> >> #include <net/sock.h>
> >> #include <asm/ebcdic.h>
> >> #include <asm/cpcmd.h>
> >> @@ -530,8 +531,10 @@ static void iucv_sock_close(struct sock *sk)
> >>
> >> static void iucv_sock_init(struct sock *sk, struct sock *parent)
> >> {
> >> -                 if (parent)
> >> +                 if (parent) {
> >>                                   sk->sk_type = parent->sk_type;
> >> +                                  security_sk_clone(parent, sk);
> >> +                 }
> >> }
> >>
> >> static struct sock *iucv_sock_alloc(struct socket *sock, int proto,
> >> gfp_t prio, int kern)
> >
> > applied locally - thx. Your patch will now be submitted for inclusion
> > into net-next.
> 
> Hi Ursula,
> 
> For what it's worth, I applied to the selinux#next branch last week,
> it should be in the linux-next builds.
> 
> * git://git.infradead.org/users/pcmoore/selinux
> * http://git.infradead.org/users/pcmoore/selinux
> 

ok, in this case I will not submit your patch myself.
