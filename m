Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4AG5wFU024237
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 12:05:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 40hdNx2llrz2Sj4J
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 16:05:37 +0000 (UTC)
Received: from UPBD19PA02.eemsg.mil (unknown [192.168.18.3])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 40hdNw6Ww8z2Sj4B
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 16:05:36 +0000 (UTC)
Received: by mail-lf0-f50.google.com with SMTP id z142-v6so3732852lff.5
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 09:05:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <aab86e3c-0891-766b-53aa-ad471394ac46@oracle.com>
References: <1525788303-23244-1-git-send-email-alexey.kodanev@oracle.com>
 <CAHC9VhTACGPt2dSkUN9Efxs-HQVSAsxoiwPxHcujd++O-mMafg@mail.gmail.com>
 <1eb10913-8802-e2dd-68f0-9483435cd949@tycho.nsa.gov>
 <CAHC9VhT1+-ch1Ncv5YCNgu7tPnUj1Qx8S=a=q=Fn=Dwx4SnTKg@mail.gmail.com>
 <7fdbaf13-fea2-4a2c-213d-fa291db67081@tycho.nsa.gov>
 <CAHC9VhTNS-sEL2Az4hs1nmz7naqoyhiohzhPTrqp_M=_Ys1N6A@mail.gmail.com>
 <d637da77-2789-e08b-c78b-b48821cbf0fe@tycho.nsa.gov>
 <CAHC9VhSg9UAmXaK0xsy_h9HfzM4uUBqCNKN5qtf3hHLSi=ZENw@mail.gmail.com>
 <CAHC9VhRmX+Z+ignXXBrSGyUkpxudO76Fv-6o_My=skh-U8Ccgw@mail.gmail.com>
 <aab86e3c-0891-766b-53aa-ad471394ac46@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 May 2018 12:05:29 -0400
Message-ID: <CAHC9VhT5Y6nZNisyFFiE=BR+T6pdbRhnvQQ1NyXm_AJmn9VMgA@mail.gmail.com>
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 Richard Haines <richard_c_haines@btinternet.com>,
 selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
 linux-security-module@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: add AF_UNSPEC and INADDR_ANY checks to
 selinux_socket_bind()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 10, 2018 at 5:28 AM, Alexey Kodanev
<alexey.kodanev@oracle.com> wrote:
> On 10.05.2018 01:02, Paul Moore wrote:
> ...
>> I just had a better look at this and I believe that Alexey and Stephen
>> are right: this is the best option.  My apologies for the noise
>> earlier.  However, while looking at the code I think there are some
>> additional necessary changes:
>>
>> * In the case of an SCTP socket, we should return -EINVAL, just as we
>> do with other address families.
>
> Right.
>
>> * While not strictly related to AF_UNSPEC, we really should be passing
>> the address family of the sockaddr, and not the socket, to functions
>> that need to interpret the bind address/port.
>
> That looks like a correct solution. I guess we need the same fix for
> sctp_connectx(), in selinux_socket_connect_helper().

