MIME-Version: 1.0
In-Reply-To: <1493318826.2524.21.camel@tycho.nsa.gov>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
 <1493218936-18522-2-git-send-email-sbuisson@ddn.com>
 <1493231426.32540.11.camel@tycho.nsa.gov>
 <CAPkE-bVPHAGDX2uSt41UanVwiaJ3trCTgkUJiPNKNGKYVPMikw@mail.gmail.com>
 <1493306283.2524.17.camel@tycho.nsa.gov>
 <CAPkE-bVo7BO4WypVoeTiNBkbva1touoG2f7KjC3-RgvFXe3FXg@mail.gmail.com>
 <1493318826.2524.21.camel@tycho.nsa.gov>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Fri, 28 Apr 2017 17:16:50 +0200
Message-ID: <CAPkE-bUyWt8ovJ9pV+EFx9yUq9fVUy_G5yjEw7ZzLY3f3Ey1Aw@mail.gmail.com>
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

2017-04-27 20:47 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
>> I just checked, with the method of computing the checksum on a (data,
>> len) pair on entry to security_load_policy() the checksum does not
>> change after using setsebool. So it seems I would need to call
>> security_read_policy() to retrieve the binary representation of the
>> policy as currently enforced by the kernel. Unless you can see
>> another
>> way?
>
> I don't think that's a viable option, since security_read_policy() is
> going to be expensive in order to generate a full policy image, while
> security_set_bools() is supposed to be substantially cheaper than a
> full policy load.
>
> Also, the advantage of taking the hash of the original input file is
> that you can independently compute a reference hash offline or on the
> server from the same policy file and compare them and you can identify
> which policy file was loaded based on the hash.
>
> If you care about the active boolean state, then I'd suggest hashing
> the active boolean state separately and storing that after the policy
> hash.  You can do that in both security_load_policy() and
> security_set_bools().  Just iterate through the bools like
> security_set_bools() does, write the ->state of each boolean into a
> buffer, and then hash that buffer.

I just noticed another issue: with the method of computing the
checksum on a (data, len) pair on entry to security_load_policy(), the
checksum does not change after inserting a new module with semodule.
It is a problem as a module can allow actions by certain users on some
file contexts. So not detecting that kind of policy tampering defeats
the purpose of the checksum as I imagine it.

To address this I propose to come back to the idea of the notifier.
The checksum would not be stored inside the struct policydb. The
checksum would be computed on a (data, len) pair got from
security_read_policy() every time someone is asking for it through the
security_policy_cksum() hook. The ones that would potentially call
security_policy_cksum() are those that would register a callback on
lsm_notifier, and the userspace processes reading
/sys/fs/selinux/policycksum. So no matter if computing the checksum
gets expensive, that would be the caller's responsibility to use it
with care. Just like with /sys/fs/selinux/policy today in fact.

>> > You needed to get (global) enforcing mode too, didn't you?  That's
>> > separate from the policy.
>>
>> Exactly, I also need to rework the patch I proposed about this, in
>> light of the comments I received.
>
> So perhaps what you really want is a hook interface and a selinuxfs
> interface that returns a single string that encodes all of the policy
> properties that you care about?  Rather than separate hooks and
> interfaces?  You could embed the enforcing status in the string too.
> Should probably include checkreqprot as well since that affects
> enforcement of mmap/mprotect checks.

True, I should build a string of the form:
<0 or 1 for enforce>:<0 or 1 for checkreqprot>:<hashalg>=<global checksum>
I should probably rename it 'policybrief' instead of 'policycksum'.

I realize that the 'SELinux user to UNIX user' assignments are
important as well. If for instance a regular user on a given cluster
node is mapped to unconfined_u instead of user_u, this user would
erroneously have major privileges. I do not know where I should look
for this information, and possibly compute another checksum.
