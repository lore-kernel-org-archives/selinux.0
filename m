MIME-Version: 1.0
In-Reply-To: <CAFftDdo=xDMNpC1F6M+w8Cr4=Ws8f-WyKm27EU_kv2ZE7ATHsQ@mail.gmail.com>
References: <1494928281-11128-1-git-send-email-sbuisson@ddn.com>
 <1494967240.21557.18.camel@tycho.nsa.gov>
 <CAPkE-bWykonYBssXGphktM7jANY_nbtQi7EVc4uLwjm-fdM8Kg@mail.gmail.com>
 <CAFftDdo=xDMNpC1F6M+w8Cr4=Ws8f-WyKm27EU_kv2ZE7ATHsQ@mail.gmail.com>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Wed, 17 May 2017 17:24:09 +0200
Message-ID: <CAPkE-bV3DymWqYfkahxYLwSPy_G=YMzJMvc5jj3qJu1ywteJng@mail.gmail.com>
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

2017-05-17 17:09 GMT+02:00 William Roberts <bill.c.roberts@gmail.com>:
> On Wed, May 17, 2017 at 7:59 AM, Sebastien Buisson
> <sbuisson.ddn@gmail.com> wrote:
>> 2017-05-16 22:40 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
>>>> +     strcpy(*brief, policydb.policybrief);
>>>> +     /* *len is the length of the output string */
>>>> +     *len = policybrief_len - 1;
>>>
>>> Is there a particular reason to not just return policybrief_len here as
>>> well, for consistency in the interface?  How do you intend to use this
>>> value in the caller?
>>
>> As called in the other patch to expose policy brief via selinuxfs
>> (sel_read_policybrief), the intent is to provide the caller with the
>> length of the string returned.
>> Or should I set *len to policy brief_len here, and just make the
>> caller aware that the returned length is in fact the length of the
>> buffer (i.e. including terminating NUL byte)?
>
> What is the caller supposed to do with length? This interface seemed kind of
> odd. If it's guaranteed NUL byte terminated, do they even need length?

The length is useful as an input parameter in case the caller provides
its own buffer (instead of letting the function allocate one), and as
an output parameter in case the buffer given in input is not large
enough.
In any case, it can spare the caller the effort of recomputing the
length. As an example, sel_read_policybrief() in the 2/2 patch needs
to know the length of the string to put in the user buffer.
