Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6MCIdRN027438
 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2014 08:18:39 -0400
Message-ID: <53CE5685.9060307@tresys.com>
Date: Tue, 22 Jul 2014 08:18:13 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: kuangjiou <kuangjiou@huawei.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: How to build a simplified refpolicy?
References: <60ABE64B4BE4AC45964F1A967BA76CB2BB42D9@SZXEML507-MBX.china.huawei.com>
In-Reply-To: <60ABE64B4BE4AC45964F1A967BA76CB2BB42D9@SZXEML507-MBX.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/22/2014 5:16 AM, kuangjiou wrote:
> Hello,everyone!
> I am learnig SELinux recently and trying to enable the SELinux in
> Embedded Linux. As we know, the refpolicy has too much rules to use in
> the embedded devices and i also do not need so much rules in my policy.
> I just want to control the accesses to some targeted files and allow the
> accesses to the rest files. So is that possible to(and how can i) built
> my own simpolified policy to achieve this goal?   
> Could anybody give me some suggestions to resolve this problem? I am
>  looking  forward to your replies! Thank you very much!

You should be able to compile refpolicy with just the kernel layer
modules.  Then the only domain you'd have is kernel_t plus types for
handling devices and base files.

Note: this discussion is best for the refpolicy mail list instead.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
