Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5DCc8fQ014915
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 08:38:09 -0400
Received: by mail-oi0-f65.google.com with SMTP id a64so3148859oii.1
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 05:38:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465812526.4401.4.camel@BR9GV9YG.de.ibm.com>
References: <OFBFC201CF.D9C45214-ONC1257FCD.0059BB30-C1257FCD.0059C94A@notes.na.collabserv.com>
 <1465812526.4401.4.camel@BR9GV9YG.de.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Jun 2016 08:38:05 -0400
Message-ID: <CAHC9VhQPhSAudMSJ6j7cYYdZvYYwpyxMhT6yoGYeXm_oBThSaQ@mail.gmail.com>
Subject: Re: [PATCH] iucv: properly clone LSM attributes to newly created
 child sockets
To: Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: Paul Moore <pmoore@redhat.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 13, 2016 at 6:08 AM, Ursula Braun <ubraun@linux.vnet.ibm.com> wrote:
>> From: Paul Moore <paul@paul-moore.com>
>>
>> Much like we had to do for AF_BLUETOOTH and AF_ALG, make sure we
>> properly clone the parent socket's LSM attributes to newly created
>> child sockets.
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>> net/iucv/af_iucv.c |    5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
>> index fc3598a..a0d1e36 100644
>> --- a/net/iucv/af_iucv.c
>> +++ b/net/iucv/af_iucv.c
>> @@ -22,6 +22,7 @@
>> #include <linux/skbuff.h>
>> #include <linux/init.h>
>> #include <linux/poll.h>
>> +#include <linux/security.h>
>> #include <net/sock.h>
>> #include <asm/ebcdic.h>
>> #include <asm/cpcmd.h>
>> @@ -530,8 +531,10 @@ static void iucv_sock_close(struct sock *sk)
>>
>> static void iucv_sock_init(struct sock *sk, struct sock *parent)
>> {
>> -                 if (parent)
>> +                 if (parent) {
>>                                   sk->sk_type = parent->sk_type;
>> +                                  security_sk_clone(parent, sk);
>> +                 }
>> }
>>
>> static struct sock *iucv_sock_alloc(struct socket *sock, int proto,
>> gfp_t prio, int kern)
>
> applied locally - thx. Your patch will now be submitted for inclusion
> into net-next.

Hi Ursula,

For what it's worth, I applied to the selinux#next branch last week,
it should be in the linux-next builds.

* git://git.infradead.org/users/pcmoore/selinux
* http://git.infradead.org/users/pcmoore/selinux

-- 
paul moore
www.paul-moore.com
