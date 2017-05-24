Message-ID: <1495656704.3489.4.camel@tycho.nsa.gov>
Subject: Re: ioctl help
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Wed, 24 May 2017 16:11:44 -0400
In-Reply-To: <20170524120854.GA1910@julius.enp8s0.d30>
References: <20170524120854.GA1910@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-24 at 14:08 +0200, Dominick Grift wrote:
> I was looking again at ioctl whitelisting, and excuse me if I
> overlooked some documentation, but I am having a hard time
> implementing this.
> what I did was I just wanted to basically test blacklisting a single
> ioctl (no particular one)
> 
> So i looked into androids sepolicy and just picked a semi-random
> ioctl from their "https://android.googlesource.com/platform/system/se
> policy/+/master/public/ioctl_defines"
> 
> for example: PHONE_CAPABILITIES_CHECK 0x40087182
> 
> However the xpermissions statement only allows 0x0000 to 0xFFFF when
> i tried: (xpermission alg_socket_ioctl (ioctl alg_socket (not
> (0x40087182))))
> 
> My question is how do i convert these to something i can use with the
> xpermission statement in CIL, and why can seandroid sepolicy get away
> with using 0x12345678 where i have to use 0x1234? I could not find
> any scripts that converts these in the android tree.

FWIW, I added a simple test of ioctl whitelisting to the selinux-
testsuite, although that was done in source policy and depends on the
binary module format support for xperms.

With regard to your question though, only the low 16 bits of the ioctl
value (the type/driver and number/function fields) are actually used;
the upper 16 bits encode the direction (read/write) and size of any
argument to the ioctl and are therefore not relevant for whitelisting.
So you can just use 0x7182.  checkpolicy just ignores the upper bits,
which I guess is convenient so that they can use ioctl macro lists
generated from kernel header definitions, and Android builds by using
checkpolicy -C to convert policy.conf to CIL.
