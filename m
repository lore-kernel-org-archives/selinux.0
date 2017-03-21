Message-ID: <1490121984.2050.3.camel@tycho.nsa.gov>
Subject: Re: Bug#857660: SELinux: cannot sent policyload notice
From: Stephen Smalley <sds@tycho.nsa.gov>
To: cgzones <cgzones@googlemail.com>, selinux <selinux@tycho.nsa.gov>
Cc: 857660@bugs.debian.org
Date: Tue, 21 Mar 2017 14:46:24 -0400
In-Reply-To: <CAJ2a_DdCveafhom+5-VHW-Bi7kTNvDx0x2u=-dhKW2x81Q+QFQ@mail.gmail.com>
References: <CAJ2a_DcAMXXj5+LZeHsRqARfEmbCCpwfVt2fBiana5rH4mWEGA@mail.gmail.com>
 <20170313220715.4mbrqzwcr3xzrcr2@perpetual.pseudorandom.co.uk>
 <CAJ2a_DdCveafhom+5-VHW-Bi7kTNvDx0x2u=-dhKW2x81Q+QFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-03-14 at 00:11 +0100, cgzones wrote:
> Hi list,
> I created bug report against dbus 1.10 on Debian [1] due to failing
> to
> send policyload notices.
> Are there any objections or comments on the upstream patch[2]?

Also, the patch looks correct to me.

> The patch works for me:
> 
> Mar 14 00:01:36 debianSE audit[441]: USER_AVC pid=441 uid=105
> auid=4294967295 ses=4294967295
> subj=system_u:system_r:system_dbusd_t:s0-s0:c0.c1023 msg='avc:
> received policyload notice (seqno=3)
>                                      exe="/usr/bin/dbus-daemon"
> sauid=105 hostname=? addr=? terminal=?'
> Mar 14 00:01:36 debianSE dbus[441]: [system] Reloaded configuration
> 
> Best regards,
>        Christian Göttsche
> 
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=857660
> [2] https://cgit.freedesktop.org/dbus/dbus/commit/?id=a3a5935a0a038c3
> b44c61ce5719f0f7e647b96c6
