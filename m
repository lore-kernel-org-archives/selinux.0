Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2NII1Gv030438
 for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2015 14:18:15 -0400
Date: Mon, 23 Mar 2015 14:12:08 -0400
From: Mike Palmiotto <mpalmiotto@tresys.com>
To: John Chludzinski <john.chludzinski@vivaldi.net>
Subject: Re: Trying to update sysadm module in CLIP
Message-ID: <20150323141208.1915043c@palms-work>
In-Reply-To: <dfd9a48922233f268fac642673f44056@vivaldi.net>
References: <e4247c48f0174b6f77f05c5b28bbcb9e@vivaldi.net>
 <b9a113715934c985dbeec5c2351f06cd@vivaldi.net>
 <CAGNxgPiBThm0SpAo-+1D2UsaFyVNY2AKpj56RFvt+8SrfxL-Jw@mail.gmail.com>
 <55d4ced56b5ade45f9635caa3bd622b9@vivaldi.net>
 <CAGNxgPh1Tq+ipErajh4F7VSW57cMTiNC7ZWJOa+jpWYsyw_HOA@mail.gmail.com>
 <cd05db3d284b292ed49352132248592b@vivaldi.net>
 <CAN4BvJ9itQkooPFA3HmRHk5e=gYFbKH4BSkEdZEM1fEAEwZiSA@mail.gmail.com>
 <dfd9a48922233f268fac642673f44056@vivaldi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: clip@oss1.tresys.com, Selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Linking the CLIP mailing list back in.
Responses in-line below.

On Mon, 23 Mar 2015 18:36:44 +0100
John Chludzinski <john.chludzinski@vivaldi.net> wrote:

> 1st, I don't see an MCS build option in 
> packages/clip-selinux-policy/Makefile. How would I build this?
> 
> 2nd, when last I tried to load/install a non-MLS module (e.g., 
> sysadm.pp) into CLIP, it refused saying "trying to load non-MLS
> module into MLS base".

Take a look at the "TYPE" build flag. It is referenced in
packages/clip-selinux-policy/Makefile, but I'm not entirely sure that
you need to do anything with this.

The installCmds macro is used to build both mls and mcs policies. If
you look at packages/clip-selinux-policy/clip-selinux-policy.spec, the
mcs policy goes by the name clip-selinux-policy-clip, as referenced by
Tom Hurd earlier in the chain.

I would recommend keeping sysadm = base in your modules.conf and
installing the mcs policy clip-selinux-policy-clip-6.2.0-1.noarch.rpm.

--Mike


