Message-ID: <1493318826.2524.21.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/3] selinux: add checksum to policydb
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, serge@hallyn.com, james.l.morris@oracle.com, Eric
 Paris <eparis@parisplace.org>, Paul Moore <paul@paul-moore.com>, Daniel
 Jurgens <danielj@mellanox.com>, Sebastien Buisson <sbuisson@ddn.com>
Date: Thu, 27 Apr 2017 14:47:06 -0400
In-Reply-To: <CAPkE-bVo7BO4WypVoeTiNBkbva1touoG2f7KjC3-RgvFXe3FXg@mail.gmail.com>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
 <1493218936-18522-2-git-send-email-sbuisson@ddn.com>
 <1493231426.32540.11.camel@tycho.nsa.gov>
 <CAPkE-bVPHAGDX2uSt41UanVwiaJ3trCTgkUJiPNKNGKYVPMikw@mail.gmail.com>
 <1493306283.2524.17.camel@tycho.nsa.gov>
 <CAPkE-bVo7BO4WypVoeTiNBkbva1touoG2f7KjC3-RgvFXe3FXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-04-27 at 19:12 +0200, Sebastien Buisson wrote:
> 2017-04-27 17:18 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> > Ok, that should work as long as you just want to validate that all
> > the
> > clients loaded the same policy file, and aren't concerned about
> > non-
> > persistent policy boolean changes.
> 
> As far as I understand, non-persistent policy boolean changes can
> affect the way the policy is enforced. So that is a problem if the
> checksum does not reflect it. We want to protect against someone
> tampering the policy locally on a Lustre client, even if it does not
> survive a reboot.

A boolean change can affect which TE rules in the policy are
enabled/disabled, but only in ways that are defined by the original
policy.  You can't add arbitrary TE rules that way, just enable/disable
blocks that were defined conditionally in the policy.  It also has no
effect on MLS enforcement, for example.  So it depends on your goals.

> I just checked, with the method of computing the checksum on a (data,
> len) pair on entry to security_load_policy() the checksum does not
> change after using setsebool. So it seems I would need to call
> security_read_policy() to retrieve the binary representation of the
> policy as currently enforced by the kernel. Unless you can see
> another
> way?

I don't think that's a viable option, since security_read_policy() is
going to be expensive in order to generate a full policy image, while
security_set_bools() is supposed to be substantially cheaper than a
full policy load.

Also, the advantage of taking the hash of the original input file is
that you can independently compute a reference hash offline or on the
server from the same policy file and compare them and you can identify
which policy file was loaded based on the hash.

If you care about the active boolean state, then I'd suggest hashing
the active boolean state separately and storing that after the policy
hash.  You can do that in both security_load_policy() and
security_set_bools().  Just iterate through the bools like
security_set_bools() does, write the ->state of each boolean into a
buffer, and then hash that buffer.

> > You needed to get (global) enforcing mode too, didn't you?  That's
> > separate from the policy.
> 
> Exactly, I also need to rework the patch I proposed about this, in
> light of the comments I received.

So perhaps what you really want is a hook interface and a selinuxfs
interface that returns a single string that encodes all of the policy
properties that you care about?  Rather than separate hooks and
interfaces?  You could embed the enforcing status in the string too. 
Should probably include checkreqprot as well since that affects
enforcement of mmap/mprotect checks.

> > Make sure you make the hash algorithm explicit in both what is
> > returned
> > by the hook to lustre and by what is exported via selinuxfs.  Can
> > likely just encode the hash algorithm name in the string when you
> > generate it.
> 
> Sure, I will add "sha256:" at the beginning of the string.