Yes.  I think we also need a small change to
selinux_sctp_bind_connect() to both not error out on AF_UNSPEC, and to
return EINVAL on a bad address family (some of the callers pass on the
return value, some don't).

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5f30045b2053..a8bac9b37ee7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5277,6 +5277,7 @@ static int selinux_sctp_bind_connect(struct sock *sk, int>
       while (walk_size < addrlen) {
               addr = addr_buf;
               switch (addr->sa_family) {
+               case AF_UNSPEC:
               case AF_INET:
                       len = sizeof(struct sockaddr_in);
                       break;
@@ -5284,7 +5285,7 @@ static int selinux_sctp_bind_connect(struct sock *sk, int>
                       len = sizeof(struct sockaddr_in6);
                       break;
               default:
-                       return -EAFNOSUPPORT;
+                       return -EINVAL;
               }

               err = -EINVAL;

>> I'm waiting for my kernel to compile so I haven't given this any
>> sanity testing, but the patch below is what I think we need ...
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 4cafe6a19167..5f30045b2053 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4576,6 +4576,7 @@ static int selinux_socket_post_create(struct socket *sock,
>> int family,
>> static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, i
>> nt addrlen)
>> {
>>        struct sock *sk = sock->sk;
>> +       struct sk_security_struct *sksec = sk->sk_security;
>>        u16 family;
>>        int err;
>>
>> @@ -4587,13 +4588,13 @@ static int selinux_socket_bind(struct socket *sock, stru
>> ct sockaddr *address, in
>>        family = sk->sk_family;
>>        if (family == PF_INET || family == PF_INET6) {
>>                char *addrp;
>> -               struct sk_security_struct *sksec = sk->sk_security;
>>                struct common_audit_data ad;
>>                struct lsm_network_audit net = {0,};
>>                struct sockaddr_in *addr4 = NULL;
>>                struct sockaddr_in6 *addr6 = NULL;
>>                unsigned short snum;
>>                u32 sid, node_perm;
>> +               u16 family_sa = address->sa_family;
>>
>>                /*
>>                 * sctp_bindx(3) calls via selinux_sctp_bind_connect()
>> @@ -4601,11 +4602,19 @@ static int selinux_socket_bind(struct socket *sock, stru
>> ct sockaddr *address, in
>>                 * need to check address->sa_family as it is possible to have
>>                 * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
>>                 */
>> -               switch (address->sa_family) {
>> +               switch (family_sa) {
>> +               case AF_UNSPEC:
>>                case AF_INET:
>>                        if (addrlen < sizeof(struct sockaddr_in))
>>                                return -EINVAL;
>>                        addr4 = (struct sockaddr_in *)address;
>> +                       if (family_sa == AF_UNSPEC) {
>> +                               /* see "__inet_bind()", we only want to allow
>> +                                * AF_UNSPEC if the address is INADDR_ANY */
>> +                               if (addr4->sin_addr.s_addr != htonl(INADDR_ANY))
>> +                                       goto err_af;
>> +                               family_sa = AF_INET;
>> +                       }
>>                        snum = ntohs(addr4->sin_port);
>>                        addrp = (char *)&addr4->sin_addr.s_addr;
>>                        break;
>> @@ -4617,15 +4626,14 @@ static int selinux_socket_bind(struct socket *sock, stru
>> ct sockaddr *address, in
>>                        addrp = (char *)&addr6->sin6_addr.s6_addr;
>>                        break;
>>                default:
>> -                       /* Note that SCTP services expect -EINVAL, whereas
>> -                        * others expect -EAFNOSUPPORT.
>> -                        */
>> -                       if (sksec->sclass == SECCLASS_SCTP_SOCKET)
>> -                               return -EINVAL;
>> -                       else
>> -                               return -EAFNOSUPPORT;
>> +                       goto err_af;
>>                }
>>
>> +               ad.type = LSM_AUDIT_DATA_NET;
>> +               ad.u.net = &net;
>> +               ad.u.net->sport = htons(snum);
>> +               ad.u.net->family = family_sa;
>> +
>
> May be we could move setting ad.u.net->v{4|6}info.saddr here as well?

I looked at that too, the problem is that if we set the IP address
here it will be reported in the audit record for a name_bind failure,
which is a change from the current behavior.  One could argue this is
the correct thing to do, but I would like to limit the number of
changes for patches that are destined for the -rcX stream.

Let's leave them separate for now.

> Will send a v2 of this patch so that SCTP socket returns EINVAL with
> AF_UNSPEC. Should I prepare a patch with correcting 'ad.u.net->family'
> and sel_netnode_sid()?

Please, that would be helpful.  I think all of the issues we have
identified in this thread should be fixed during the v4.17-rcX
releases, so if you don't do it I'll need to do it :)

-- 
paul moore
www.paul-moore.com
