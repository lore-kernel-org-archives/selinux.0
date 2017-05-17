MIME-Version: 1.0
In-Reply-To: <CAFftDdpHH5J18h7zUnYEv0Q++cLOdUqbUGptZHvwXpKh5WjEFw@mail.gmail.com>
References: <1494928281-11128-1-git-send-email-sbuisson@ddn.com>
 <1494967240.21557.18.camel@tycho.nsa.gov>
 <CAPkE-bWykonYBssXGphktM7jANY_nbtQi7EVc4uLwjm-fdM8Kg@mail.gmail.com>
 <CAFftDdo=xDMNpC1F6M+w8Cr4=Ws8f-WyKm27EU_kv2ZE7ATHsQ@mail.gmail.com>
 <CAPkE-bV3DymWqYfkahxYLwSPy_G=YMzJMvc5jj3qJu1ywteJng@mail.gmail.com>
 <CAFftDdqtXKMkPOmrHx_RcwQuhi7e+Utqnh=4nn0O+4+wgAS=6Q@mail.gmail.com>
 <CAPkE-bU-XSQHobkAQzed+fM14sKku56oPq=P=KoCOwuUqcFosw@mail.gmail.com>
 <CAFftDdpHH5J18h7zUnYEv0Q++cLOdUqbUGptZHvwXpKh5WjEFw@mail.gmail.com>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Wed, 17 May 2017 19:00:25 +0200
Message-ID: <CAPkE-bW45A-MKBZ53zyE--zuzsemyUaFy4_=vLFFF+H2Ujg=xQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] selinux: add brief info to policydb
To: William Roberts <bill.c.roberts@gmail.com>
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

2017-05-17 18:04 GMT+02:00 William Roberts <bill.c.roberts@gmail.com>:
> I'm assuming in the Lustre code you're going to call security_policy_brief(),
> how would the caller know how big that buffer is going to be?

We can determine it at configure time for instance, given that len as
an output parameter would give the size necessary to store the policy
brief info.

> I'm looking at both v5 patches, I don't see where it's being called with alloc
> set to false.

It would be called with alloc set to false from network and
distributed file systems like Lustre.
