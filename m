MIME-Version: 1.0
In-Reply-To: <797dc1df-784b-97e5-1c68-03005d3cad97@tycho.nsa.gov>
References: <1479256943-26743-1-git-send-email-william.c.roberts@intel.com>
 <797dc1df-784b-97e5-1c68-03005d3cad97@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 16 Nov 2016 06:01:27 -0800
Message-ID: <CAFftDdrsvfRCPcEmrkRt=Bh3OAGn=7bcpK6shNBBXukTeCogBA@mail.gmail.com>
Subject: Re: [PATCH take2 v6] libsepol: fix checkpolicy dontaudit compiler bug
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 Nick Kralevich <nnk@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 16, 2016 at 5:54 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/15/2016 07:42 PM, william.c.roberts@intel.com wrote:
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> The combining logic for dontaudit rules was wrong, causing
>> a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
>> rule.
>>
>> This is a reimplementation of:
>> commit 6201bb5e258e2b5bcc04d502d6fbc05c69d21d71 ("libsepol:
>> fix checkpolicy dontaudit compiler bug")
>> that avoids the cumbersome pointer assignments on alloced.
>
> Thanks, applied both patches (revert and reimplementation).

These line numbers might not line up, but it was inconsistent, so I didn't know:
1702:    typemap ? typemap[cur->data - 1] : cur->data;
2958: to_be_appended = (cur_state == 1) ?

<snip>
