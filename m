Message-ID: <1495736294.22368.4.camel@tycho.nsa.gov>
Subject: Re: ioctl help
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeffrey Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
Date: Thu, 25 May 2017 14:18:14 -0400
In-Reply-To: <CABXk95DJqLLTXzGX-2CVXAhB4MNMPzxb4qUskuJ4vQ-yh86itQ@mail.gmail.com>
References: <20170524120854.GA1910@julius.enp8s0.d30>
 <1495656704.3489.4.camel@tycho.nsa.gov>
 <20170525054919.GB12190@julius.enp8s0.d30>
 <20170525091954.GD12190@julius.enp8s0.d30>
 <CABXk95DJqLLTXzGX-2CVXAhB4MNMPzxb4qUskuJ4vQ-yh86itQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-05-25 at 17:35 +0000, Jeffrey Vander Stoep via Selinux
wrote:
> The command number is just a uint16. It's up to each driver to
> interpret it. So it's CHIOEXCHANGE for a particular driver
> and CM_IOCSPTS for a different driver.
> 
> Ideally, you're whitelisting ioctls on a per-driver basis, so this
> model works.

Possibly to avoid user confusion, we should have checkpolicy only
accept values 0-0xffff (as with CIL), and the macros should be
truncated when they are generated.  Otherwise, reading the policy could
be misleading.

> 
> On Thu, May 25, 2017 at 2:21 AM Dominick Grift <dac.override@gmail.co
> m> wrote:
> > On Thu, May 25, 2017 at 07:49:19AM +0200, Dominick Grift wrote:
> > > On Wed, May 24, 2017 at 04:11:44PM -0400, Stephen Smalley wrote:
> > > > On Wed, 2017-05-24 at 14:08 +0200, Dominick Grift wrote:
> > > > > I was looking again at ioctl whitelisting, and excuse me if I
> > > > > overlooked some documentation, but I am having a hard time
> > > > > implementing this.
> > > > > what I did was I just wanted to basically test blacklisting a
> > single
> > > > > ioctl (no particular one)
> > > > >
> > > > > So i looked into androids sepolicy and just picked a semi-
> > random
> > > > > ioctl from their "https://android.googlesource.com/platform/s
> > ystem/se
> > > > > policy/+/master/public/ioctl_defines"
> > > > >
> > > > > for example: PHONE_CAPABILITIES_CHECK 0x40087182
> > > > >
> > > > > However the xpermissions statement only allows 0x0000 to
> > 0xFFFF when
> > > > > i tried: (xpermission alg_socket_ioctl (ioctl alg_socket (not
> > > > > (0x40087182))))
> > > > >
> > > > > My question is how do i convert these to something i can use
> > with the
> > > > > xpermission statement in CIL, and why can seandroid sepolicy
> > get away
> > > > > with using 0x12345678 where i have to use 0x1234? I could not
> > find
> > > > > any scripts that converts these in the android tree.
> > > >
> > > > FWIW, I added a simple test of ioctl whitelisting to the
> > selinux-
> > > > testsuite, although that was done in source policy and depends
> > on the
> > > > binary module format support for xperms.
> > > >
> > > > With regard to your question though, only the low 16 bits of
> > the ioctl
> > > > value (the type/driver and number/function fields) are actually
> > used;
> > > > the upper 16 bits encode the direction (read/write) and size of
> > any
> > > > argument to the ioctl and are therefore not relevant for
> > whitelisting.
> > > > So you can just use 0x7182.  checkpolicy just ignores the upper
> > bits,
> > > > which I guess is convenient so that they can use ioctl macro
> > lists
> > > > generated from kernel header definitions, and Android builds by
> > using
> > > > checkpolicy -C to convert policy.conf to CIL.
> > >
> > > Thanks. I considered that but then I thought I saw various
> > different ioctls with the same last 16 bits so that got me confused
> > 
> > With the above in mind, how should i interpret the following
> > 
> > define(`CHIOEXCHANGE', `0x401c6302')
> > define(`CM_IOCSPTS', `0x40086302')
> > 
> > is "0x6203" CHIOEXCHANGE, is it CM_IOCSPTS, or are the two the same
> > with exception of direction and/or size
> > 
> > >
> > > --
> > > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B
> > 6B02
> > > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7
> > B6B02
> > > Dominick Grift
> > 
> > 
> > 
> > --
> > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B
> > 6B02
> > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6
> > B02
> > Dominick Grift
> > 
