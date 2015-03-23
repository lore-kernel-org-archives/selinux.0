Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2NJ24ax001493
 for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2015 15:02:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 23 Mar 2015 20:01:51 +0100
From: John Chludzinski <john.chludzinski@vivaldi.net>
To: Brandon Whalen <brandon@quarksecurity.com>
Subject: Re: Trying to update sysadm module in CLIP
In-Reply-To: <CAN4BvJ-489vfPtU8c9SB0VEB7s1dZz_qnkvMumejzfx5vgjKmQ@mail.gmail.com>
References: <e4247c48f0174b6f77f05c5b28bbcb9e@vivaldi.net>
 <b9a113715934c985dbeec5c2351f06cd@vivaldi.net>
 <CAGNxgPiBThm0SpAo-+1D2UsaFyVNY2AKpj56RFvt+8SrfxL-Jw@mail.gmail.com>
 <55d4ced56b5ade45f9635caa3bd622b9@vivaldi.net>
 <CAGNxgPh1Tq+ipErajh4F7VSW57cMTiNC7ZWJOa+jpWYsyw_HOA@mail.gmail.com>
 <cd05db3d284b292ed49352132248592b@vivaldi.net>
 <CAN4BvJ9itQkooPFA3HmRHk5e=gYFbKH4BSkEdZEM1fEAEwZiSA@mail.gmail.com>
 <dfd9a48922233f268fac642673f44056@vivaldi.net>
 <CAN4BvJ-489vfPtU8c9SB0VEB7s1dZz_qnkvMumejzfx5vgjKmQ@mail.gmail.com>
Message-ID: <3ea7bd6483559cc03107ad14df290867@vivaldi.net>
Cc: Selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Before you sent this I was trying out:

$ make clip-selinux-policy-rpm

I noticed from the output that it was creating RPM files in: 
tmp/src/redhat/RPMS/noarch/

which contains:

clip-selinux-policy-mls-6.2.0-1.noarch.rpm
clip-selinux-policy-clip-6.2.0-1.noarch.rpm
clip-selinux-policy-doc-6.2.0-1.noarch.rpm

And clip-selinux-policy-clip-6.2.0-1.noarch.rpm contains:

/usr/share/selinux/clip/aide.pp.bz2
/usr/share/selinux/clip/base.pp.bz2
/usr/share/selinux/clip/consoletype.pp.bz2
/usr/share/selinux/clip/cron.pp.bz2
/usr/share/selinux/clip/firstboot.pp.bz2
/usr/share/selinux/clip/gpg.pp.bz2
/usr/share/selinux/clip/hal.pp.bz2
/usr/share/selinux/clip/java.pp.bz2
/usr/share/selinux/clip/logrotate.pp.bz2
/usr/share/selinux/clip/logwatch.pp.bz2
/usr/share/selinux/clip/modules.lst
/usr/share/selinux/clip/mta.pp.bz2
/usr/share/selinux/clip/ntp.pp.bz2
/usr/share/selinux/clip/oscap.pp.bz2
/usr/share/selinux/clip/plymouthd.pp.bz2
/usr/share/selinux/clip/policykit.pp.bz2
/usr/share/selinux/clip/postfix.pp.bz2
/usr/share/selinux/clip/rpm.pp.bz2
/usr/share/selinux/clip/samhain.pp.bz2
/usr/share/selinux/clip/secstate.pp.bz2
/usr/share/selinux/clip/sendmail.pp.bz2
/usr/share/selinux/clip/seunshare.pp.bz2
/usr/share/selinux/clip/ssh.pp.bz2
/usr/share/selinux/clip/toor.pp.bz2
/usr/share/selinux/clip/tripwire.pp.bz2

So I assume that I should install 
clip-selinux-policy-clip-6.2.0-1.noarch.rpm and then "semodule -i" these 
*.pp files into CLIP? Once I have added my changes, of course.

---John


