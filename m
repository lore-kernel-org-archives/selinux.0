Subject: Re: DISABLE_AVC=y
To: William Roberts <bill.c.roberts@gmail.com>
References: <CAFftDdo3rRxW=qEzcLJbAABxJ09XmEK6_=x_6TiiZ5avxM9opQ@mail.gmail.com>
 <a1666e63-9f17-e61e-23ce-09ada3ff993a@tycho.nsa.gov>
 <CAFftDdo+WMWyZO0Wo4ofVfdr=41AocT12morEdb-PY=kCOAVpQ@mail.gmail.com>
 <4dfcb93c-7512-2987-7aae-418efa2443e6@tycho.nsa.gov>
 <CAFftDdo7vD0Gb2wfcOsQ87PJqP9urUh01XtDOH7mvfP9ANvt8g@mail.gmail.com>
 <140f34ab-ef19-ce66-c205-6ffa8cdbfae2@tycho.nsa.gov>
 <CAFftDdqYcF=JRHHJ2_GEkrWoePC1KHbKZTj7Xn_7fYnZDNDkxw@mail.gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d49a470e-8cd7-022f-bc85-ae3551b8cf90@tycho.nsa.gov>
Date: Wed, 28 Sep 2016 11:37:29 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdqYcF=JRHHJ2_GEkrWoePC1KHbKZTj7Xn_7fYnZDNDkxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 11:32 AM, William Roberts wrote:
> On Wed, Sep 28, 2016 at 11:24 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 09/28/2016 11:13 AM, William Roberts wrote:
>>> On Wed, Sep 28, 2016 at 11:10 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 09/28/2016 11:00 AM, William Roberts wrote:
>>>>> Same thing for DISABLE_BOOL, should that die or be fixed?
>>>>
>>>> Would that be useful for the Android device/target build, since they
>>>> don't support booleans?
>>>
>>> We don't compile the full source, thats how we avoid needing this,
>>> booleans.c isn't included.
>>>
>>>>
>>>> I don't believe there are any users of EMBEDDED=y.  DISABLE_SETRANS=y
>>>> and DISABLE_BOOL=y may make sense for Android (host and target builds).
>>>> DISABLE_RPM is enabled in Fedora/RHEL now because they have updated rpm
>>>> to use the more general setexecfilecon() interface introduced to support
>>>> other package managers.  So we may want to even make DISABLE_RPM=y the
>>>> default.  Technically that is an ABI break but since Red Hat is already
>>>> shipping it that way and rpm has been updated, I'm not sure it matters.
>>>
>>> Good to know, so I am looking at all of this in the context of we
>>> don't accidentally want to install
>>> with ANDROID_HOST=y. I'm thinking of something where we could write
>>> the variables to
>>> a .config file, and check for changes, if theirs a change, we could
>>> force a clean, so you always
>>> get what you want.
>>>
>>> ie:
>>>   $ make XXX=y
>>>   $ make install
>>>
>>> is always correct, for any given changes in build parameters, thoughts?
>>
>> I don't think we really need it.
>>
>> There was work a long time ago on autotools support for selinux; you can
>> see that in the autotools branch.  But they never ran it to completion,
>> and I'm not really a fan of autotools anyway.
> 
> Me either, so whats your though then on ANDROID_HOST=y, is installing
> it on accident a killer issue or
> user be careful?

There is already a warning in selinux/README about the potential for a
break by installing over your system libraries, since that is possible
even aside from ANDROID_HOST=y.  So I think it is fine.  I wasn't
planning to even mention ANDROID_HOST=y in the README because it is
really only for maintainers, not users.
