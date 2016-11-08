Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA8JdZmL024816
 for <selinux@tycho.nsa.gov>; Tue, 8 Nov 2016 14:39:35 -0500
Subject: Re: [RFC] Split up policycoreutils
To: SELinux <selinux@tycho.nsa.gov>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <be8528f1-50ee-98da-91ea-0d0b0dfe0398@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d1be7324-fea8-1044-b3a0-64e590f38f43@tycho.nsa.gov>
Date: Tue, 8 Nov 2016 14:42:31 -0500
MIME-Version: 1.0
In-Reply-To: <be8528f1-50ee-98da-91ea-0d0b0dfe0398@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/31/2016 02:05 PM, Stephen Smalley wrote:
> On 10/21/2016 01:47 PM, Stephen Smalley wrote:
>> Hi,
>>
>> policycoreutils started life as a small set of utilities that were
>> necessary or at least widely used in production on a SELinux system.
>> Over time though it has grown to include many optional components, and
>> even within a given subdirectory (e.g. sepolicy) there seem to be a
>> number of components that should be optional (e.g. the dbus service).
>> I'd like to propose that we move a number of components out of
>> policycoreutils into their own top-level subdirectory (possibly grouping
>> some of the related ones together).
>>
>> Some possible components to move and the rationale for doing so include:
>>
>> - gui: not required for operation.  Unsure if this is even used outside
>> of Fedora, or how widely it is used within Fedora compared to the
>> command line tools. Packaged separately by Fedora as part of
>> policycoreutils-gui.
>>
>> - mcstrans: not required for operation outside of MLS environments (and
>> even there, only if using that label encoding functionality), not built
>> by default even upstream (omitted from policycoreutils/Makefile).
>> Packaged separately in Fedora as mcstrans.
>>
>> - restorecond: not required for operation, adds dbus and glib
>> dependencies, largely obsoleted by name-based type transition support in
>> the kernel.  Packaged separately in Fedora as policycoreutils-restorecond.
>>
>> - sandbox: not required for basic operation of SELinux.  Packaged
>> separately by Fedora as policycoreutils-sandbox.
>>  restorecond
>> - semodule_deps/expand/link: developer tools only, not required for
>> operation, unlike semodule.  Packaged separately by Fedora as part of
>> policycoreutils-devel.
>>
>> - sepolicy/{org.selinux*,selinux_client.py,selinux_server.py}: D-BUS
>> service for managing SELinux, not required for basic operation, not
>> desirable in high security environments. Packaged separately by Fedora
>> as part of policycoreutils-gui.  Could perhaps be combined with the gui
>> above, although I think they are logically distinct.
>>
>> We could of course go further, but those seem to be the most obvious
>> candidates.
>>
>> Thoughts?
> 
> For discussion purposes, I've pushed a splitpolicycoreutils branch that
> moves the above components and others identified in the discussion
> thread, and makes it easy to omit the non-core components from the
> build.  Take a look and see what you think.  Known issues:
> 
> - I did not deal with splitting the policycoreutils/po files and moving
> them around.  Not sure what the best way to handle that is.
> 
> - python/sepolicy likely needs further rearrangement. I am unclear on
> the purpose/use of the desktop file and pixmaps; if those are only for
> the gui, then they can be moved to gui/, but I don't understand why they
> are called sepolicy* or located here.  Also, should
> python/sepolicy/sepolicy/sedbus.py be moved over to dbus/ or stay here?
> Dan?
> 
> - dbus/selinux_client.py (formerly
> policycoreutils/sepolicy/selinux_client.py) seems like leftover testing
> cruft.  Remove?
> 
> - restorecond presently reuses source code directly from setfiles, so
> building it as a separate package may be a nuisance.  OTOH, I'm not
> entirely clear on whether restorecond needs to be kept around at all
> anymore?
> 
> - policycoreutils/sepolgen-ifgen contains a single C program,
> sepolgen-ifgen-attr-helper, that is only used by
> python/audit2allow/sepolgen-ifgen.  Any reason to not just coalesce it
> into python/audit2allow even though it is not python itself?
> 
> - After the restructuring, the only script left in policycoreutils is
> fixfiles.  Technically, that's not required for production either as one
> can always just run setfiles or restorecon directly, but distros seem to
> rely on it.  Is it worth moving just to free policycoreutils of any bash
> dependencies, and if so, where?
> 
> - I moved policycoreutils/semodule_{deps,expand,link} into a new
> semodule-utils directory.  This might however be slightly confusing
> since semodule and semodule_package remain in policycoreutils since they
> are required and not merely for developers.  Feel free to suggest
> another name or structure.  Actually, I guess semodule_package might be
> optional now with CIL, so perhaps that one can be moved too.

I've made further changes on the splitpolicycoreutils branch based on
the discussion (as well as rebasing it on latest master).  This is a
call for final comments or objections before merging it to master.  With
the current branch, we will have the following source tar files in a
release:

Unchanged:
* libsepol
* libselinux
* libsemanage
* checkpolicy
* secilc

Modified or new:
* policycoreutils (containing only hll, load_policy, newrole, run_init,
scripts/fixfiles, secon, semodule, sestatus, setfiles, setsebool)
* mcstrans
* restorecond
* semodule-utils (containing semodule_package, semodule_link,
semodule_expand, semodule_deps)
* selinux-dbus (containing org.selinux DBus configuration and python files)
- selinux-gui (containing system-config-selinux aka selinux polgengui)
- selinux-python (containing audit2allow, including its
sepolgen-ifgen-attr-helper helper program, chcat, semanage, sepolgen,
sepolicy)
- selinux-sandbox (containing sandbox)

No longer separate:
* sepolgen (moved inside of selinux-python)

Note that the release script will add the selinux- prefix for dbus, gui,
python, and sandbox when generating the source tarballs so that they
have unique names suitable for source packages.

Feel free to suggest changes in structure, naming, or whatever.