> 
> 
> ---John
> 
> 
> On 2015-03-23 17:01, Brandon Whalen wrote:
> > On Mon, Mar 23, 2015 at 11:16 AM, John Chludzinski
> > <john.chludzinski@vivaldi.net> wrote:
> >> I took the liberty of examining the contents of
> >> clip-selinux-policy-6.2.0-1.noarch.rpm:
> >> 
> >> $ rpm -qpl clip-selinux-policy-6.2.0-1.noarch.rpm
> >> 
> >> $ rpm2cpio clip-selinux-policy-6.2.0-1.noarch.rpm | cpio -idmv
> >> 
> >> and found the RPM contains nothing but *.if files for the modules
> >> + gzipped
> >> man pages + a Makefile.
> >> 
> >> It contains NO *.pp files nor does it include any *.te and *.fc to 
> >> build
> >> *.pp files from.
> >> 
> >> So installing clip-selinux-policy-6.2.0-1.noarch.rpm is for what?
> > 
> > It's basically an RPM that installs header files and man pages. The
> > .if file declares interfaces to other modules, so its very much like
> > header information for SELinux policy. The one with the .pp files
> > should be named clip-selinux-policy-6.2.0-1-mls.noarch.rpm. If you
> > were building mcs it would
> > clip-selinux-policy-6.2.0-1-mcs.noarch.rpm.
> > 
> >> 
> >> ---John
> >> 
> >> On 2015-03-20 23:07, Spencer Shimko wrote:
> >>> 
> >>> On Fri, Mar 20, 2015 at 5:43 PM, John Chludzinski
> >>> <john.chludzinski@vivaldi.net> wrote:
> >>>> 
> >>>> 1) I noticed
> >>>> packages/clip-selinux-policy/clip-selinux-policy/policy/modules.conf
> >>>> defines
> >>>> the the modules that are built into a base.pp:
> >>>> 
> >>>> packages/clip-selinux-policy/clip-selinux-policy/ > make base 
> >>>> TYPE="mls"
> >>>> MLS_SENS=1
> >>>> 
> >>>> which includes sysadm. Is this something of any interest?
> >>> 
> >>> 
> >>> As long as modules.conf declares something as base, it will be in
> >>> base.  This is interesting because you have made made me think
> >>> about a
> >>> circumstance that will break something in my tree pending merge
> >>> into our QSI tree (my #next branch in sshimko on github).
> >>> Neither here nor
> >>> there, yes, it will be in base if it is defined as base in
> >>> modules.conf.
> >>>> 
> >>>> 
> >>>> 2) Reading the output from:
> >>>> 
> >>>> packages/clip-selinux-policy/ > make rpm
> >>>> 
> >>>> I noticed it contains: "Compiling clip base module", which
> >>>> compiles all
> >>>> the
> >>>> *.te files.
> >>> 
> >>> 
> >>> Only the .te files corresponding to those set to "base" in
> >>> modules.conf.  Those listed as "module" will be built at a later
> >>> step and will not be present in base.pp.
> >>>> 
> >>>> 
> >>>> which, of course, includes sysadm.
> >>>> 
> >>>> The files created are: clip-selinux-policy-6.2.0-1.noarch.rpm,
> >>>> clip-selinux-policy-6.2.0-1.src.rpm, 
> >>>> clip-selinux-policy-6.2.0.tar.gz.
> >>>> 
> >>>> Should install clip-selinux-policy-6.2.0-1.noarch.rpm?
> >>> 
> >>> 
> >>> Yes the tarball is a side-effect of how things are built.  The
> >>> RPM is the one you want.  But there should be several files
> >>> ending in .rpm. Is that not the case?
> >>>> 
> >>>> 
> >>>> 3) If I'm making small modifications to one of the canonical
> >>>> CLIP modules
> >>>> (system, role, etc.) is there something less that replacing the 
> >>>> policy
> >>>> tree?
> >>>> That's why I build the sysadm.pp.
> >>> 
> >>> 
> >>> Honestly the easiest way is to just roll the updated RPMs and
> >>> install them on your system/.  Thus, you will get an updated
> >>> sysadm policy as well.
> >>> 
> >>> Are you just trying to build a policy for a single,
> >>> previously-deployed system?  If so, there are other ways.  But if
> >>> you're trying to do reproducible builds for inclusion in a bigger
> >>> environment using RPMs for updating policies is reommended.
> >>> 
> >>> 
> >>>> 
> >>>> 4) If I'm creating policies unique to this project, should I
> >>>> create a
> >>>> directory under policy/modules/<project> and run: make conf? Use
> >>>> LOCAL_ROOT
> >>>> to point to a policy source tree hanging off the project root?
> >>>> Just trying
> >>>> to come up with some process/strategy that's flexible and 
> >>>> defensible. Of
> >>>> course LOCAL_ROOT is defined in the Makefile in
> >>>> packages/clip-selinux-policy/clip-selinux-policy and I'd be
> >>>> building *.pp
> >>>> files? Maybe this is OK for new policy code?
> >>>> 
> >>> 
> >>> Gotcha.  So yes you're taking the right approach by introducing a
> >>> new policy/modules/<project> directory and adding a metadata.xml
> >>> file in there to describe that project.  Then run make conf to
> >>> have that project added to the correct configuration files.
> >>> 
> >>> Aside from make conf, I wouldn't use any other make commands in
> >>> the policy directory as it will lead to problems.  LOCAL_ROOT is
> >>> a decent option if you're trying to build out of tree policies
> >>> for, say, a single system.  Actually I think I implemented that
> >>> feature years ago....
> >>> 
> >>> Basically, I would add your project folder, run make conf, then
> >>> start modifying all of the policy components you need to modify.
> >>> For testing and deployment I would suggest replacing the entire
> >>> set of RPMs by rebuilding the RPMs with make rpm, and
> >>> reinstalling them (with
> >>> --force if you didn't bump the release number).
> >>> 
> >>> I have some changes in my github tree #next branch that haven't
> >>> been merged into our main tree yet.  Specifically, we can now
> >>> roll RPMs for
> >>> individual policy packages via a SEPRATE_PKGS variable in the
> >>> Makefile.  This might be useful for you because you can rebuild
> >>> the RPMs and, by specifying sysadm as a SEPARATE_PKG, you will
> >>> get that package as a separate, isolated RPM.  But these changes
> >>> are in QA now and haven't been merged into our main repo so take
> >>> those with a grain of salt.
> >>> 
> >>> Thanks,
> >>> --Spencer
> >>>> 
> >>>> 
> >>>> ---John
> >>>> 
> >>>> 
> >>>> 
> >>>> Been inspecting the "other" make (in
> >>>> packages/clip-selinux-policy v.
> >>>> packages/clip-selinux-policy/clip-selinux-policy).
> >>>> 
> >>>> On 2015-03-20 00:33, Spencer Shimko wrote:
> >>>>> 
> >>>>> 
> >>>>> Trimmed SELinux mailing list form CCs.
> >>>>> 
> >>>>> Did you try the the suggestions in my on-list response a little 
> >>>>> while
> >>>>> ago?
> >>>>> 
> >>>>> On Thu, Mar 19, 2015 at 6:38 PM, John Chludzinski
> >>>>> <john.chludzinski@vivaldi.net> wrote:
> >>>>>> 
> >>>>>> 
> >>>>>> I ran (when under the role sysadm_r and type sysadm_t):
> >>>>>> 
> >>>>>> $ id -Z
> >>>>>> 
> >>>>>> and got: Xsysadm_u:sysadm_r:sysadm_t:s0
> >>>>>> 
> >>>>>> So now I'm assuming the CLIP image is at "s0" sensitivity
> >>>>>> level.
> >>>>>> 
> >>>>>> Then I noticed that the build.conf file states: "The
> >>>>>> sensitivities will
> >>>>>> be
> >>>>>> s0 to s(MLS_SENS-1)".
> >>>>>> 
> >>>>>> So I built using:
> >>>>>> 
> >>>>>> $ make modules APPS_MODS="sysadm" TYPE="mls" MLS_SENS=1
> >>>>>> 
> >>>>>> to get an "s0" sensitivity level.
> >>>>>> 
> >>>>>> Tried to install and now I get: "duplicate declaration in
> >>>>>> module: type/attribute sysadm_userhelper_t".
> >>>>>> (A "Whac-A-Mole" game!)
> >>>>>> 
> >>>>>> ---John
> >>>>>> 
> >>>>>> 
> >>>>>> On 2015-03-19 21:31, John Chludzinski wrote:
> >>>>>>> 
> >>>>>>> 
> >>>>>>> 
> >>>>>>> First thing ... I'm a newbie to SELinux.
> >>>>>>> 
> >>>>>>> I'm trying to update the sysadm module in a CLIP image. I 
> >>>>>>> downloaded
> >>>>>>> the SELinux policy code from: 
> >>>>>>> https://github.com/QuarkSecurity/CLIP.
> >>>>>>> I modified the sysadm policy code and built (in
> >>>>>>> ~/clip/packages/clip-selinux-policy/clip-selinux-policy)
> >>>>>>> using:
> >>>>>>> 
> >>>>>>> $ make modules APPS_MODS="sysadm"
> >>>>>>> 
> >>>>>>> Then I tried to install in the CLIP image using:
> >>>>>>> 
> >>>>>>> $ semodule -i /mnt/hdd/SELinix/sysadm.pp
> >>>>>>> 
> >>>>>>> and got: "tried to link in a non-MLS module with an MLS
> >>>>>>> base". (I assume this means the CLIP image I'm working with
> >>>>>>> is MLS?) Next I built using:
> >>>>>>> 
> >>>>>>> $ make modules APPS_MODS="sysadm" TYPE="mls"
> >>>>>>> 
> >>>>>>> Tried to load/install the module and got: "sensitivy s10 not 
> >>>>>>> declared
> >>>>>>> by
> >>>>>>> base."
> >>>>>>> 
> >>>>>>> Next I tried:
> >>>>>>> 
> >>>>>>> $ make modules APPS_MODS="auditadm sysadm" TYPE="mls"
> >>>>>>> MLS_SENS=15
> >>>>>>> 
> >>>>>>> and !still! got "sensitivy s10 not declared by base".
> >>>>>>> 
> >>>>>>> Any suggestions/thoughts?
> >>>>>>> 
> >>>>>>> ---John
> >>>>>>> _______________________________________________
> >>>>>>> Selinux mailing list
> >>>>>>> Selinux@tycho.nsa.gov
> >>>>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >>>>>>> To get help, send an email containing "help" to
> >>>>>>> Selinux-request@tycho.nsa.gov.
> >>>>>> 
> >>>>>> 
> >>>>>> 
> >>>>>> 
> >>>>>> _______________________________________________
> >>>>>> Selinux mailing list
> >>>>>> Selinux@tycho.nsa.gov
> >>>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >>>>>> To get help, send an email containing "help" to
> >>>>>> Selinux-request@tycho.nsa.gov.
> >>>> 
> >>>> 
> >>>> 
> >> 
> >> _______________________________________________
> >> Selinux mailing list
> >> Selinux@tycho.nsa.gov
> >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> To get help, send an email containing "help" to
> >> Selinux-request@tycho.nsa.gov.
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
