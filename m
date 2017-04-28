MIME-Version: 1.0
In-Reply-To: <1493394641.6177.8.camel@tycho.nsa.gov>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
 <1493218936-18522-2-git-send-email-sbuisson@ddn.com>
 <1493231426.32540.11.camel@tycho.nsa.gov>
 <CAPkE-bVPHAGDX2uSt41UanVwiaJ3trCTgkUJiPNKNGKYVPMikw@mail.gmail.com>
 <1493306283.2524.17.camel@tycho.nsa.gov>
 <CAPkE-bVo7BO4WypVoeTiNBkbva1touoG2f7KjC3-RgvFXe3FXg@mail.gmail.com>
 <1493318826.2524.21.camel@tycho.nsa.gov>
 <CAPkE-bUyWt8ovJ9pV+EFx9yUq9fVUy_G5yjEw7ZzLY3f3Ey1Aw@mail.gmail.com>
 <1493394641.6177.8.camel@tycho.nsa.gov>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Fri, 28 Apr 2017 18:08:07 +0200
Message-ID: <CAPkE-bWd0ArebM+8Vm5ZCQd90avZQ5sPSAR_2P5Y1brK5wKwJQ@mail.gmail.com>
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

2017-04-28 17:50 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> You seem to be conflating kernel policy with userspace policy.
> security_load_policy() is provided with the kernel policy image, which
> is the result of linking the kernel-relevant portions of all policy
> modules together. A hash of that image will change if you insert a
> policy module that affects the kernel policy in any way.  But a change
> that only affects userspace policy isn't ever going to be reflected in
> the kernel.  It doesn't matter where or when you compute your checksum
> within the kernel; it isn't ever going to reflect those userspace
> policy changes.

Here is the content of the module is used for my tests:

#============= user_t ==============
allow user_t mnt_t:dir { write add_name };
allow user_t mnt_t:file { write create };

After loading the .pp corresponding to it, I can see that with the
method of computing the checksum on the (data, len) pair on entry to
security_load_policy(), the checksum does not change. However, when
using the (data, len) pair got from
security_read_policy(), the checksum changes. And when I remove the
module, the checksum is back to its previous value.
So this is what makes me think there is a difference. Am I missing something?