On 2015-03-23 19:22, Brandon Whalen wrote:
> On Mon, Mar 23, 2015 at 1:36 PM, John Chludzinski
> <john.chludzinski@vivaldi.net> wrote:
>> 1st, I don't see an MCS build option in
>> packages/clip-selinux-policy/Makefile. How would I build this?
>> 
> 
> I'm sorry I'm confusing you. Since you are building the mls version
> you could use clip-selinux-policy-mls-6.2.0-1.noarch.rpm. When I look
> at what is in that file I see the pp files.
> 
> clip-selinux-policy-mls   /usr/share/selinux/mls
> clip-selinux-policy-mls   /usr/share/selinux/mls/aide.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/base.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/consoletype.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/cron.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/firstboot.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/gpg.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/hal.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/java.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/logrotate.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/logwatch.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/modules.lst
> clip-selinux-policy-mls   /usr/share/selinux/mls/mta.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/ntp.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/oscap.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/plymouthd.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/policykit.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/postfix.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/rpm.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/samhain.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/secstate.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/sendmail.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/seunshare.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/ssh.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/toor.pp.bz2
> clip-selinux-policy-mls   /usr/share/selinux/mls/tripwire.pp.bz2
> 
> If you want to replace the entire policy, you would just make sure
> sysadm is listed as base in modules.conf, run 'make
> clip-selinux-policy-rpm' and re-install the policy. You probably want
> to bump the policy version as well since you made a change.
> 
> If this is just for development/testing than I'd suggest you make sure
> sysadm is listed as base in modules.conf, go to
> 'packages/clip-selinux-policy/clip-selinux-policy/' and build the
> modules using 'make' then copy over and reload the base.pp module.
> Reinstalling the RPM is overkill to replace one module during testing
> IMHO.
> 
>> 2nd, when last I tried to load/install a non-MLS module (e.g., 
>> sysadm.pp)
>> into CLIP, it refused saying "trying to load non-MLS module into MLS 
>> base".
>> 
>> 
>> ---John
>> 
>> 
>> 
>> On 2015-03-23 17:01, Brandon Whalen wrote:
>>> 
>>> On Mon, Mar 23, 2015 at 11:16 AM, John Chludzinski
>>> <john.chludzinski@vivaldi.net> wrote:
>>>> 
>>>> I took the liberty of examining the contents of
>>>> clip-selinux-policy-6.2.0-1.noarch.rpm:
>>>> 
>>>> $ rpm -qpl clip-selinux-policy-6.2.0-1.noarch.rpm
>>>> 
>>>> $ rpm2cpio clip-selinux-policy-6.2.0-1.noarch.rpm | cpio -idmv
>>>> 
>>>> and found the RPM contains nothing but *.if files for the modules +
>>>> gzipped
>>>> man pages + a Makefile.
>>>> 
>>>> It contains NO *.pp files nor does it include any *.te and *.fc to 
>>>> build
>>>> *.pp files from.
>>>> 
>>>> So installing clip-selinux-policy-6.2.0-1.noarch.rpm is for what?
>>> 
>>> 
>>> It's basically an RPM that installs header files and man pages. The
>>> .if file declares interfaces to other modules, so its very much like
>>> header information for SELinux policy. The one with the .pp files
>>> should be named clip-selinux-policy-6.2.0-1-mls.noarch.rpm. If you
>>> were building mcs it would 
>>> clip-selinux-policy-6.2.0-1-mcs.noarch.rpm.
>>> 
>>>> 
>>>> ---John
>>>> 
>>>> On 2015-03-20 23:07, Spencer Shimko wrote:
>>>>> 
>>>>> 
>>>>> On Fri, Mar 20, 2015 at 5:43 PM, John Chludzinski
>>>>> <john.chludzinski@vivaldi.net> wrote:
>>>>>> 
>>>>>> 
>>>>>> 1) I noticed
>>>>>> packages/clip-selinux-policy/clip-selinux-policy/policy/modules.conf
>>>>>> defines
>>>>>> the the modules that are built into a base.pp:
>>>>>> 
>>>>>> packages/clip-selinux-policy/clip-selinux-policy/ > make base
>>>>>> TYPE="mls"
>>>>>> MLS_SENS=1
>>>>>> 
>>>>>> which includes sysadm. Is this something of any interest?
>>>>> 
>>>>> 
>>>>> 
>>>>> As long as modules.conf declares something as base, it will be in
>>>>> base.  This is interesting because you have made made me think 
>>>>> about a
>>>>> circumstance that will break something in my tree pending merge 
>>>>> into
>>>>> our QSI tree (my #next branch in sshimko on github).  Neither here 
>>>>> nor
>>>>> there, yes, it will be in base if it is defined as base in
>>>>> modules.conf.
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> 2) Reading the output from:
>>>>>> 
>>>>>> packages/clip-selinux-policy/ > make rpm
>>>>>> 
>>>>>> I noticed it contains: "Compiling clip base module", which 
>>>>>> compiles all
>>>>>> the
>>>>>> *.te files.
>>>>> 
>>>>> 
>>>>> 
>>>>> Only the .te files corresponding to those set to "base" in
>>>>> modules.conf.  Those listed as "module" will be built at a later 
>>>>> step
>>>>> and will not be present in base.pp.
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> which, of course, includes sysadm.
>>>>>> 
>>>>>> The files created are: clip-selinux-policy-6.2.0-1.noarch.rpm,
>>>>>> clip-selinux-policy-6.2.0-1.src.rpm, 
>>>>>> clip-selinux-policy-6.2.0.tar.gz.
>>>>>> 
>>>>>> Should install clip-selinux-policy-6.2.0-1.noarch.rpm?
>>>>> 
>>>>> 
>>>>> 
>>>>> Yes the tarball is a side-effect of how things are built.  The RPM 
>>>>> is
>>>>> the one you want.  But there should be several files ending in 
>>>>> .rpm.
>>>>> Is that not the case?
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> 3) If I'm making small modifications to one of the canonical CLIP
>>>>>> modules
>>>>>> (system, role, etc.) is there something less that replacing the 
>>>>>> policy
>>>>>> tree?
>>>>>> That's why I build the sysadm.pp.
>>>>> 
>>>>> 
>>>>> 
>>>>> Honestly the easiest way is to just roll the updated RPMs and 
>>>>> install
>>>>> them on your system/.  Thus, you will get an updated sysadm policy 
>>>>> as
>>>>> well.
>>>>> 
>>>>> Are you just trying to build a policy for a single,
>>>>> previously-deployed system?  If so, there are other ways.  But if
>>>>> you're trying to do reproducible builds for inclusion in a bigger
>>>>> environment using RPMs for updating policies is reommended.
>>>>> 
>>>>> 
>>>>>> 
>>>>>> 4) If I'm creating policies unique to this project, should I 
>>>>>> create a
>>>>>> directory under policy/modules/<project> and run: make conf? Use
>>>>>> LOCAL_ROOT
>>>>>> to point to a policy source tree hanging off the project root? 
>>>>>> Just
>>>>>> trying
>>>>>> to come up with some process/strategy that's flexible and 
>>>>>> defensible.
>>>>>> Of
>>>>>> course LOCAL_ROOT is defined in the Makefile in
>>>>>> packages/clip-selinux-policy/clip-selinux-policy and I'd be 
>>>>>> building
>>>>>> *.pp
>>>>>> files? Maybe this is OK for new policy code?
>>>>>> 
>>>>> 
>>>>> Gotcha.  So yes you're taking the right approach by introducing a 
>>>>> new
>>>>> policy/modules/<project> directory and adding a metadata.xml file 
>>>>> in
>>>>> there to describe that project.  Then run make conf to have that
>>>>> project added to the correct configuration files.
>>>>> 
>>>>> Aside from make conf, I wouldn't use any other make commands in the
>>>>> policy directory as it will lead to problems.  LOCAL_ROOT is a 
>>>>> decent
>>>>> option if you're trying to build out of tree policies for, say, a
>>>>> single system.  Actually I think I implemented that feature years
>>>>> ago....
>>>>> 
>>>>> Basically, I would add your project folder, run make conf, then 
>>>>> start
>>>>> modifying all of the policy components you need to modify.  For
>>>>> testing and deployment I would suggest replacing the entire set of
>>>>> RPMs by rebuilding the RPMs with make rpm, and reinstalling them 
>>>>> (with
>>>>> --force if you didn't bump the release number).
>>>>> 
>>>>> I have some changes in my github tree #next branch that haven't 
>>>>> been
>>>>> merged into our main tree yet.  Specifically, we can now roll RPMs 
>>>>> for
>>>>> individual policy packages via a SEPRATE_PKGS variable in the
>>>>> Makefile.  This might be useful for you because you can rebuild the
>>>>> RPMs and, by specifying sysadm as a SEPARATE_PKG, you will get that
>>>>> package as a separate, isolated RPM.  But these changes are in QA 
>>>>> now
>>>>> and haven't been merged into our main repo so take those with a 
>>>>> grain
>>>>> of salt.
>>>>> 
>>>>> Thanks,
>>>>> --Spencer
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> ---John
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> Been inspecting the "other" make (in packages/clip-selinux-policy 
>>>>>> v.
>>>>>> packages/clip-selinux-policy/clip-selinux-policy).
>>>>>> 
>>>>>> On 2015-03-20 00:33, Spencer Shimko wrote:
>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> Trimmed SELinux mailing list form CCs.
>>>>>>> 
>>>>>>> Did you try the the suggestions in my on-list response a little 
>>>>>>> while
>>>>>>> ago?
>>>>>>> 
>>>>>>> On Thu, Mar 19, 2015 at 6:38 PM, John Chludzinski
>>>>>>> <john.chludzinski@vivaldi.net> wrote:
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> I ran (when under the role sysadm_r and type sysadm_t):
>>>>>>>> 
>>>>>>>> $ id -Z
>>>>>>>> 
>>>>>>>> and got: Xsysadm_u:sysadm_r:sysadm_t:s0
>>>>>>>> 
>>>>>>>> So now I'm assuming the CLIP image is at "s0" sensitivity level.
>>>>>>>> 
>>>>>>>> Then I noticed that the build.conf file states: "The 
>>>>>>>> sensitivities
>>>>>>>> will
>>>>>>>> be
>>>>>>>> s0 to s(MLS_SENS-1)".
>>>>>>>> 
>>>>>>>> So I built using:
>>>>>>>> 
>>>>>>>> $ make modules APPS_MODS="sysadm" TYPE="mls" MLS_SENS=1
>>>>>>>> 
>>>>>>>> to get an "s0" sensitivity level.
>>>>>>>> 
>>>>>>>> Tried to install and now I get: "duplicate declaration in 
>>>>>>>> module:
>>>>>>>> type/attribute sysadm_userhelper_t".
>>>>>>>> (A "Whac-A-Mole" game!)
>>>>>>>> 
>>>>>>>> ---John
>>>>>>>> 
>>>>>>>> 
>>>>>>>> On 2015-03-19 21:31, John Chludzinski wrote:
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> First thing ... I'm a newbie to SELinux.
>>>>>>>>> 
>>>>>>>>> I'm trying to update the sysadm module in a CLIP image. I 
>>>>>>>>> downloaded
>>>>>>>>> the SELinux policy code from: 
>>>>>>>>> https://github.com/QuarkSecurity/CLIP.
>>>>>>>>> I modified the sysadm policy code and built (in
>>>>>>>>> ~/clip/packages/clip-selinux-policy/clip-selinux-policy) using:
>>>>>>>>> 
>>>>>>>>> $ make modules APPS_MODS="sysadm"
>>>>>>>>> 
>>>>>>>>> Then I tried to install in the CLIP image using:
>>>>>>>>> 
>>>>>>>>> $ semodule -i /mnt/hdd/SELinix/sysadm.pp
>>>>>>>>> 
>>>>>>>>> and got: "tried to link in a non-MLS module with an MLS base". 
>>>>>>>>> (I
>>>>>>>>> assume this means the CLIP image I'm working with is MLS?)
>>>>>>>>> Next I built using:
>>>>>>>>> 
>>>>>>>>> $ make modules APPS_MODS="sysadm" TYPE="mls"
>>>>>>>>> 
>>>>>>>>> Tried to load/install the module and got: "sensitivy s10 not
>>>>>>>>> declared
>>>>>>>>> by
>>>>>>>>> base."
>>>>>>>>> 
>>>>>>>>> Next I tried:
>>>>>>>>> 
>>>>>>>>> $ make modules APPS_MODS="auditadm sysadm" TYPE="mls" 
>>>>>>>>> MLS_SENS=15
>>>>>>>>> 
>>>>>>>>> and !still! got "sensitivy s10 not declared by base".
>>>>>>>>> 
>>>>>>>>> Any suggestions/thoughts?
>>>>>>>>> 
>>>>>>>>> ---John
>>>>>>>>> _______________________________________________
>>>>>>>>> Selinux mailing list
>>>>>>>>> Selinux@tycho.nsa.gov
>>>>>>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>>>>>>> To get help, send an email containing "help" to
>>>>>>>>> Selinux-request@tycho.nsa.gov.
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> _______________________________________________
>>>>>>>> Selinux mailing list
>>>>>>>> Selinux@tycho.nsa.gov
>>>>>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>>>>>> To get help, send an email containing "help" to
>>>>>>>> Selinux-request@tycho.nsa.gov.
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> 
>>>> 
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>> 
>> 
