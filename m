MIME-Version: 1.0
In-Reply-To: <200907061643.08855.paul.moore@hp.com>
References: <20090702212724.7080.70214.stgit@flek.lan>
	 <1246885125.27287.38.camel@moss-pluto.epoch.ncsc.mil>
	 <200907061643.08855.paul.moore@hp.com>
Date: Mon, 6 Jul 2009 17:08:05 -0400
Message-ID: <7e0fb38c0907061408n79202893rd5780cc96c94178f@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: Fix a problem with socket labels and the
	TUN driver
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 6, 2009 at 4:43 PM, Paul Moore<paul.moore@hp.com> wrote:
> On Monday 06 July 2009 08:58:45 am Stephen Smalley wrote:
>> On Thu, 2009-07-02 at 17:27 -0400, Paul Moore wrote:
>> > There is a problem where packets being sent by the TUN driver are not
>> > correctly handled by SELinux in the postrouting code.  The issue is that
>> > the SELinux network access controls rely on a packet's associated sock,
>> > when present, for it's security label.  The TUN driver does create a sock
>> > to send network traffic but it only calls into the LSM/SELinux code once
>> > via the security_sk_alloc() hook which never fully initializes the sock's
>> > label.  This patch attempts to correct this problem by adding the normal
>> > LSM socket creation hooks to the TUN driver.
>> >
>> > NOTE: this is an RFC patch intended to demonstrate a possible solution
>> > completely different from the v1 patch, but it is still crude, untested
>> > and not fully hashed out just yet.  Please take a look and see if this
>> > approach is even worth pursuing ... thanks.
>
> [I'm replying out of order here since your last comment seemed most important]
>
>> > @@ -987,6 +991,12 @@ static int tun_set_iff(struct net *net, struct file
>> > *file, struct ifreq *ifr) tun->sk = sk;
>> >             container_of(sk, struct tun_sock, sk)->tun = tun;
>> >
>> > +           /* XXX - correct placement? */
>> > +           err = security_socket_post_create(tun->socket,
>> > +                                             AF_UNSPEC, SOCK_RAW, 0, 0);
>> > +           if (err < 0)
>> > +                   goto err_free_sk;
>> > +
>>
>> Current socket_post_create() hook presumes that the socket has an inode
>> with an allocated security struct, which I don't think we have here.
>>
>> Wondering if it ought to just call sock_create_lite(), although that
>> will mark it as a kernel socket.  How do we actually want the socket
>> labeled - based on creating process or as a kernel-private socket?
>
> I've been working under the assumption that we want the socket labeled based
> on the creating process as that would ensure that any traffic coming from that
> process through the TUN driver would be treated as if it had come from the
> creating process.  Labeling the socket as a kernel socket robs us of the
> ability to provide decent access control and labeling for traffic passing
> through the TUN driver.

As used by virtual machines I certainly think labeling them with the
creating process makes the most sense and was what I was hoping to
see.  I'm not sure what else uses them though that might be better
suited to kernel_t.....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
