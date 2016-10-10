Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9AF2cEc005446
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 11:02:38 -0400
Received: by mail-qt0-f173.google.com with SMTP id q7so56751298qtq.1
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 08:02:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Mon, 10 Oct 2016 08:02:07 -0700
Message-ID: <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
Subject: Re: should module_load be checked on a kernel module object?
To: Dominick Grift <dac.override@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When loading a kernel module using init_module the module is copied
from memory of the calling process. In that case, the target really is
the calling process. When using finit_module a file is passed to the
kernel and that file is the target object.

See the commit message that added module_load for a more complete
description: https://marc.info/?l=selinux&m=145988689809307&w=2

On Sun, Oct 9, 2016 at 1:10 AM, Dominick Grift <dac.override@gmail.com> wrote:
>
> I encountered a system module_load event for the first time today.
> Howver i am a bit surprised:
>
>
> avc:  denied  { module_load } for  pid=473 comm="modprobe"
> scontext=wheel.id:sysadm.role:lmc.subj:s0-s0:c0.c1023
> tcontext=wheel.id:sysadm.role:lmc.subj:s0-s0:c0.c1023 tclass=system
> permissive=1
>
> Should that permission not have applied to a kernel module object
> instead of "self"?
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
