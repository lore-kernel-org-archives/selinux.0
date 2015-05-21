Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LEfwLr015126
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:41:59 -0400
Received: by qkgx75 with SMTP id x75so56110446qkg.1
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 07:41:57 -0700 (PDT)
Message-ID: <555DEEB5.9060602@quarksecurity.com>
Date: Thu, 21 May 2015 10:41:57 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555D3E20.7050907@quarksecurity.com>
 <CABXk95CESxmfTbmpTyx0_jkj3TXs6EEYeZwo_Jpri0nAVtUCDg@mail.gmail.com>
 <CAHC9VhQDg6S9UObCqCLQgg=V6_5Lj7BSQ-LYfRLGGLMZOoaoGQ@mail.gmail.com>
 <555DDF2C.3010606@quarksecurity.com>
 <CAHC9VhSeZA_qKK_7L94C24LsctATj5etRK7bayO2W6TfmimwOg@mail.gmail.com>
 <555DE8A4.2050000@quarksecurity.com>
 <CAHC9VhSpbMSu2HYMkvt=GsYtara1v+DSbaSHZfa2bWbFAUSYwQ@mail.gmail.com>
 <555DEA4E.4000807@quarksecurity.com>
 <CAHC9VhRBD7W+oA3nZ3WDAQUYFg88n1WzrshRJGE_+XMKkMYUtw@mail.gmail.com>
In-Reply-To: <CAHC9VhRBD7W+oA3nZ3WDAQUYFg88n1WzrshRJGE_+XMKkMYUtw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore wrote:
> On Thu, May 21, 2015 at 10:23 AM, Joshua Brindle
> <brindle@quarksecurity.com>  wrote:
>> Paul Moore wrote:
>>> You've got the ioctl numbers in the binary policy, which are the same
>>> numbers used in the policy representation, which are also the same
>>> numbers used by applications actually making use of the ioctl()
>>> syscall.  Other than the fact that these things are numbers and not a
>>> more conventional label string, I don't understand the problem.
>> That is precisely the problem. I'd like any extra symbolic information
>> (e.g., calling this range of ioctls gpu_op) preserved and not thrown away by
>> m4.
>>
>> Some of us work on binary only systems where we don't get to see the source
>> code of the applications or the policy.
>
> Sorry, I keep forgetting you are special.  Thanks for the multiple reminders.
>
> I suggest talking with James and the CIL folks to arrive at some
> solution that works well with CIL, whatever that might be.  As for the
> checkpolicy based policy, I think m4 is just fine if folks want to use
> it; there is no requirement that m4 must be used for this.
>
> Further, if we do need to introduce some attribute like construct for
> these operations/ranges/permissions/whatever-we-call-them, I'm okay
> adding that in a future patchset, I see no reason to hold up this
> initial work for that.

It seems like some adjustments are being made anyway. I wish I'd brought 
this up when the patches were first posted so it is definitely my fault 
if it doesn't happen.

I doubt you'd want to be on the hook to analyze a policy that just dumps 
a wall of hex values instead of descriptive symbols though. This is the 
exact reason that attribute names are now preserved in the kernel 
binary, despite the kernel not needing them.
