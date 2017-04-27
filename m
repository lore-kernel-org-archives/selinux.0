MIME-Version: 1.0
In-Reply-To: <1493306283.2524.17.camel@tycho.nsa.gov>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
 <1493218936-18522-2-git-send-email-sbuisson@ddn.com>
 <1493231426.32540.11.camel@tycho.nsa.gov>
 <CAPkE-bVPHAGDX2uSt41UanVwiaJ3trCTgkUJiPNKNGKYVPMikw@mail.gmail.com>
 <1493306283.2524.17.camel@tycho.nsa.gov>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Thu, 27 Apr 2017 19:12:17 +0200
Message-ID: <CAPkE-bVo7BO4WypVoeTiNBkbva1touoG2f7KjC3-RgvFXe3FXg@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: add checksum to policydb
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, serge@hallyn.com, james.l.morris@oracle.com,
 Eric Paris <eparis@parisplace.org>, Paul Moore <paul@paul-moore.com>,
 Daniel Jurgens <danielj@mellanox.com>, Sebastien Buisson <sbuisson@ddn.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-04-27 17:18 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> Ok, that should work as long as you just want to validate that all the
> clients loaded the same policy file, and aren't concerned about non-
> persistent policy boolean changes.

As far as I understand, non-persistent policy boolean changes can
affect the way the policy is enforced. So that is a problem if the
checksum does not reflect it. We want to protect against someone
tampering the policy locally on a Lustre client, even if it does not
survive a reboot.
I just checked, with the method of computing the checksum on a (data,
len) pair on entry to security_load_policy() the checksum does not
change after using setsebool. So it seems I would need to call
security_read_policy() to retrieve the binary representation of the
policy as currently enforced by the kernel. Unless you can see another
way?

> You needed to get (global) enforcing mode too, didn't you?  That's
> separate from the policy.

Exactly, I also need to rework the patch I proposed about this, in
light of the comments I received.

> Make sure you make the hash algorithm explicit in both what is returned
> by the hook to lustre and by what is exported via selinuxfs.  Can
> likely just encode the hash algorithm name in the string when you
> generate it.

Sure, I will add "sha256:" at the beginning of the string.
