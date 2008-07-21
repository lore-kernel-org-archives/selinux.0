Date: Mon, 21 Jul 2008 16:08:16 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Paul Moore <paul.moore@hp.com>
cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming
In-Reply-To: <200807210824.40003.paul.moore@hp.com>
Message-ID: <Pine.LNX.4.64L.0807211546530.23634@ruuvi.it.helsinki.fi>
References: <Pine.LNX.4.64L.0807210043160.7451@ruuvi.it.helsinki.fi>
 <200807202125.36525.paul.moore@hp.com> <Pine.LNX.4.64L.0807211104300.15292@ruuvi.it.helsinki.fi>
 <200807210824.40003.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

On Mon, 21 Jul 2008, Paul Moore wrote:

> The kernel is a very large piece of code, which is developed and
> maintained by literally thousands of people.  While there are rules and
> guidelines to help maintain consistency there will _always_ be
> inconsistent style in the Linux Kernel.

Sure. But is that really a valid argument to block the changes that
attempt to bring *at least some* unity to the code?

I mean, what you are saying is analogous to the argument, "the world peace
can never be achieved, therefore we should not bother to settle local
issues either".

I certainly don't intend to wade through the entire kernel. I just want to
make some changes to one particular subsystem that I am interested in
(SELinux), to make the reading experience more enjoyable to me and others,
and, hopefully, to somewhat improve the code.

And as I said in my previous message, Linus' CodingStyle-document exists
and is meant to make the code look more uniform, everywhere.

> Further, due to the extremely high rate of change in the kernel it is
> doubtful that you will be able to stylistically "fix" the entire kernel
> and maintain it (patch acceptance is another issue entirely).

I have never set my goal to fix the entire kernel. That should be obvious
considering the huge size of the source tree.

> I know it can be frustrating at times, but I would suggest that adapting
> yourself to read the Linux Kernel sources will be much more rewarding
> (both to yourself and to the community) than trying to adapt the kernel
> sources to you.

It is true that the sources should not be adapted for specifically for me,
but I am quite convinced that we need a one true coding style that we
should try to adhere to. And while coding style deviations might not
be strong enough reasons to reject patches, the coding standard would
allow other people to fix "nonstandard" coding without any extra debates.

Let me take one extra example of what I mean.

As it stands, if I look at one single source file implementing hash
tables, e.g. ss/hashtab.c, I see the following:

hashtab_insert():

  while (cur && h->keycmp(h, key, cur->key) > 0

the very next function, hashtab_search(), has:

  while (cur != NULL && h->keycmp(h, key, cur->key) > 0)



function hashtab_map() has:

  while (cur != NULL)

the very next next function, hashtab_stat() has:

  while (cur) {


I do not like this kind of inconsistency at all.

While the code may be functionally correct, you should write to the reader
as well as to the compiler. Note: I am not at all saying the SELinux code
is bad quality. On the contrary, based on my very limited kernel
knowledge, I think SELinux kernel side is very good.

I just think it could be improved by using unified coding style.

Best regards,
vmk
--
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
