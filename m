Subject: Re: [RFC] Split up policycoreutils
To: Jason Zaman <jason@perfinion.com>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <be8528f1-50ee-98da-91ea-0d0b0dfe0398@tycho.nsa.gov>
 <d1be7324-fea8-1044-b3a0-64e590f38f43@tycho.nsa.gov>
 <20161114204113.GA9733@meriadoc.perfinion.com>
 <10c2795c-b4b4-fbe7-6edd-7c24423f6e0a@tycho.nsa.gov>
 <a465fc17-74a3-503a-1247-873efe41925f@tycho.nsa.gov>
 <20161115163015.GA21982@meriadoc.perfinion.com>
 <55295b76-0e9e-7d07-008d-916e57a0fea9@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a97884aa-345c-d988-5555-47a01815b1c1@tycho.nsa.gov>
Date: Wed, 16 Nov 2016 14:07:32 -0500
MIME-Version: 1.0
In-Reply-To: <55295b76-0e9e-7d07-008d-916e57a0fea9@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/16/2016 02:00 PM, Stephen Smalley wrote:
> On 11/15/2016 11:30 AM, Jason Zaman wrote:
>> On Tue, Nov 15, 2016 at 10:01:12AM -0500, Stephen Smalley wrote:
>>> On 11/15/2016 09:47 AM, Stephen Smalley wrote:
>>>> On 11/14/2016 03:41 PM, Jason Zaman wrote:
>>>>> These look pretty good to me. I have written most of the ebuilds for
>>>>> gentoo for these new packages but have not committed to the tree yet.
>>>>>
>>>>> There are a couple issues:
>>>>> 1) What is the license for each of the tarballs? there is no license or
>>>>> COPYING file in the dirs.
>>>>
>>>> Fixed; I copied the policycoreutils/COPYING file into each of the new
>>>> ones since they were all moved from policycoreutils.
>>>>
>>>>>
>>>>> 2) even tho i fixed up a lot of it so shouldnt be, I am *super* confused
>>>>> about sepolicy vs sepolgen. there are like 4 separate dirs with those
>>>>> names and the sepolicy Makefile makes a symlink for sepolgen. And then
>>>>> there is the gui and the non-gui part of them. python/sepolicy/* should
>>>>> hopefully die soon as things fully move over to setools4. should gui/ be
>>>>> called system-config-selinux? also is it a redhatism or does it also
>>>>> apply to other distros?
>>>>
>>>> I also find this confusing; hopefully Dan (cc'd) can help clarify
>>>> matters since he wrote most of this code.  I do know that the old
>>>> sepolgen package (now python/sepolgen) was just a python module used as
>>>> the backend for audit2allow and intended to become a more general policy
>>>> analysis and generation backend, but never evolved that way, whereas
>>>> gui/sepolgen was the old name for Dan's policy generation script/tool
>>>> that is now just an alias for sepolicy generate. gui could be called
>>>> system-config-selinux, but then it can also be invoked as sepolicy gui.
>>>> It certainly started life as a Red Hat tool, but I'm not sure if anyone
>>>> else is using it.  Refactoring all of it, including
>>>> semanage/seobject.py, may make sense.
>>
>> Okay this is roughly what I understood too so thats good. As things get
>> cleaned up more over time hopefully more gets ported to setools4 and
>> then we can start dropping the legacy parts. especially since the ones
>> before setools4 dont completely support policy format 30.
>>>>
>>>>> 3) The deps of each of the bits is somewhat complicated to figure out.
>>>>> semodule-utils looks like it only needs libsepol and libselinux and the
>>>>> others look like they need most of the others? The makefile just builds
>>>>> them in order but i'd like to specify more accurate deps in the gentoo
>>>>> packages (especially external deps for each package) so they get
>>>>> (re)built as required as things update.
>>>>
>>>> I was also trying to make it easy to omit the optional components
>>>> (OPT_SUBDIRS in the top-level Makefile), i.e. the ones that are not
>>>> required for operation.  I would omit at least dbus, gui, mcstrans,
>>>> restorecond, and sandbox by default from a base install.  python is
>>>> likely needed for general purpose distros but could be omitted from
>>>> embedded systems.  Actually, I don't see why semodule-utils components
>>>> are linking with libselinux; they do not include selinux.h or make any
>>>> calls to libselinux AFAICS, so I think that only truly depends on libsepol.
>>>
>>> Fixed this too on the branch - removed the -lselinux from semodule-utils
>>> Makefiles.
>>
>> Aha! thanks, I was just looking at the output of ldd and didnt
>> investigate too far.
>>>>
>>>>> Also which of these are required to build refpolicy? the docs on that
>>>>> may need updating later too.
>>>>
>>>> I would only expect libsepol, checkpolicy, and semodule-utils to be
>>>> needed to build refpolicy, while libsemanage and policycoreutils would
>>>> also be needed to install/load refpolicy.
>>>>
>>>>> 4) mcstrans fails to build on my laptop, i'll send patches later. I
>>>>> might have stricter warnings on or something.
>>>>
>>>> Ok, I already had to fix a number of such warnings for it when I
>>>> re-enabled building it by default on that branch (it was disabled
>>>> before), so not surprised - just send the patches our way.
>>>>
>>>>> 5) in python/sepolicy/Makefile:
>>>>> override CFLAGS += -I$(PREFIX)/include -DPACKAGE="policycoreutils"
>>>>> should that be something instead of policycoreutils now?
>>>>
>>>> Probably can be removed entirely.
>>>>
>>>>> 6) we have a policycoreutils-extra thats been floating around as part of
>>>>> policycoreutils in gentoo. Mainly has rlpkg and selocal. After this
>>>>> split is as good a time as any to cleanup and upstream them.
>>>>
>>>> Ok, in that case we might want to think about what else if anything
>>>> might go there.
>>>>
>>>>> 7) I just noticed when looking through different Makefiles that some
>>>>> variables default to different things. I'll send patches for this too
>>>>> later once its merged in. Its nothing huge just better to be the same.
>>>>>
>>>>>> Note that the release script will add the selinux- prefix for dbus, gui,
>>>>>> python, and sandbox when generating the source tarballs so that they
>>>>>> have unique names suitable for source packages.
>>>>>
>>>>> This makes sense but I wonder if the name prefix is going to be annoying
>>>>> when we end up needing to backport a patch on a release since the paths
>>>>> would be different. But then again we've always had to edit them since
>>>>> they are one level down so I dont think I mind this minor extra bit too.
>>>>
>>>> Open to suggestions; I could add the prefix in the source tree itself;
>>>> it just seemed ugly/unnecessary.  Or we could split up the repository
>>>> into multiple ones / submodules, but I'm not keen on that.
>>
>> lets just keep it as-is, its hardly a big deal and there isnt anything
>> all that much better.
>>
>> It all looks good to me currently. Cant think of anything else that
>> should be done before merging it in.
> 
> Ok, it is now merged to master, with the commit prior to the merge
> tagged as "before_splitpolicycoreutils".

And I dropped the ChangeLogs.  Can revive and update them if there is
demand.  Known unresolved issues:

- Need to split/update the policycoreutils/po files.  Not sure if there
is an easy way to do that.

- I didn't fix the extraneous CFLAGS override in
python/sepolicy/Makefile; we can do that whenever.

- We'll need to decide how to handle VERSIONs going forward, e.g. if
we'll keep them in sync across components or let each one only track
changes to that component.
