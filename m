Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t59HaPue028441
 for <selinux@tycho.nsa.gov>; Tue, 9 Jun 2015 13:36:25 -0400
Received: by vnbg7 with SMTP id g7so3954267vnb.10
 for <selinux@tycho.nsa.gov>; Tue, 09 Jun 2015 10:36:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTZ=gUTDhBuPwb7b3=Y_rjodHneMyK2K2v=LtVqbiYY5w@mail.gmail.com>
References: <1430337372-7758-1-git-send-email-jeffv@google.com>
 <3147722.RboehMiu35@sifl> <555DD091.8060307@tycho.nsa.gov>
 <CAHC9VhTX8k2gSVBZaX_68b11OzBxFhWbkLrHfpjZ=v0h=82Ceg@mail.gmail.com>
 <555DEA32.4080205@tycho.nsa.gov>
 <CAHC9VhQSA7KuDwL3x45iShSGgsd11Yv3vS=_O4BN_S=fhvrQgg@mail.gmail.com>
 <CABXk95ARYdCokbGYLW8REPjx_qH-X--xsZcCmLnRoGU7KP+nZQ@mail.gmail.com>
 <CAHC9VhTmrJciwdkjGaMjx2RhyrS_En6JZF-pxWiWoz8geF_f3w@mail.gmail.com>
 <CABXk95BzUMsq72Nr-r=oZjttVyq3kwUeWOJfG9mxboSAYS09bg@mail.gmail.com>
 <CAHC9VhTZ=gUTDhBuPwb7b3=Y_rjodHneMyK2K2v=LtVqbiYY5w@mail.gmail.com>
Date: Tue, 9 Jun 2015 10:36:19 -0700
Message-ID: <CAFJ0LnE4rBF+hRFgXBn4M2CbWSttu33CAPuBzHfH3N7+h59s3A@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] SELinux: per-command whitelisting of ioctls
From: Nick Kralevich <nnk@google.com>
To: Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks again Paul for taking the time to review these patches. I'm
quite excited about getting these patches into the mainline kernel,
since reducing ioctl attack surface is a big goal of Android's.

Just FYI: the original version of the patches are now shipping with
the Android M preview release
(https://developer.android.com/preview/download.html), so if you're
interested in trying it out, please do. We're doing ioctl filtering on
tcp/udp socket file descriptors, and so far we haven't seen any bugs
from this code.


On Wed, Jun 3, 2015 at 2:01 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Jun 3, 2015 at 2:40 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
>> Ok, I have finished a revision that addresses your comments (will
>> email out shortly). You'll be happy to hear that I am using "extended
>> permissions" instead of "operations."
>>
>> I tried to focus on:
>>
>> -Creating a stable binary policy format that will work for ioctls and
>> netlink (and others) such that the policy version XPERMS_IOCTL will
>> remain valid if/when version XPERMS_NETLINK is added
>
> Great, thank you.  I realize we may need to change it when we get
> there, but I appreciate the effort.
>
>> -Keeping the current version simple, don’t partially add logic for
>> selecting between ioctl/netlink in the AVC. I originally started
>> adding additional components to the avc structures, but a few
>> questions came up that Stephen and I did not know the answer to. It
>> makes sense to punt these decisions to if/when the netlink extended
>> permissions capability is actually added (saves memory in the
>> meantime). The internals can change as long as the binary policy is
>> stable.
>
> That sounds fine to me.
>
> --
> paul moore
> www.paul-moore.com



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
