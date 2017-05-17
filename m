MIME-Version: 1.0
In-Reply-To: <CAPkE-bWykonYBssXGphktM7jANY_nbtQi7EVc4uLwjm-fdM8Kg@mail.gmail.com>
References: <1494928281-11128-1-git-send-email-sbuisson@ddn.com>
 <1494967240.21557.18.camel@tycho.nsa.gov>
 <CAPkE-bWykonYBssXGphktM7jANY_nbtQi7EVc4uLwjm-fdM8Kg@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 17 May 2017 08:09:46 -0700
Message-ID: <CAFftDdo=xDMNpC1F6M+w8Cr4=Ws8f-WyKm27EU_kv2ZE7ATHsQ@mail.gmail.com>
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

On Wed, May 17, 2017 at 7:59 AM, Sebastien Buisson
<sbuisson.ddn@gmail.com> wrote:
> 2017-05-16 22:40 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
>>> +     strcpy(*brief, policydb.policybrief);
>>> +     /* *len is the length of the output string */
>>> +     *len = policybrief_len - 1;
>>
>> Is there a particular reason to not just return policybrief_len here as
>> well, for consistency in the interface?  How do you intend to use this
>> value in the caller?
>
> As called in the other patch to expose policy brief via selinuxfs
> (sel_read_policybrief), the intent is to provide the caller with the
> length of the string returned.
> Or should I set *len to policy brief_len here, and just make the
> caller aware that the returned length is in fact the length of the
> buffer (i.e. including terminating NUL byte)?

What is the caller supposed to do with length? This interface seemed kind of
odd. If it's guaranteed NUL byte terminated, do they even need length?
