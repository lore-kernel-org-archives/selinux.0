MIME-Version: 1.0
In-Reply-To: <CAPkE-bW45A-MKBZ53zyE--zuzsemyUaFy4_=vLFFF+H2Ujg=xQ@mail.gmail.com>
References: <1494928281-11128-1-git-send-email-sbuisson@ddn.com>
 <1494967240.21557.18.camel@tycho.nsa.gov>
 <CAPkE-bWykonYBssXGphktM7jANY_nbtQi7EVc4uLwjm-fdM8Kg@mail.gmail.com>
 <CAFftDdo=xDMNpC1F6M+w8Cr4=Ws8f-WyKm27EU_kv2ZE7ATHsQ@mail.gmail.com>
 <CAPkE-bV3DymWqYfkahxYLwSPy_G=YMzJMvc5jj3qJu1ywteJng@mail.gmail.com>
 <CAFftDdqtXKMkPOmrHx_RcwQuhi7e+Utqnh=4nn0O+4+wgAS=6Q@mail.gmail.com>
 <CAPkE-bU-XSQHobkAQzed+fM14sKku56oPq=P=KoCOwuUqcFosw@mail.gmail.com>
 <CAFftDdpHH5J18h7zUnYEv0Q++cLOdUqbUGptZHvwXpKh5WjEFw@mail.gmail.com>
 <CAPkE-bW45A-MKBZ53zyE--zuzsemyUaFy4_=vLFFF+H2Ujg=xQ@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 17 May 2017 11:28:16 -0700
Message-ID: <CAFftDdqh_7DW9zXvSA3isCXMDRNghaOMHJ5UQQJFYTTB8xf3ug@mail.gmail.com>
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

On Wed, May 17, 2017 at 10:00 AM, Sebastien Buisson
<sbuisson.ddn@gmail.com> wrote:
> 2017-05-17 18:04 GMT+02:00 William Roberts <bill.c.roberts@gmail.com>:
>> I'm assuming in the Lustre code you're going to call security_policy_brief(),
>> how would the caller know how big that buffer is going to be?
>
> We can determine it at configure time for instance, given that len as
> an output parameter would give the size necessary to store the policy
> brief info.
>
>> I'm looking at both v5 patches, I don't see where it's being called with alloc
>> set to false.
>
> It would be called with alloc set to false from network and
> distributed file systems like Lustre.

That doesn't seem like a good way at all.
1. What happens as the brief is changed, all callers with false
    would potentially need there buffer size increased.
2. There is no guarantee at runtime that as brief changes,
    that the size will remain bounded. fields could be
    added/changed/removed.
3. If/when stacking needs to be supported, brief size can
    change dramatically, bringing us back to issue 1.

-- 
Respectfully,

William C Roberts
