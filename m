Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2K0NRP2025174
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 20:23:28 -0400
Received: by wibdy8 with SMTP id dy8so4328757wib.0
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 17:23:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b9a113715934c985dbeec5c2351f06cd@vivaldi.net>
References: <e4247c48f0174b6f77f05c5b28bbcb9e@vivaldi.net>
 <b9a113715934c985dbeec5c2351f06cd@vivaldi.net>
Date: Thu, 19 Mar 2015 20:23:25 -0400
Message-ID: <CAN4BvJ_b0to61G42OtsV28DFyuv13DhxuGm_tyqeMDStieDd+w@mail.gmail.com>
Subject: Re: Trying to update sysadm module in CLIP
From: Brandon Whalen <brandon@quarksecurity.com>
To: John Chludzinski <john.chludzinski@vivaldi.net>
Content-Type: text/plain; charset=UTF-8
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 19, 2015 at 6:38 PM, John Chludzinski
<john.chludzinski@vivaldi.net> wrote:
> I ran (when under the role sysadm_r and type sysadm_t):
>
> $ id -Z
>
> and got: Xsysadm_u:sysadm_r:sysadm_t:s0
>
> So now I'm assuming the CLIP image is at "s0" sensitivity level.
>
> Then I noticed that the build.conf file states: "The sensitivities will be
> s0 to s(MLS_SENS-1)".
>
> So I built using:
>
> $ make modules APPS_MODS="sysadm" TYPE="mls" MLS_SENS=1
>
> to get an "s0" sensitivity level.
>
> Tried to install and now I get: "duplicate declaration in module:
> type/attribute sysadm_userhelper_t".

It looks like sysadm_userhelper_t is declared in the policy already.
Do you already have the sysadm module installed ' semodule -l' will
tell you? If not, maybe the sysadm module was included in the base
module.

> (A "Whac-A-Mole" game!)
>
> ---John
>
>
>
> On 2015-03-19 21:31, John Chludzinski wrote:
>>
>> First thing ... I'm a newbie to SELinux.
>>
>> I'm trying to update the sysadm module in a CLIP image. I downloaded
>> the SELinux policy code from: https://github.com/QuarkSecurity/CLIP.
>> I modified the sysadm policy code and built (in
>> ~/clip/packages/clip-selinux-policy/clip-selinux-policy) using:
>>
>> $ make modules APPS_MODS="sysadm"
>>
>> Then I tried to install in the CLIP image using:
>>
>> $ semodule -i /mnt/hdd/SELinix/sysadm.pp
>>
>> and got: "tried to link in a non-MLS module with an MLS base". (I
>> assume this means the CLIP image I'm working with is MLS?)
>> Next I built using:
>>
>> $ make modules APPS_MODS="sysadm" TYPE="mls"
>>
>> Tried to load/install the module and got: "sensitivy s10 not declared by
>> base."
>>
>> Next I tried:
>>
>> $ make modules APPS_MODS="auditadm sysadm" TYPE="mls" MLS_SENS=15
>>
>> and !still! got "sensitivy s10 not declared by base".
>>
>> Any suggestions/thoughts?
>>
>> ---John
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
