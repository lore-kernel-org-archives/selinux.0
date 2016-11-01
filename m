Subject: Re: [PATCH] libselinux: fix compiler flags for linux + clang
To: William Roberts <bill.c.roberts@gmail.com>
References: <1478031804-13993-1-git-send-email-william.c.roberts@intel.com>
 <b092c650-20da-f76f-9af1-0f30bbc76458@tycho.nsa.gov>
 <CAFftDdoD-YY1fimeuHZ=O41VVoDD=S4s=71_7WckMTsA7x901A@mail.gmail.com>
 <383fec62-b1d3-80ab-85ec-38e9b19e340f@tycho.nsa.gov>
 <CAFftDdrS2QpL3R49Ds+TRRE6=_F8kMQcznaA9J50pXQO4EQjoA@mail.gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3eca3c8f-3b02-309e-577a-fec34a0e269f@tycho.nsa.gov>
Date: Tue, 1 Nov 2016 16:59:12 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdrS2QpL3R49Ds+TRRE6=_F8kMQcznaA9J50pXQO4EQjoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/01/2016 04:54 PM, William Roberts wrote:
> On Tue, Nov 1, 2016 at 1:55 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 11/01/2016 04:32 PM, William Roberts wrote:
>>> On Tue, Nov 1, 2016 at 1:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 11/01/2016 04:23 PM, william.c.roberts@intel.com wrote:
>>>>> From: William Roberts <william.c.roberts@intel.com>
>>>>>
>>>>> As reported by Nicolas Iooss, the clang + linux build seems
>>>>> broken:
>>>>>
>>>>>  clang-3.9: warning: argument unused during compilation: '-undefined
>>>>> dynamic_lookup'
>>>>>   /usr/bin/ld: unrecognised option: -install_name
>>>>>   clang-3.9: error: linker command failed with exit code 1 (use -v to
>>>>> see invocation)
>>>>>
>>>>> We already have those options set for Darwin, just drop them from the
>>>>> clang side.
>>>>
>>>> Thanks, applied.
>>>
>>> Did you check this with clang-3.9 locally and reproduce the error?
>>
>> Yes.  I think casting to void* will clear it.
> 
> That's what I was leaning towards myself.

Actually, if you just switch the parameter type for buf in both
functions to void*, everything is fine.
