MIME-Version: 1.0
In-Reply-To: <1493231426.32540.11.camel@tycho.nsa.gov>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
 <1493218936-18522-2-git-send-email-sbuisson@ddn.com>
 <1493231426.32540.11.camel@tycho.nsa.gov>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Thu, 27 Apr 2017 10:41:30 +0200
Message-ID: <CAPkE-bVPHAGDX2uSt41UanVwiaJ3trCTgkUJiPNKNGKYVPMikw@mail.gmail.com>
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

2017-04-26 20:30 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> This seems like an odd place to trigger the computation.

I noticed that the policy as exposed via /sys/fs/selinux/policy can
also be modified in security_set_bools(). So in order to limit the
places from where to compute the policy checksum, I moved the call to
checksum computation to selinux_lsm_notifier_avc_callback().
That being said, maybe the hash of /sys/fs/selinux/policy is not the
checksum we want. See your comments and my answers below.

> Why aren't you
> just computing it when the policy is loaded directly in
> security_load_policy()?  You already have the (data, len) on entry to
> that function.  Just compute it at load time, save it, and be done.  No
> need for a notifier then for your use case unless I am missing
> something.

You are right. Getting from the Lustre client code the SELinux
internally computed checksum is cheap, so no need to be notified every
time the policy changes, and no need to store the checksum in Lustre
at that time.
I will drop the "Implement LSM notification system" patch from this
series, as I cannot justify its usefulness from a Lustre client
standpoint anymore.

> I suppose the question is which checksum do you want - the hash of the
> policy file that was written to /sys/fs/selinux/load by userspace, or
> the hash of the policy file that the kernel generates on demand if you
> open /sys/fs/selinux/policy.  Those can differ in non-semantic ways due
> to ordering differences, for example.  I think the former is more
> likely to be of interest to userspace (e.g. to compare the hash value
> against the hash of the policy file), and is cheaper since you already
> have a (data, len) pair on entry to security_load_policy() that you can
> hash immediately rather than requiring the kernel to regenerate the
> image from the policydb.

OK, I understand now why I was seeing differences between the checksum
computed on a (data, len) pair on entry to security_load_policy(), and
the checksum computed on a (data, len) pair got from
security_read_policy().
I thought it was a problem to have a difference between the internally
computed checksum and the one a user can get by calling sha256sum on
/sys/fs/selinux/policy. But now I see it makes sense to reflect what
was loaded by userspace. So I will simplify this patch accordingly.
