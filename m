Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2LDvcD2031606
 for <selinux@tycho.nsa.gov>; Sat, 21 Mar 2015 09:57:38 -0400
Received: by weop45 with SMTP id p45so102653477weo.0
 for <selinux@tycho.nsa.gov>; Sat, 21 Mar 2015 06:57:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d1147ae9bfd084f0760cb8457e3cf228@vivaldi.net>
References: <e4247c48f0174b6f77f05c5b28bbcb9e@vivaldi.net>
 <b9a113715934c985dbeec5c2351f06cd@vivaldi.net>
 <CAGNxgPiBThm0SpAo-+1D2UsaFyVNY2AKpj56RFvt+8SrfxL-Jw@mail.gmail.com>
 <d1147ae9bfd084f0760cb8457e3cf228@vivaldi.net>
Date: Sat, 21 Mar 2015 09:57:35 -0400
Message-ID: <CAN4BvJ_qaxeCexu3xc4QRWuDjFPQ=i2A-9dQEs58w2mYvo5zPg@mail.gmail.com>
Subject: Re: Trying to update sysadm module in CLIP
From: Brandon Whalen <brandon@quarksecurity.com>
To: John Chludzinski <john.chludzinski@vivaldi.net>
Content-Type: text/plain; charset=UTF-8
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 20, 2015 at 6:14 PM, John Chludzinski
<john.chludzinski@vivaldi.net> wrote:
> 1) I noticed
> packages/clip-selinux-policy/clip-selinux-policy/policy/modules.conf defines
> the the modules that are built into a base.pp:
>
> packages/clip-selinux-policy/clip-selinux-policy/ > make base TYPE="mls"
> MLS_SENS=1
>
> which includes sysadm. Is this something of any interest?
>
> 2) Reading the output from:
>
> packages/clip-selinux-policy/ > make rpm
>
> I noticed it contains: "Compiling clip base module", which compiles all the
> *.te files.
>
> which, of course, includes sysadm.
>
> The files created are: clip-selinux-policy-6.2.0-1.noarch.rpm,
> clip-selinux-policy-6.2.0-1.src.rpm, clip-selinux-policy-6.2.0.tar.gz.
>
> Should install clip-selinux-policy-6.2.0-1.noarch.rpm?

In your modules.conf is sysadm listed as base? Looking at [1] it looks
like by default CLIP puts sysadm in base. If that was the case when
you first built and installed, you could just rebuild it into base and
replace the base module.

[1] https://github.com/QuarkSecurity/CLIP/blob/master/packages/clip-selinux-policy/clip-selinux-policy/policy/modules.conf

>
> 3) If I'm making small modifications to one of the canonical CLIP modules
> (system, role, etc.) is there something less that replacing the policy tree?
> That's why I build the sysadm.pp.

Yes, you can do this, but the problem is that I believe you started
with sysadm in the base module. Another option, that I _think_ will
work is to make sysadm a module by updating modules.conf, rebuild the
modules, and then reinstall the base.pp and the sysadm.pp. This will
remove the sysadm declarations from base and let you just update the
sysadm.pp instead.

>
> 4) If I'm creating policies unique to this project, should I create a
> directory under policy/modules/<project> and run: make conf? Use LOCAL_ROOT
> to point to a policy source tree hanging off the project root? Just trying
> to come up with some process/strategy that's flexible and defensible. Of
> course LOCAL_ROOT is defined in the Makefile in
> packages/clip-selinux-policy/clip-selinux-policy and I'd be building *.pp
> files? Maybe this is OK for new policy code?

This is something we do fairly often and it really just depends on
what you'd like to do. When working on large scale projects that have
a lot of their own components I often create a custom layer just for
the project I'm working on. I've found that even when I do that I
often have to modify other parts of the policy to make things work. If
you are only adding a couple things it's probably not worth it though.
I'd just put the modules into the appropriate layers. This [2] shows
how to add a layer in to reference policy which is what you're talking
about doing. Then you have to update modules.conf to add in the new
modules for that layer. By default as long as you have not listed a
module as off in the modules.conf file CLIP should put that module in
the RPM that gets installed.

[2] http://www.freetechbooks.com/efiles/selinuxnotebook/The_SELinux_Notebook_The_Foundations_3rd_Edition.pdf

>
>
> ---John
>
>
>
> Been inspecting the "other" make (in packages/clip-selinux-policy v.
> packages/clip-selinux-policy/clip-selinux-policy).
>
> On 2015-03-20 00:33, Spencer Shimko wrote:
>>
>> Trimmed SELinux mailing list form CCs.
>>
>> Did you try the the suggestions in my on-list response a little while ago?
>>
>> On Thu, Mar 19, 2015 at 6:38 PM, John Chludzinski
>> <john.chludzinski@vivaldi.net> wrote:
>>>
>>> I ran (when under the role sysadm_r and type sysadm_t):
>>>
>>> $ id -Z
>>>
>>> and got: Xsysadm_u:sysadm_r:sysadm_t:s0
>>>
>>> So now I'm assuming the CLIP image is at "s0" sensitivity level.
>>>
>>> Then I noticed that the build.conf file states: "The sensitivities will
>>> be
>>> s0 to s(MLS_SENS-1)".
>>>
>>> So I built using:
>>>
>>> $ make modules APPS_MODS="sysadm" TYPE="mls" MLS_SENS=1
>>>
>>> to get an "s0" sensitivity level.
>>>
>>> Tried to install and now I get: "duplicate declaration in module:
>>> type/attribute sysadm_userhelper_t".
>>> (A "Whac-A-Mole" game!)
>>>
>>> ---John
>>>
>>>
>>> On 2015-03-19 21:31, John Chludzinski wrote:
>>>>
>>>>
>>>> First thing ... I'm a newbie to SELinux.
>>>>
>>>> I'm trying to update the sysadm module in a CLIP image. I downloaded
>>>> the SELinux policy code from: https://github.com/QuarkSecurity/CLIP.
>>>> I modified the sysadm policy code and built (in
>>>> ~/clip/packages/clip-selinux-policy/clip-selinux-policy) using:
>>>>
>>>> $ make modules APPS_MODS="sysadm"
>>>>
>>>> Then I tried to install in the CLIP image using:
>>>>
>>>> $ semodule -i /mnt/hdd/SELinix/sysadm.pp
>>>>
>>>> and got: "tried to link in a non-MLS module with an MLS base". (I
>>>> assume this means the CLIP image I'm working with is MLS?)
>>>> Next I built using:
>>>>
>>>> $ make modules APPS_MODS="sysadm" TYPE="mls"
>>>>
>>>> Tried to load/install the module and got: "sensitivy s10 not declared by
>>>> base."
>>>>
>>>> Next I tried:
>>>>
>>>> $ make modules APPS_MODS="auditadm sysadm" TYPE="mls" MLS_SENS=15
>>>>
>>>> and !still! got "sensitivy s10 not declared by base".
>>>>
>>>> Any suggestions/thoughts?
>>>>
>>>> ---John
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>>>
>>>
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
