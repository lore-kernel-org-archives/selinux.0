Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w49M30dm001580
 for <selinux@tycho.nsa.gov>; Wed, 9 May 2018 18:03:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 40h9Mj5GgHzg47W
 for <selinux@tycho.nsa.gov>; Wed,  9 May 2018 22:02:57 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 40h9Mj1wtczg47t
 for <selinux@tycho.nsa.gov>; Wed,  9 May 2018 22:02:57 +0000 (UTC)
Received: by mail-lf0-f48.google.com with SMTP id j193-v6so90872lfg.6
 for <selinux@tycho.nsa.gov>; Wed, 09 May 2018 15:02:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSg9UAmXaK0xsy_h9HfzM4uUBqCNKN5qtf3hHLSi=ZENw@mail.gmail.com>
References: <1525788303-23244-1-git-send-email-alexey.kodanev@oracle.com>
 <CAHC9VhTACGPt2dSkUN9Efxs-HQVSAsxoiwPxHcujd++O-mMafg@mail.gmail.com>
 <1eb10913-8802-e2dd-68f0-9483435cd949@tycho.nsa.gov>
 <CAHC9VhT1+-ch1Ncv5YCNgu7tPnUj1Qx8S=a=q=Fn=Dwx4SnTKg@mail.gmail.com>
 <7fdbaf13-fea2-4a2c-213d-fa291db67081@tycho.nsa.gov>
 <CAHC9VhTNS-sEL2Az4hs1nmz7naqoyhiohzhPTrqp_M=_Ys1N6A@mail.gmail.com>
 <d637da77-2789-e08b-c78b-b48821cbf0fe@tycho.nsa.gov>
 <CAHC9VhSg9UAmXaK0xsy_h9HfzM4uUBqCNKN5qtf3hHLSi=ZENw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 May 2018 18:02:53 -0400
Message-ID: <CAHC9VhRmX+Z+ignXXBrSGyUkpxudO76Fv-6o_My=skh-U8Ccgw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Alexey Kodanev <alexey.kodanev@oracle.com>,
 Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
 linux-security-module@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: add AF_UNSPEC and INADDR_ANY checks to
 selinux_socket_bind()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 9, 2018 at 11:34 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, May 9, 2018 at 11:11 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 05/09/2018 11:01 AM, Paul Moore wrote:
