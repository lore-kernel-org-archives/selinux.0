Subject: Re: unlocked stdio
To: William Roberts <bill.c.roberts@gmail.com>
References: <476DC76E7D1DF2438D32BFADF679FC561CD0E4E2@ORSMSX103.amr.corp.intel.com>
 <32dd55fe-ff71-c6ea-8f00-f552d9523676@tycho.nsa.gov>
 <CAFftDdox4a7Enrgcj1qmbDBcbZ4KfdFfpnmwXcinQUw4UQvF6g@mail.gmail.com>
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov,
 "Roberts, William C" <william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d3dcf9af-2bd0-5650-1fc6-f0e89e26d955@tycho.nsa.gov>
Date: Wed, 21 Sep 2016 16:18:43 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdox4a7Enrgcj1qmbDBcbZ4KfdFfpnmwXcinQUw4UQvF6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/21/2016 04:11 PM, William Roberts wrote:
> On Sep 21, 2016 13:06, "Stephen Smalley" <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
>>
>> On 09/21/2016 03:57 PM, Roberts, William C wrote:
>> > Correction, it’s just fgets_unlocked, it appears to support the others.
>>
>> Seems like a bug in bionic, but we can work around it by:
>> #ifdef ANDROID
>> #define fgets_unlocked(x) fgets(x)
>> #endif
>>
>> in selinux_internal.h or some similar internal header.
>>
>> It avoids unnecessary locking overheads when dealing with FILE
>> descriptors that are only used locally and guaranteed to not be shared
>> by multiple threads.
> 
> I know what it does and why, but was it really that necessary?

The patch came from Red Hat.  Anyway, we use the _unlocked functions
throughout, and the fact that bionic supports all of them except that
one function suggests that we should just use a fix like the above
rather than dropping it.
