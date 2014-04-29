Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3T4NjST021995
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 00:23:45 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so6636491pbb.36
 for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2014 21:23:45 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.86.94])
 by mx.google.com with ESMTPSA id vx10sm102298615pac.17.2014.04.28.21.23.43
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 28 Apr 2014 21:23:44 -0700 (PDT)
Message-ID: <535F28B2.5020803@gmail.com>
Date: Tue, 29 Apr 2014 09:51:06 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: No chance of using SELinux on rootfs without security namespace?
References: <535E0C0A.1000501@gmail.com>
 <CAB9W1A1qJqeg3x67x9te70tpEOSoQkvcFwjTzq=8dfLzeKsvew@mail.gmail.com>
In-Reply-To: <CAB9W1A1qJqeg3x67x9te70tpEOSoQkvcFwjTzq=8dfLzeKsvew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/28/14 19:42, Stephen Smalley wrote:
> It would be difficult at best, unless you are only using it for a
> minimalist root and everything else is on some other filesystem type.
> Without xattrs, you do not have per-file security labels and therefore
> cannot set up automatic domain transitions on any of the executables
> in that filesystem or otherwise distinguish any of those files in the
> policy.  Lack of xattr support in a native Linux filesystem is a
> significant drawback these days; xattrs are used not only for SELinux
> but also for ACLs, file capabilities, and various application purposes
> (user. namespace).  reiser4 isn't in mainline AFAIK.
>
> On Mon, Apr 28, 2014 at 1:06 AM, dE <de.techno@gmail.com> wrote:
>> I just realized -- my rootfs doesn't support xattr (reiser4).
>>
>> Is there any chance I can use SELinux?
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.

Thanks for clarifying that.

I'll try out SELinux in that fedora VM.