>>> On Wed, May 9, 2018 at 8:37 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 05/08/2018 08:25 PM, Paul Moore wrote:
>>>>> On Tue, May 8, 2018 at 2:40 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>> On 05/08/2018 01:05 PM, Paul Moore wrote:
>>>>>>> On Tue, May 8, 2018 at 10:05 AM, Alexey Kodanev
>>>>>>> <alexey.kodanev@oracle.com> wrote:
>>>>>>>> Commit d452930fd3b9 ("selinux: Add SCTP support") breaks compatibility
>>>>>>>> with the old programs that can pass sockaddr_in with AF_UNSPEC and
>>>>>>>> INADDR_ANY to bind(). As a result, bind() returns EAFNOSUPPORT error.
>>>>>>>> It was found with LTP/asapi_01 test.
>>>>>>>>
>>>>>>>> Similar to commit 29c486df6a20 ("net: ipv4: relax AF_INET check in
>>>>>>>> bind()"), which relaxed AF_INET check for compatibility, add AF_UNSPEC
>>>>>>>> case to AF_INET and make sure that the address is INADDR_ANY.
>>>>>>>>
>>>>>>>> Also, in the end of selinux_socket_bind(), instead of adding AF_UNSPEC
>>>>>>>> to 'address->sa_family == AF_INET', verify AF_INET6 first.
>>>>>>>>
>>>>>>>> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
>>>>>>>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>>>>>>>> ---
>>>>>>>>  security/selinux/hooks.c | 12 +++++++++---
>>>>>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> Thanks for finding and reporting this regression.
>>>>>>>
>>>>>>> I think I would prefer to avoid having to duplicate the
>>>>>>> AF_UNSPEC/INADDR_ANY checking logic in the SELinux hook, even though
>>>>>>> it is a small bit of code and unlikely to change.  I'm wondering if it
>>>>>>> would be better to check both the socket and sockaddr address family
>>>>>>> in the main if conditional inside selinux_socket_bind(), what do you
>>>>>>> think?  Another option would be to go back to just checking the
>>>>>>> soackaddr address family; we moved away from that for a reason which
>>>>>>> escapes at the moment (code cleanliness?), but perhaps that was a
>>>>>>> mistake.
>>>>>>
>>>>>> We've always used the sk->sk_family there; it was only the recent code from Richard that started
>>>>>> using the socket address family.
>>>>>
>>>>> Yes I know, I thought I was the one that suggested it at some point
>>>>> (I'll take the blame) ... although now that I'm looking at the git
>>>>> log, maybe I'm confusing it with something else.
>>>>>
>>>>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>>>>> index 4cafe6a19167..a3789b167667 100644
>>>>>>> --- a/security/selinux/hooks.c
>>>>>>> +++ b/security/selinux/hooks.c
>>>>>>> @@ -4577,6 +4577,7 @@ static int selinux_socket_bind(struct socket *sock, struc>
>>>>>>> {
>>>>>>>        struct sock *sk = sock->sk;
>>>>>>>        u16 family;
>>>>>>> +       u16 family_sa;
>>>>>>>        int err;
>>>>>>>
>>>>>>>        err = sock_has_perm(sk, SOCKET__BIND);
>>>>>>> @@ -4585,7 +4586,9 @@ static int selinux_socket_bind(struct socket *sock, struc>
>>>>>>>
>>>>>>>        /* If PF_INET or PF_INET6, check name_bind permission for the port. */
>>>>>>>        family = sk->sk_family;
>>>>>>> -       if (family == PF_INET || family == PF_INET6) {
>>>>>>> +       family_sa = address->sa_family;
>>>>>>> +       if ((family == PF_INET || family == PF_INET6) &&
>>>>>>> +           (family_sa == PF_INET || family_sa == PF_INET6)) {
>>>>>>
>>>>>> Wouldn't this allow bypassing the name_bind permission check by passing in AF_UNSPEC?
>>>>>
>>>>> I believe these name_bind permission checkis skipped for AF_UNSPEC
>>>>> already, isn't it?  The only way the name_bind check would be
>>>>> triggered is if the source port, snum, was non-zero and I didn't think
>>>>> that was really legal for AF_UNSPEC/INADDR_ANY, is it?
>>>>
>>>> 1) What in inet_bind() prevents that from occurring?
>>>> 2) Regardless, what about the node_bind check?
>>>
>>> Fair enough.  As mentioned above, perhaps the right fix is to move the
>>> address family checking back to how it was pre-SCTP.
>>
>> It isn't clear to me how to do that without breaking SCTP multiple address binding, which is why
>> Richard had to switch to checking address->sa_family instead of just using the sk->sk_family.
>> Alexey's original fix might be the simplest solution.
>
> I'm going to have to apologize, I'm traveling at the moment and more
> distracted than usual as a result.  Let me take a closer look later
> today.  It may be that Alexey's original fix the only practical
> solution, but I really would like to avoid having to duplicate checks
> like that in the SELinux code.

I just had a better look at this and I believe that Alexey and Stephen
are right: this is the best option.  My apologies for the noise
earlier.  However, while looking at the code I think there are some
additional necessary changes:

* In the case of an SCTP socket, we should return -EINVAL, just as we
do with other address families.
* While not strictly related to AF_UNSPEC, we really should be passing
the address family of the sockaddr, and not the socket, to functions
that need to interpret the bind address/port.

I'm waiting for my kernel to compile so I haven't given this any
sanity testing, but the patch below is what I think we need ...

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cafe6a19167..5f30045b2053 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4576,6 +4576,7 @@ static int selinux_socket_post_create(struct socket *sock,
int family,
static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, i
nt addrlen)
{
       struct sock *sk = sock->sk;
+       struct sk_security_struct *sksec = sk->sk_security;
       u16 family;
       int err;

@@ -4587,13 +4588,13 @@ static int selinux_socket_bind(struct socket *sock, stru
ct sockaddr *address, in
       family = sk->sk_family;
       if (family == PF_INET || family == PF_INET6) {
               char *addrp;
-               struct sk_security_struct *sksec = sk->sk_security;
               struct common_audit_data ad;
               struct lsm_network_audit net = {0,};
               struct sockaddr_in *addr4 = NULL;
               struct sockaddr_in6 *addr6 = NULL;
               unsigned short snum;
               u32 sid, node_perm;
+               u16 family_sa = address->sa_family;

               /*
                * sctp_bindx(3) calls via selinux_sctp_bind_connect()
@@ -4601,11 +4602,19 @@ static int selinux_socket_bind(struct socket *sock, stru
ct sockaddr *address, in
                * need to check address->sa_family as it is possible to have
                * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
                */
-               switch (address->sa_family) {
+               switch (family_sa) {
+               case AF_UNSPEC:
               case AF_INET:
                       if (addrlen < sizeof(struct sockaddr_in))
                               return -EINVAL;
                       addr4 = (struct sockaddr_in *)address;
+                       if (family_sa == AF_UNSPEC) {
+                               /* see "__inet_bind()", we only want to allow
+                                * AF_UNSPEC if the address is INADDR_ANY */
+                               if (addr4->sin_addr.s_addr != htonl(INADDR_ANY))
+                                       goto err_af;
+                               family_sa = AF_INET;
+                       }
                       snum = ntohs(addr4->sin_port);
                       addrp = (char *)&addr4->sin_addr.s_addr;
                       break;
@@ -4617,15 +4626,14 @@ static int selinux_socket_bind(struct socket *sock, stru
ct sockaddr *address, in
                       addrp = (char *)&addr6->sin6_addr.s6_addr;
                       break;
               default:
-                       /* Note that SCTP services expect -EINVAL, whereas
-                        * others expect -EAFNOSUPPORT.
-                        */
-                       if (sksec->sclass == SECCLASS_SCTP_SOCKET)
-                               return -EINVAL;
-                       else
-                               return -EAFNOSUPPORT;
+                       goto err_af;
               }

+               ad.type = LSM_AUDIT_DATA_NET;
+               ad.u.net = &net;
+               ad.u.net->sport = htons(snum);
+               ad.u.net->family = family_sa;
+
               if (snum) {
                       int low, high;

@@ -4637,10 +4645,6 @@ static int selinux_socket_bind(struct socket *sock, struc
t sockaddr *address, in
                                                     snum, &sid);
                               if (err)
                                       goto out;
-                               ad.type = LSM_AUDIT_DATA_NET;
-                               ad.u.net = &net;
-                               ad.u.net->sport = htons(snum);
-                               ad.u.net->family = family;
                               err = avc_has_perm(&selinux_state,
                                                  sksec->sid, sid,
                                                  sksec->sclass,
@@ -4672,16 +4676,11 @@ static int selinux_socket_bind(struct socket *sock, stru
ct sockaddr *address, in
                       break;
               }

-               err = sel_netnode_sid(addrp, family, &sid);
+               err = sel_netnode_sid(addrp, family_sa, &sid);
               if (err)
                       goto out;

-               ad.type = LSM_AUDIT_DATA_NET;
-               ad.u.net = &net;
-               ad.u.net->sport = htons(snum);
-               ad.u.net->family = family;
-
-               if (address->sa_family == AF_INET)
+               if (family_sa == AF_INET)
                       ad.u.net->v4info.saddr = addr4->sin_addr.s_addr;
               else
                       ad.u.net->v6info.saddr = addr6->sin6_addr;
@@ -4694,6 +4693,12 @@ static int selinux_socket_bind(struct socket *sock, struc
t sockaddr *address, in
       }
out:
       return err;
+err_af:
+       /* Note that SCTP services expect -EINVAL, others -EAFNOSUPPORT. */
+       if (sksec->sclass == SECCLASS_SCTP_SOCKET)
+               return -EINVAL;
+       else
+               return -EAFNOSUPPORT;
}

/* This supports connect(2) and SCTP connect services such as sctp_connectx(3)

-- 
paul moore
www.paul-moore.com
