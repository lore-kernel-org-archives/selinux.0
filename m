Message-ID: <53CE5A6F.4090301@tycho.nsa.gov>
Date: Tue, 22 Jul 2014 08:34:55 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: kuangjiou <kuangjiou@huawei.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: How to build a simplified refpolicy?
References: <60ABE64B4BE4AC45964F1A967BA76CB2BB42D9@SZXEML507-MBX.china.huawei.com>
In-Reply-To: <60ABE64B4BE4AC45964F1A967BA76CB2BB42D9@SZXEML507-MBX.china.huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/22/2014 05:16 AM, kuangjiou wrote:
> Hello,everyone!
> I am learnig SELinux recently and trying to enable the SELinux in
> Embedded Linux. As we know, the refpolicy has too much rules to use in
> the embedded devices and i also do not need so much rules in my policy.
> I just want to control the accesses to some targeted files and allow the
> accesses to the rest files. So is that possible to(and how can i) built
> my own simpolified policy to achieve this goal?   
> Could anybody give me some suggestions to resolve this problem? I am
>  looking  forward to your replies! Thank you very much!

In addition to Chris' suggestion of how you can in fact build a minimal
refpolicy, another alternative is to create a policy from scratch for
your embedded Linux.  This is what we did for Android, see our NDSS'13
paper and the policy in the AOSP tree.

http://internetsociety.org/doc/security-enhanced-se-android-bringing-flexible-mac-android

https://android.googlesource.com/platform/external/sepolicy
