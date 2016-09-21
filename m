MIME-Version: 1.0
In-Reply-To: <CAFftDdpWzqwVRwGsgLTt03TxtEtoB3awO_3gpGutQw95r+4u9g@mail.gmail.com>
References: <476DC76E7D1DF2438D32BFADF679FC561CD0E4E2@ORSMSX103.amr.corp.intel.com>
 <32dd55fe-ff71-c6ea-8f00-f552d9523676@tycho.nsa.gov>
 <CAFftDdox4a7Enrgcj1qmbDBcbZ4KfdFfpnmwXcinQUw4UQvF6g@mail.gmail.com>
 <d3dcf9af-2bd0-5650-1fc6-f0e89e26d955@tycho.nsa.gov>
 <CAFftDdpWzqwVRwGsgLTt03TxtEtoB3awO_3gpGutQw95r+4u9g@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 21 Sep 2016 14:53:18 -0700
Message-ID: <CAFftDdrAOWTv9aLiVTjwctJB-KGQaFza7Utn=kOAf4TDwxpXAg@mail.gmail.com>
Subject: Re: unlocked stdio
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 21, 2016 at 2:48 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Sep 21, 2016 13:16, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>>
>> On 09/21/2016 04:11 PM, William Roberts wrote:
>> > On Sep 21, 2016 13:06, "Stephen Smalley" <sds@tycho.nsa.gov
>> > <mailto:sds@tycho.nsa.gov>> wrote:
>> >>
>> >> On 09/21/2016 03:57 PM, Roberts, William C wrote:
>> >> > Correction, it’s just fgets_unlocked, it appears to support the
>> >> > others.
>> >>
>> >> Seems like a bug in bionic, but we can work around it by:
>> >> #ifdef ANDROID
>> >> #define fgets_unlocked(x) fgets(x)
>> >> #endif
>> >>
>> >> in selinux_internal.h or some similar internal header.
>> >>
>> >> It avoids unnecessary locking overheads when dealing with FILE
>> >> descriptors that are only used locally and guaranteed to not be shared
>> >> by multiple threads.
>> >
>> > I know what it does and why, but was it really that necessary?
>>
>> The patch came from Red Hat.  Anyway, we use the _unlocked functions
>> throughout, and the fact that bionic supports all of them except that
>> one function suggests that we should just use a fix like the above
>> rather than dropping it.
>
> I'm not arguing the fix, just wondering if it was blazingly fast. I didn't
> find the definition or a define in bionic for fgets_unlocked, but when I set
> _GNUC define, it seemed to build OK.

That's an incorrect statement, that was only for the host built
against glibc where
_GNU_SOURCE needs to be defined. For Android, yes the simplest way is as
you suggest.


-- 
Respectfully,

William C Roberts
