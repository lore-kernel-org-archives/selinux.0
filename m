Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s465nRBv026832
 for <selinux@tycho.nsa.gov>; Tue, 6 May 2014 01:49:27 -0400
Received: by mail-ie0-f177.google.com with SMTP id rp18so9296577iec.36
 for <selinux@tycho.nsa.gov>; Mon, 05 May 2014 22:49:28 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.87.30])
 by mx.google.com with ESMTPSA id m1sm35085328igx.13.2014.05.05.22.49.26
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 05 May 2014 22:49:27 -0700 (PDT)
Message-ID: <53687749.1070709@gmail.com>
Date: Tue, 06 May 2014 11:16:49 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: How does policy loading work at bootup?
References: <5365CECF.5010808@gmail.com> <53677D27.9040802@tresys.com>
In-Reply-To: <53677D27.9040802@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/05/14 17:29, Christopher J. PeBenito wrote:
> On 05/04/2014 01:23 AM, dE wrote:
>> Does the kernel automatically searches for and reads the policies in hard coded locations or does some userspace tool does that at startup via init/systemd scripts/units?
> A long long time ago (before SELinux was accepted into Linus's tree), the kernel used to read the policy itself.  Now it is loaded by userspace, typically either by the init program, or by the initramfs.
>

Is it the semodule utility?
