MIME-Version: 1.0
In-Reply-To: <CAPkE-bU-XSQHobkAQzed+fM14sKku56oPq=P=KoCOwuUqcFosw@mail.gmail.com>
References: <1494928281-11128-1-git-send-email-sbuisson@ddn.com>
 <1494967240.21557.18.camel@tycho.nsa.gov>
 <CAPkE-bWykonYBssXGphktM7jANY_nbtQi7EVc4uLwjm-fdM8Kg@mail.gmail.com>
 <CAFftDdo=xDMNpC1F6M+w8Cr4=Ws8f-WyKm27EU_kv2ZE7ATHsQ@mail.gmail.com>
 <CAPkE-bV3DymWqYfkahxYLwSPy_G=YMzJMvc5jj3qJu1ywteJng@mail.gmail.com>
 <CAFftDdqtXKMkPOmrHx_RcwQuhi7e+Utqnh=4nn0O+4+wgAS=6Q@mail.gmail.com>
 <CAPkE-bU-XSQHobkAQzed+fM14sKku56oPq=P=KoCOwuUqcFosw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 17 May 2017 09:04:28 -0700
Message-ID: <CAFftDdpHH5J18h7zUnYEv0Q++cLOdUqbUGptZHvwXpKh5WjEFw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] selinux: add brief info to policydb
To: Sebastien Buisson <sbuisson.ddn@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org,
 Sebastien Buisson <sbuisson@ddn.com>,
 James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 17, 2017 at 8:43 AM, Sebastien Buisson
<sbuisson.ddn@gmail.com> wrote:
> 2017-05-17 17:34 GMT+02:00 William Roberts <bill.c.roberts@gmail.com>:
>>>>>> Is there a particular reason to not just return policybrief_len here as
>>>>>> well, for consistency in the interface?  How do you intend to use this
>>>>>> value in the caller?
>>>>>
>>>>> As called in the other patch to expose policy brief via selinuxfs
>>>>> (sel_read_policybrief), the intent is to provide the caller with the
>>>>> length of the string returned.
>>>>> Or should I set *len to policy brief_len here, and just make the
>>>>> caller aware that the returned length is in fact the length of the
>>>>> buffer (i.e. including terminating NUL byte)?
>>>>
>>>> What is the caller supposed to do with length? This interface seemed kind of
>>>> odd. If it's guaranteed NUL byte terminated, do they even need length?
>>>
>>> The length is useful as an input parameter in case the caller provides
>>> its own buffer (instead of letting the function allocate one), and as
>>
>> This is what I don't get, why doesn't the function just always allocate?
>
> For performance reasons mainly. The caller would have a statically
> allocated buffer, reused every time it needs to get the policy brief
> info.

I'm assuming in the Lustre code you're going to call security_policy_brief(),
how would the caller know how big that buffer is going to be?

I'm looking at both v5 patches, I don't see where it's being called with alloc
set to false.

I don't see how this works with LSM stacking, I would imagine the security
hook needs to call this routine for each LSM and join them together in
some module name spaced way, which was mentioned before, but I don't
see that either, am I missing it?


-- 
Respectfully,

William C Roberts
