From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Eric Paris <eparis@parisplace.org>
Subject: Re: A filename to label translation daemon
Date: Wed, 15 Aug 2012 15:56:44 +1000
Cc: Colin Walters <walters@verbum.org>, Daniel J Walsh <dwalsh@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
References: <1344454290.25533.12.camel@localhost> <201208142118.42167.russell@coker.com.au> <CACLa4pss-g6qhtwmEv+pOq-jQG7smPxSEt0RU76UnL7=QPh6Hw@mail.gmail.com>
In-Reply-To: <CACLa4pss-g6qhtwmEv+pOq-jQG7smPxSEt0RU76UnL7=QPh6Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201208151556.44770.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 Aug 2012, Eric Paris <eparis@parisplace.org> wrote:
> I have code that does just that.  Dan and I both wrote a version.
> I'll attach it.  I didn't find the speedups we were hoping for and it
> didn't work correctly/completely in the face of file context
> equivalencies.  Although that is likely fixable.  I was just looking
> at all of the stem code (and wondered who wrote it but it was
> pre-git).  I'm surprised it made a big difference.  Wouldn't the regex
> code be able to return extremely quickly if it didn't match?  Anyway.
> I'm writing some test programs to look at all of the possibilities.

At the time I wrote the code I didn't attempt to micro-benchmark it.  As the 
use case that mattered most was a full relabel of a root filesystem (between 
40,000 and 120,000 files in the common case) and the number of regexes was 
smaller than it is today the win was fairly obvious.

>From memory the stem compression change typically improved performance by a 
factor of 3-5 depending on what you were doing.  That was on systems like a 
Pentium-166 or P2-400.  The performance benefits on faster systems (800MHz 
Athlon and better) were less important to me at the time.

Prior to stem compression the relabel was entirely CPU bottlenecked on all 
systems.  After stem compression and some new CPU releases from Intel and AMD 
I wrote the code to have two processes doing disk IO (one stat'ing the files 
and the other applying labels) so that we could have some parallelism between 
regex checks and seeks on disk.

A theoretical regex library wouldn't be much slower than the integer checks we 
are doing, it could just use a 32bit integer compare to check the first 4 bytes 
which would compare to the integer stem check we do.  Does one of the current 
regex libraries do such optimisations where you have a common case of a non-
match on a relatively simple regex?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
