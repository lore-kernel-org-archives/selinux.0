Subject: Re: [PATCH 04/15] [src-policy] refpol intermediate language
 compiler (refpol_ilc)
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Caleb Case <ccase@tresys.com>
Cc: selinux@tycho.nsa.gov, csellers@tresys.com, kmacmillan@tresys.com,
        jbrindle@tresys.com, sds@tycho.nsa.gov
In-Reply-To: <1264543701-20638-5-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
	 <1264543701-20638-2-git-send-email-ccase@tresys.com>
	 <1264543701-20638-3-git-send-email-ccase@tresys.com>
	 <1264543701-20638-4-git-send-email-ccase@tresys.com>
	 <1264543701-20638-5-git-send-email-ccase@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Jan 2010 16:03:18 -0500
Message-ID: <1264712598.14722.18.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-01-26 at 17:08 -0500, Caleb Case wrote:
> In the interim, before the completion of the proposed CIL[1], the
> intermediate language will be a specialized version of refpol and the
> Reference Policy build environment.
> 
> [refpol_ilc CIL Compiler]
> 
> The repfol intermediate language compiler (refpol_ilc) builds a binary
> base module from refpol module.  Producing a binary base module allows
> the existing libsemanage framework to continue to operate essentially as
> it does today (load base module, apply database changes, create loadable
> policy).
> 
>    Usage: refpol_ilc [OPTIONS] MODULE MODULE ...
> 
>    Options:
>      --version             show program's version number and exit
>      -h, --help            show this help message and exit
>      -d FILE, --disabled=FILE
>                            indicates module is disabled
>      -f, --force           force overwriting existing files
>      -t DIR, --tmp=DIR     temporary build directory
>      -b DIR, --build-template=DIR
>                            build template directory (Default:
>                            /usr/share/selinux/refpol_ilc/build)
>      -o FILE, --output=FILE
>                            output file
>      -c BOOL, --cleanup=BOOL
>                            cleanup (remove) temporary directory (Default: True)
> 
> Note: The paths passed to the refpol_ilc need to be in the format of the
>       semanage store in /var/lib/selinux. The refpol_ilc extracts the
>       module name from the path. Future CIL will also likely extract the
>       priority of the module from the path.
> 
> Example:
> 
> The compiles the moduless installed in the 'test' store into a base.pp:
> 
> # refpol_ilc `find /var/lib/selinux/test/active/modules/400/ -iname cil` > base.pp
> 
> [Compilation]
> 
> Compilation proceeds as follows:
> 
>   1. Copy build environment to temporary location.
> 
>      Note: refpol_ilc anticipates the build environment being installed
>            to /usr/share/selinux/refpol_ilc/build by default.
> 
>   2. Install modules (see Special Modules and Normal Modules below).
> 
>   3. Create conf files.
> 
>   4. Set all modules to base or off as appropriate in modules.conf.
> 
>   5. Create base module (base.pp).
> 
> [Special Modules]
> 
> A number of modules are considered to be special and are installed into
> special locations in the build environment:
> 
>    [Module Name]         [Reference Policy File]
> 
>    _constraints           policy/constraints
>    _global_booleans       policy/global_booleans
>    _global_tunables       policy/global_tunables
>    _mcs                   policy/mcs
>    _mls                   policy/mls
>    _policy_capabilities   policy/policy_capabilities
>    _rolemap               policy/rolemap
>    _users                 policy/users
>    _access_vectors        policy/flask/access_vectors
>    _initial_sids          policy/flask/initial_sids
>    _security_classes      policy/flask/security_classes
>    _file_patterns         policy/support/file_patterns.spt
>    _ipc_patterns          policy/support/ipc_patterns.spt
>    _loadable_module       policy/support/loadable_module.spt
>    _misc_macros           policy/support/misc_macros.spt
>    _misc_patterns         policy/support/misc_patterns.spt
>    _mls_mcs_macros        policy/support/mls_mcs_macros.spt
>    _obj_perm_sets         policy/support/obj_perm_sets.spt
> 

In the policy store, mcs and mls modules exist along with _mcs and _mls
modules.  But _mcs calls itself "mcs" in the policy_module statement and
_mls calls itself "mls" in the policy_module statement.

mcs:
policy_module(mcs, 1.2.0)

_mcs:
policy_module(mcs, 2.20091117)

mls:
policy_module(mls, 1.8.0)

_mls:
policy_module(mls, 2.20091117)

Is there a reason for this?

> The build.conf file is handled with another special module _defines.
> This module provides some of the variables for the traditional
> build.conf with the remaining variables determined by the build
> environment as follows:
> 
>    OUTPUT_POLICY   =>   Copied from _defines.
>    TYPE            =>   Detect from the presence of the mls/mcs modules.
>                         mls > mcs > none: meaning that if there is an
>                         _mls module, then TYPE = mls, even if there is an
>                         mcs module present.
>    NAME            =>   Copied from _defines.
>    DISTRO          =>   Copied from _defines.
>    UNK_PERMS       =>   Copied from _defines.
>    DIRECT_INITRC   =>   Copied from _defines.
>    MONOLITHIC      =>   Fixed to 'n'.
>    UBAC            =>   Copied from _defines.
>    MLS_SENS        =>   Copied from _defines.
>    MLS_CATS        =>   Copied from _defines.
>    MCS_CATS        =>   Copied from _defines.
>    QUIET           =>   Copied from _defines.
> 
> No other special modules are permitted. All special modules are
> prepended with '_' to distinguish them from normal modules.
> 
> Note: The MLS/MCS/Standard setting of the policy is derived from the
>       presense of the _mls or _mcs modules. It is no longer necessary to
>       specify the policy type explicitly via the TYPE statement. This
>       also allows policy type to be switched simply by enabling/disabled
>       the _mls/_mcs modules.
> 
> [Normal Modules]
> 
> All normal (non-special) modules are copied to policy/modules/kernel/
> and unpacked into the Reference Policy module 3 file format.
> 
> [1] CIL RFC: http://marc.info/?l=selinux&m=124759244409438&w=2
> ---
>  Makefile                            |    2 +-
>  refpol_ilc/COPYING                  |  504 +++++++++++++++++++++++++++++++++++
>  refpol_ilc/Makefile                 |   24 ++
>  refpol_ilc/refpol_ilc.py            |   17 ++
>  refpol_ilc/refpol_ilc/refpol_ilc.py |  193 +++++++++++++
>  refpol_ilc/setup.py                 |   13 +
>  6 files changed, 752 insertions(+), 1 deletions(-)
>  create mode 100644 refpol_ilc/COPYING
>  create mode 100644 refpol_ilc/Makefile
>  create mode 100755 refpol_ilc/refpol_ilc.py
>  create mode 100644 refpol_ilc/refpol_ilc/__init__.py
>  create mode 100644 refpol_ilc/refpol_ilc/refpol_ilc.py
>  create mode 100755 refpol_ilc/setup.py
> 
> diff --git a/Makefile b/Makefile
> index be2a4ec..afb4843 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,4 +1,4 @@
> -SUBDIRS=libsepol libselinux libsemanage sepolgen checkpolicy policycoreutils refpol corenet # policy
> +SUBDIRS=libsepol libselinux libsemanage sepolgen checkpolicy policycoreutils refpol corenet refpol_ilc # policy
>  PYSUBDIRS=libselinux libsemanage
>  
>  ifeq ($(DEBUG),1)
> diff --git a/refpol_ilc/COPYING b/refpol_ilc/COPYING
> new file mode 100644
> index 0000000..8add30a
> --- /dev/null
> +++ b/refpol_ilc/COPYING
> @@ -0,0 +1,504 @@
> +		  GNU LESSER GENERAL PUBLIC LICENSE
> +		       Version 2.1, February 1999
> +
> + Copyright (C) 1991, 1999 Free Software Foundation, Inc.
> +     51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + Everyone is permitted to copy and distribute verbatim copies
> + of this license document, but changing it is not allowed.
> +
> +[This is the first released version of the Lesser GPL.  It also counts
> + as the successor of the GNU Library Public License, version 2, hence
> + the version number 2.1.]
> +
> +			    Preamble
> +
> +  The licenses for most software are designed to take away your
> +freedom to share and change it.  By contrast, the GNU General Public
> +Licenses are intended to guarantee your freedom to share and change
> +free software--to make sure the software is free for all its users.
> +
> +  This license, the Lesser General Public License, applies to some
> +specially designated software packages--typically libraries--of the
> +Free Software Foundation and other authors who decide to use it.  You
> +can use it too, but we suggest you first think carefully about whether
> +this license or the ordinary General Public License is the better
> +strategy to use in any particular case, based on the explanations below.
> +
> +  When we speak of free software, we are referring to freedom of use,
> +not price.  Our General Public Licenses are designed to make sure that
> +you have the freedom to distribute copies of free software (and charge
> +for this service if you wish); that you receive source code or can get
> +it if you want it; that you can change the software and use pieces of
> +it in new free programs; and that you are informed that you can do
> +these things.
> +
> +  To protect your rights, we need to make restrictions that forbid
> +distributors to deny you these rights or to ask you to surrender these
> +rights.  These restrictions translate to certain responsibilities for
> +you if you distribute copies of the library or if you modify it.
> +
> +  For example, if you distribute copies of the library, whether gratis
> +or for a fee, you must give the recipients all the rights that we gave
> +you.  You must make sure that they, too, receive or can get the source
> +code.  If you link other code with the library, you must provide
> +complete object files to the recipients, so that they can relink them
> +with the library after making changes to the library and recompiling
> +it.  And you must show them these terms so they know their rights.
> +
> +  We protect your rights with a two-step method: (1) we copyright the
> +library, and (2) we offer you this license, which gives you legal
> +permission to copy, distribute and/or modify the library.
> +
> +  To protect each distributor, we want to make it very clear that
> +there is no warranty for the free library.  Also, if the library is
> +modified by someone else and passed on, the recipients should know
> +that what they have is not the original version, so that the original
> +author's reputation will not be affected by problems that might be
> +introduced by others.
> +
> +  Finally, software patents pose a constant threat to the existence of
> +any free program.  We wish to make sure that a company cannot
> +effectively restrict the users of a free program by obtaining a
> +restrictive license from a patent holder.  Therefore, we insist that
> +any patent license obtained for a version of the library must be
> +consistent with the full freedom of use specified in this license.
> +
> +  Most GNU software, including some libraries, is covered by the
> +ordinary GNU General Public License.  This license, the GNU Lesser
> +General Public License, applies to certain designated libraries, and
> +is quite different from the ordinary General Public License.  We use
> +this license for certain libraries in order to permit linking those
> +libraries into non-free programs.
> +
> +  When a program is linked with a library, whether statically or using
> +a shared library, the combination of the two is legally speaking a
> +combined work, a derivative of the original library.  The ordinary
> +General Public License therefore permits such linking only if the
> +entire combination fits its criteria of freedom.  The Lesser General
> +Public License permits more lax criteria for linking other code with
> +the library.
> +
> +  We call this license the "Lesser" General Public License because it
> +does Less to protect the user's freedom than the ordinary General
> +Public License.  It also provides other free software developers Less
> +of an advantage over competing non-free programs.  These disadvantages
> +are the reason we use the ordinary General Public License for many
> +libraries.  However, the Lesser license provides advantages in certain
> +special circumstances.
> +
> +  For example, on rare occasions, there may be a special need to
> +encourage the widest possible use of a certain library, so that it becomes
> +a de-facto standard.  To achieve this, non-free programs must be
> +allowed to use the library.  A more frequent case is that a free
> +library does the same job as widely used non-free libraries.  In this
> +case, there is little to gain by limiting the free library to free
> +software only, so we use the Lesser General Public License.
> +
> +  In other cases, permission to use a particular library in non-free
> +programs enables a greater number of people to use a large body of
> +free software.  For example, permission to use the GNU C Library in
> +non-free programs enables many more people to use the whole GNU
> +operating system, as well as its variant, the GNU/Linux operating
> +system.
> +
> +  Although the Lesser General Public License is Less protective of the
> +users' freedom, it does ensure that the user of a program that is
> +linked with the Library has the freedom and the wherewithal to run
> +that program using a modified version of the Library.
> +
> +  The precise terms and conditions for copying, distribution and
> +modification follow.  Pay close attention to the difference between a
> +"work based on the library" and a "work that uses the library".  The
> +former contains code derived from the library, whereas the latter must
> +be combined with the library in order to run.
> +
> +		  GNU LESSER GENERAL PUBLIC LICENSE
> +   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
> +
> +  0. This License Agreement applies to any software library or other
> +program which contains a notice placed by the copyright holder or
> +other authorized party saying it may be distributed under the terms of
> +this Lesser General Public License (also called "this License").
> +Each licensee is addressed as "you".
> +
> +  A "library" means a collection of software functions and/or data
> +prepared so as to be conveniently linked with application programs
> +(which use some of those functions and data) to form executables.
> +
> +  The "Library", below, refers to any such software library or work
> +which has been distributed under these terms.  A "work based on the
> +Library" means either the Library or any derivative work under
> +copyright law: that is to say, a work containing the Library or a
> +portion of it, either verbatim or with modifications and/or translated
> +straightforwardly into another language.  (Hereinafter, translation is
> +included without limitation in the term "modification".)
> +
> +  "Source code" for a work means the preferred form of the work for
> +making modifications to it.  For a library, complete source code means
> +all the source code for all modules it contains, plus any associated
> +interface definition files, plus the scripts used to control compilation
> +and installation of the library.
> +
> +  Activities other than copying, distribution and modification are not
> +covered by this License; they are outside its scope.  The act of
> +running a program using the Library is not restricted, and output from
> +such a program is covered only if its contents constitute a work based
> +on the Library (independent of the use of the Library in a tool for
> +writing it).  Whether that is true depends on what the Library does
> +and what the program that uses the Library does.
> +  
> +  1. You may copy and distribute verbatim copies of the Library's
> +complete source code as you receive it, in any medium, provided that
> +you conspicuously and appropriately publish on each copy an
> +appropriate copyright notice and disclaimer of warranty; keep intact
> +all the notices that refer to this License and to the absence of any
> +warranty; and distribute a copy of this License along with the
> +Library.
> +
> +  You may charge a fee for the physical act of transferring a copy,
> +and you may at your option offer warranty protection in exchange for a
> +fee.
> +
> +  2. You may modify your copy or copies of the Library or any portion
> +of it, thus forming a work based on the Library, and copy and
> +distribute such modifications or work under the terms of Section 1
> +above, provided that you also meet all of these conditions:
> +
> +    a) The modified work must itself be a software library.
> +
> +    b) You must cause the files modified to carry prominent notices
> +    stating that you changed the files and the date of any change.
> +
> +    c) You must cause the whole of the work to be licensed at no
> +    charge to all third parties under the terms of this License.
> +
> +    d) If a facility in the modified Library refers to a function or a
> +    table of data to be supplied by an application program that uses
> +    the facility, other than as an argument passed when the facility
> +    is invoked, then you must make a good faith effort to ensure that,
> +    in the event an application does not supply such function or
> +    table, the facility still operates, and performs whatever part of
> +    its purpose remains meaningful.
> +
> +    (For example, a function in a library to compute square roots has
> +    a purpose that is entirely well-defined independent of the
> +    application.  Therefore, Subsection 2d requires that any
> +    application-supplied function or table used by this function must
> +    be optional: if the application does not supply it, the square
> +    root function must still compute square roots.)
> +
> +These requirements apply to the modified work as a whole.  If
> +identifiable sections of that work are not derived from the Library,
> +and can be reasonably considered independent and separate works in
> +themselves, then this License, and its terms, do not apply to those
> +sections when you distribute them as separate works.  But when you
> +distribute the same sections as part of a whole which is a work based
> +on the Library, the distribution of the whole must be on the terms of
> +this License, whose permissions for other licensees extend to the
> +entire whole, and thus to each and every part regardless of who wrote
> +it.
> +
> +Thus, it is not the intent of this section to claim rights or contest
> +your rights to work written entirely by you; rather, the intent is to
> +exercise the right to control the distribution of derivative or
> +collective works based on the Library.
> +
> +In addition, mere aggregation of another work not based on the Library
> +with the Library (or with a work based on the Library) on a volume of
> +a storage or distribution medium does not bring the other work under
> +the scope of this License.
> +
> +  3. You may opt to apply the terms of the ordinary GNU General Public
> +License instead of this License to a given copy of the Library.  To do
> +this, you must alter all the notices that refer to this License, so
> +that they refer to the ordinary GNU General Public License, version 2,
> +instead of to this License.  (If a newer version than version 2 of the
> +ordinary GNU General Public License has appeared, then you can specify
> +that version instead if you wish.)  Do not make any other change in
> +these notices.
> +
> +  Once this change is made in a given copy, it is irreversible for
> +that copy, so the ordinary GNU General Public License applies to all
> +subsequent copies and derivative works made from that copy.
> +
> +  This option is useful when you wish to copy part of the code of
> +the Library into a program that is not a library.
> +
> +  4. You may copy and distribute the Library (or a portion or
> +derivative of it, under Section 2) in object code or executable form
> +under the terms of Sections 1 and 2 above provided that you accompany
> +it with the complete corresponding machine-readable source code, which
> +must be distributed under the terms of Sections 1 and 2 above on a
> +medium customarily used for software interchange.
> +
> +  If distribution of object code is made by offering access to copy
> +from a designated place, then offering equivalent access to copy the
> +source code from the same place satisfies the requirement to
> +distribute the source code, even though third parties are not
> +compelled to copy the source along with the object code.
> +
> +  5. A program that contains no derivative of any portion of the
> +Library, but is designed to work with the Library by being compiled or
> +linked with it, is called a "work that uses the Library".  Such a
> +work, in isolation, is not a derivative work of the Library, and
> +therefore falls outside the scope of this License.
> +
> +  However, linking a "work that uses the Library" with the Library
> +creates an executable that is a derivative of the Library (because it
> +contains portions of the Library), rather than a "work that uses the
> +library".  The executable is therefore covered by this License.
> +Section 6 states terms for distribution of such executables.
> +
> +  When a "work that uses the Library" uses material from a header file
> +that is part of the Library, the object code for the work may be a
> +derivative work of the Library even though the source code is not.
> +Whether this is true is especially significant if the work can be
> +linked without the Library, or if the work is itself a library.  The
> +threshold for this to be true is not precisely defined by law.
> +
> +  If such an object file uses only numerical parameters, data
> +structure layouts and accessors, and small macros and small inline
> +functions (ten lines or less in length), then the use of the object
> +file is unrestricted, regardless of whether it is legally a derivative
> +work.  (Executables containing this object code plus portions of the
> +Library will still fall under Section 6.)
> +
> +  Otherwise, if the work is a derivative of the Library, you may
> +distribute the object code for the work under the terms of Section 6.
> +Any executables containing that work also fall under Section 6,
> +whether or not they are linked directly with the Library itself.
> +
> +  6. As an exception to the Sections above, you may also combine or
> +link a "work that uses the Library" with the Library to produce a
> +work containing portions of the Library, and distribute that work
> +under terms of your choice, provided that the terms permit
> +modification of the work for the customer's own use and reverse
> +engineering for debugging such modifications.
> +
> +  You must give prominent notice with each copy of the work that the
> +Library is used in it and that the Library and its use are covered by
> +this License.  You must supply a copy of this License.  If the work
> +during execution displays copyright notices, you must include the
> +copyright notice for the Library among them, as well as a reference
> +directing the user to the copy of this License.  Also, you must do one
> +of these things:
> +
> +    a) Accompany the work with the complete corresponding
> +    machine-readable source code for the Library including whatever
> +    changes were used in the work (which must be distributed under
> +    Sections 1 and 2 above); and, if the work is an executable linked
> +    with the Library, with the complete machine-readable "work that
> +    uses the Library", as object code and/or source code, so that the
> +    user can modify the Library and then relink to produce a modified
> +    executable containing the modified Library.  (It is understood
> +    that the user who changes the contents of definitions files in the
> +    Library will not necessarily be able to recompile the application
> +    to use the modified definitions.)
> +
> +    b) Use a suitable shared library mechanism for linking with the
> +    Library.  A suitable mechanism is one that (1) uses at run time a
> +    copy of the library already present on the user's computer system,
> +    rather than copying library functions into the executable, and (2)
> +    will operate properly with a modified version of the library, if
> +    the user installs one, as long as the modified version is
> +    interface-compatible with the version that the work was made with.
> +
> +    c) Accompany the work with a written offer, valid for at
> +    least three years, to give the same user the materials
> +    specified in Subsection 6a, above, for a charge no more
> +    than the cost of performing this distribution.
> +
> +    d) If distribution of the work is made by offering access to copy
> +    from a designated place, offer equivalent access to copy the above
> +    specified materials from the same place.
> +
> +    e) Verify that the user has already received a copy of these
> +    materials or that you have already sent this user a copy.
> +
> +  For an executable, the required form of the "work that uses the
> +Library" must include any data and utility programs needed for
> +reproducing the executable from it.  However, as a special exception,
> +the materials to be distributed need not include anything that is
> +normally distributed (in either source or binary form) with the major
> +components (compiler, kernel, and so on) of the operating system on
> +which the executable runs, unless that component itself accompanies
> +the executable.
> +
> +  It may happen that this requirement contradicts the license
> +restrictions of other proprietary libraries that do not normally
> +accompany the operating system.  Such a contradiction means you cannot
> +use both them and the Library together in an executable that you
> +distribute.
> +
> +  7. You may place library facilities that are a work based on the
> +Library side-by-side in a single library together with other library
> +facilities not covered by this License, and distribute such a combined
> +library, provided that the separate distribution of the work based on
> +the Library and of the other library facilities is otherwise
> +permitted, and provided that you do these two things:
> +
> +    a) Accompany the combined library with a copy of the same work
> +    based on the Library, uncombined with any other library
> +    facilities.  This must be distributed under the terms of the
> +    Sections above.
> +
> +    b) Give prominent notice with the combined library of the fact
> +    that part of it is a work based on the Library, and explaining
> +    where to find the accompanying uncombined form of the same work.
> +
> +  8. You may not copy, modify, sublicense, link with, or distribute
> +the Library except as expressly provided under this License.  Any
> +attempt otherwise to copy, modify, sublicense, link with, or
> +distribute the Library is void, and will automatically terminate your
> +rights under this License.  However, parties who have received copies,
> +or rights, from you under this License will not have their licenses
> +terminated so long as such parties remain in full compliance.
> +
> +  9. You are not required to accept this License, since you have not
> +signed it.  However, nothing else grants you permission to modify or
> +distribute the Library or its derivative works.  These actions are
> +prohibited by law if you do not accept this License.  Therefore, by
> +modifying or distributing the Library (or any work based on the
> +Library), you indicate your acceptance of this License to do so, and
> +all its terms and conditions for copying, distributing or modifying
> +the Library or works based on it.
> +
> +  10. Each time you redistribute the Library (or any work based on the
> +Library), the recipient automatically receives a license from the
> +original licensor to copy, distribute, link with or modify the Library
> +subject to these terms and conditions.  You may not impose any further
> +restrictions on the recipients' exercise of the rights granted herein.
> +You are not responsible for enforcing compliance by third parties with
> +this License.
> +
> +  11. If, as a consequence of a court judgment or allegation of patent
> +infringement or for any other reason (not limited to patent issues),
> +conditions are imposed on you (whether by court order, agreement or
> +otherwise) that contradict the conditions of this License, they do not
> +excuse you from the conditions of this License.  If you cannot
> +distribute so as to satisfy simultaneously your obligations under this
> +License and any other pertinent obligations, then as a consequence you
> +may not distribute the Library at all.  For example, if a patent
> +license would not permit royalty-free redistribution of the Library by
> +all those who receive copies directly or indirectly through you, then
> +the only way you could satisfy both it and this License would be to
> +refrain entirely from distribution of the Library.
> +
> +If any portion of this section is held invalid or unenforceable under any
> +particular circumstance, the balance of the section is intended to apply,
> +and the section as a whole is intended to apply in other circumstances.
> +
> +It is not the purpose of this section to induce you to infringe any
> +patents or other property right claims or to contest validity of any
> +such claims; this section has the sole purpose of protecting the
> +integrity of the free software distribution system which is
> +implemented by public license practices.  Many people have made
> +generous contributions to the wide range of software distributed
> +through that system in reliance on consistent application of that
> +system; it is up to the author/donor to decide if he or she is willing
> +to distribute software through any other system and a licensee cannot
> +impose that choice.
> +
> +This section is intended to make thoroughly clear what is believed to
> +be a consequence of the rest of this License.
> +
> +  12. If the distribution and/or use of the Library is restricted in
> +certain countries either by patents or by copyrighted interfaces, the
> +original copyright holder who places the Library under this License may add
> +an explicit geographical distribution limitation excluding those countries,
> +so that distribution is permitted only in or among countries not thus
> +excluded.  In such case, this License incorporates the limitation as if
> +written in the body of this License.
> +
> +  13. The Free Software Foundation may publish revised and/or new
> +versions of the Lesser General Public License from time to time.
> +Such new versions will be similar in spirit to the present version,
> +but may differ in detail to address new problems or concerns.
> +
> +Each version is given a distinguishing version number.  If the Library
> +specifies a version number of this License which applies to it and
> +"any later version", you have the option of following the terms and
> +conditions either of that version or of any later version published by
> +the Free Software Foundation.  If the Library does not specify a
> +license version number, you may choose any version ever published by
> +the Free Software Foundation.
> +
> +  14. If you wish to incorporate parts of the Library into other free
> +programs whose distribution conditions are incompatible with these,
> +write to the author to ask for permission.  For software which is
> +copyrighted by the Free Software Foundation, write to the Free
> +Software Foundation; we sometimes make exceptions for this.  Our
> +decision will be guided by the two goals of preserving the free status
> +of all derivatives of our free software and of promoting the sharing
> +and reuse of software generally.
> +
> +			    NO WARRANTY
> +
> +  15. BECAUSE THE LIBRARY IS LICENSED FREE OF CHARGE, THERE IS NO
> +WARRANTY FOR THE LIBRARY, TO THE EXTENT PERMITTED BY APPLICABLE LAW.
> +EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR
> +OTHER PARTIES PROVIDE THE LIBRARY "AS IS" WITHOUT WARRANTY OF ANY
> +KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE
> +IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
> +PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE
> +LIBRARY IS WITH YOU.  SHOULD THE LIBRARY PROVE DEFECTIVE, YOU ASSUME
> +THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
> +
> +  16. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN
> +WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY
> +AND/OR REDISTRIBUTE THE LIBRARY AS PERMITTED ABOVE, BE LIABLE TO YOU
> +FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR
> +CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE
> +LIBRARY (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
> +RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
> +FAILURE OF THE LIBRARY TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
> +SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
> +DAMAGES.
> +
> +		     END OF TERMS AND CONDITIONS
> +
> +           How to Apply These Terms to Your New Libraries
> +
> +  If you develop a new library, and you want it to be of the greatest
> +possible use to the public, we recommend making it free software that
> +everyone can redistribute and change.  You can do so by permitting
> +redistribution under these terms (or, alternatively, under the terms of the
> +ordinary General Public License).
> +
> +  To apply these terms, attach the following notices to the library.  It is
> +safest to attach them to the start of each source file to most effectively
> +convey the exclusion of warranty; and each file should have at least the
> +"copyright" line and a pointer to where the full notice is found.
> +
> +    <one line to give the library's name and a brief idea of what it does.>
> +    Copyright (C) <year>  <name of author>
> +
> +    This library is free software; you can redistribute it and/or
> +    modify it under the terms of the GNU Lesser General Public
> +    License as published by the Free Software Foundation; either
> +    version 2.1 of the License, or (at your option) any later version.
> +
> +    This library is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +    Lesser General Public License for more details.
> +
> +    You should have received a copy of the GNU Lesser General Public
> +    License along with this library; if not, write to the Free Software
> +    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +
> +Also add information on how to contact you by electronic and paper mail.
> +
> +You should also get your employer (if you work as a programmer) or your
> +school, if any, to sign a "copyright disclaimer" for the library, if
> +necessary.  Here is a sample; alter the names:
> +
> +  Yoyodyne, Inc., hereby disclaims all copyright interest in the
> +  library `Frob' (a library for tweaking knobs) written by James Random Hacker.
> +
> +  <signature of Ty Coon>, 1 April 1990
> +  Ty Coon, President of Vice
> +
> +That's all there is to it!
> +
> +
> diff --git a/refpol_ilc/Makefile b/refpol_ilc/Makefile
> new file mode 100644
> index 0000000..f6cdb14
> --- /dev/null
> +++ b/refpol_ilc/Makefile
> @@ -0,0 +1,24 @@
> +PREFIX ?= $(DESTDIR)/usr
> +BINDIR ?= $(PREFIX)/bin
> +
> +PYTHON ?= python
> +
> +ifneq ($(origin DESTDIR), undefined)
> +	PYDESTDIR ?= --root=$(DESTDIR)
> +endif
> +
> +TARGET = refpol_ilc.py
> +
> +all:
> +	$(PYTHON) setup.py build
> +
> +install:
> +	$(PYTHON) setup.py install $(PYDESTDIR)
> +	-mkdir -p $(BINDIR)
> +	install -m 755 $(TARGET) $(BINDIR)/$(TARGET:.py=)
> +
> +clean distclean:
> +	$(PYTHON) setup.py clean
> +	rm -fr build
> +	rm -f refpol_ilc/*.pyc
> +
> diff --git a/refpol_ilc/refpol_ilc.py b/refpol_ilc/refpol_ilc.py
> new file mode 100755
> index 0000000..31021b4
> --- /dev/null
> +++ b/refpol_ilc/refpol_ilc.py
> @@ -0,0 +1,17 @@
> +#!/usr/bin/python
> +
> +# Authors:	Caleb Case <ccase@tresys.com>
> +#
> +# Copyright (C) 2009-2010 Tresys Technology, LLC
> +#      This program is free software; you can redistribute it and/or modify
> +#      it under the terms of the Lesser GNU General Public License as 
> +#      published by the Free Software Foundation, version 2.
> +
> +import refpol_ilc.refpol_ilc
> +import sys
> +
> +try:
> +	refpol_ilc.refpol_ilc.main()
> +except Exception as e:
> +	sys.stderr.write(sys.argv[0] + ": Error: " + str(e) + "\n")
> +	sys.exit(1)
> diff --git a/refpol_ilc/refpol_ilc/__init__.py b/refpol_ilc/refpol_ilc/__init__.py
> new file mode 100644
> index 0000000..e69de29
> diff --git a/refpol_ilc/refpol_ilc/refpol_ilc.py b/refpol_ilc/refpol_ilc/refpol_ilc.py
> new file mode 100644
> index 0000000..7e5430e
> --- /dev/null
> +++ b/refpol_ilc/refpol_ilc/refpol_ilc.py
> @@ -0,0 +1,193 @@
> +#!/usr/bin/python
> +
> +# Authors:	Caleb Case <ccase@tresys.com>
> +#
> +# Copyright (C) 2009-2010 Tresys Technology, LLC
> +#      This program is free software; you can redistribute it and/or modify
> +#      it under the terms of the Lesser GNU General Public License as 
> +#      published by the Free Software Foundation, version 2.
> +
> +from optparse import OptionParser, OptionGroup
> +import os
> +import os.path
> +import tempfile
> +from refpol import refpol
> +from refpol import refpolicy2refpol
> +import shutil
> +import subprocess
> +import sys
> +
> +build_directory = "/usr/share/selinux/refpol_ilc/build"
> +
> +# setup PATH (for gcc) if missing
> +if not "PATH" in os.environ:
> +	os.environ["PATH"] = "/bin:/usr/bin"
> +
> +def to_bool(str):
> +	return 	{
> +			"true"	: True,
> +			"t"	: True,
> +			"1"	: True,
> +			"false"	: False,
> +			"f"	: False,
> +			"0"	: False,
> +		}[str.lower()]
> +
> +usage = "%prog [OPTIONS] MODULE MODULE ..."
> +version = "%prog 1.0"
> +
> +def main():
> +	def disabled(option, opt_str, value, parser, *args, **kwargs):
> +		parser.values.disabled.append(value)
> +
> +	# create cmdline parser
> +	parser = OptionParser(usage = usage, version = version)
> +	parser.add_option("-d", "--disabled", action = "callback", callback = disabled, type = "string", default = [], dest = "disabled", help = "indicates module is disabled", metavar = "FILE")
> +	parser.add_option("-f", "--force", action = "store_true", default = False, dest = "force", help = "force overwriting existing files")
> +	parser.add_option("-t", "--tmp", action = "store", default = None, dest = "tmp", help = "temporary build directory", metavar = "DIR")
> +	parser.add_option("-b", "--build-template", action = "store", default = build_directory, dest = "build_template", help = "build template directory (Default: %s)" % build_directory, metavar = "DIR")
> +	parser.add_option("-o", "--output", action = "store", default = None, dest = "output", help = "output file", metavar = "FILE")
> +	parser.add_option("-c", "--cleanup", action = "store", default = "True", dest = "cleanup", help = "cleanup (remove) temporary directory (Default: True)", metavar = "BOOL")
> +
> +	# parse cmdline
> +	(options, args) = parser.parse_args()
> +	if len(args) <= 0:
> +		parser.error("Invalid number of arguments %d." % len(args))
> +
> +	# save the working directory
> +	saved_cwd = os.getcwd()
> +
> +	force = options.force
> +	refpol.force = options.force
> +	refpolicy2refpol.force = options.force
> +
> +	if options.output is None:
> +		options.output = sys.stdout
> +	else:
> +		refpol.file_exists(options.output)
> +		options.output = open(options.output, "w")
> +
> +	try:
> +		if not options.tmp:
> +			# create tmp build dir if one isn't provided
> +			options.tmp = tempfile.mkdtemp("-refpol_ilc")
> +		else:
> +			shutil.rmtree(options.tmp, ignore_errors = True)
> +			os.mkdir(options.tmp)
> +
> +		# copy build dir template
> +		build_root = options.tmp + "/build"
> +		shutil.copytree(options.build_template, build_root)
> +
> +		# set default policy TYPE
> +		type = "standard"
> +
> +		# copy modules into build dir
> +		special_names = dict(zip(["_" + os.path.basename(i).rsplit('.', 1)[0] for i in refpolicy2refpol.specials("")], refpolicy2refpol.specials(build_root)))
> +		disabled_names = [os.path.basename(os.path.dirname(i)) for i in options.disabled]
> +
> +		all_modules = []
> +		all_modules.extend(args)
> +		all_modules.extend(options.disabled)
> +		for path in all_modules:
> +			module_name = os.path.basename(os.path.dirname(path))
> +
> +			if module_name in special_names and not module_name in disabled_names:
> +				if module_name == "_mls":
> +					type = "mls"
> +				elif module_name == "_mcs" and type != "mls":
> +					type = "mcs"
> +
> +				# copy to special location
> +				with open(path, "r") as input:
> +					with open(special_names[module_name], "w") as output:
> +						for line in input:
> +							# remove policy_module statement
> +							if not line.strip().startswith("policy_module"):
> +								output.write(line)
> +			elif module_name == "_defines":
> +				shutil.copy(path, build_root + "/_defines.ref")
> +			else:
> +				# copy module to policy/kernel/
> +				dest_ref = build_root + "/policy/modules/kernel/" + module_name + ".ref"
> +				dest_name = build_root + "/policy/modules/kernel/" + module_name
> +				shutil.copy(path, dest_ref)
> +				
> +				refpol.ref_to_itf(dest_ref, dest_name + ".if", dest_name + ".te", dest_name + ".fc")
> +
> +		os.chdir(build_root)
> +
> +		# compose build.conf (build.conf.in from _defines.ref)
> +		with open("_defines.ref", "r") as input:
> +			with open("build.conf", "w") as output:
> +				# write out the type
> +				output.write("TYPE = %s\n\n" % type)
> +
> +				# write out monolithic
> +				output.write("MONOLITHIC = n\n\n")
> +
> +				for line in input:
> +					# remove policy_module statement
> +					if not line.strip().startswith("policy_module"):
> +						output.write(line)
> +
> +		# make conf
> +		p = subprocess.Popen("make conf", shell = True, stdout = subprocess.PIPE, stderr = subprocess.PIPE, close_fds = True)
> +
> +		(stdout, stderr) = p.communicate()
> +		sys.stderr.write(stdout)
> +		sys.stderr.write(stderr)
> +
> +		if p.returncode != 0:
> +			raise Exception("Failed to run make conf (%d)." % p.returncode)
> +
> +		# sed modules.conf to base module if enabled
> +		sed_cmd = "sed -i '1,/^END/{ s/= module/= base/; "
> +		disabled_len = len(options.disabled)
> +		if disabled_len > 0:
> +			sed_cmd = sed_cmd + "s/\\("
> +			i = 0
> +			for d in options.disabled:
> +				i = i + 1
> +				sed_cmd = sed_cmd + os.path.basename(os.path.dirname(d))
> +				if i != disabled_len:
> +					sed_cmd = sed_cmd + "\\|"
> +			sed_cmd = sed_cmd + "\\) = base/\\1 = off/ "
> +		sed_cmd = sed_cmd + "}' policy/modules.conf"
> +
> +		p = subprocess.Popen(sed_cmd, shell = True, stdout = subprocess.PIPE, stderr = subprocess.PIPE, close_fds = True)
> +
> +		(stdout, stderr) = p.communicate()
> +		sys.stderr.write(stdout)
> +		sys.stderr.write(stderr)
> +
> +		if p.returncode != 0:
> +			raise Exception("Failed to modify modules.conf (%d)." % p.returncode)
> +
> +		# make base module
> +		p = subprocess.Popen("make base.pp", shell = True, stdout = subprocess.PIPE, stderr = subprocess.PIPE, close_fds = True)
> +
> +		(stdout, stderr) = p.communicate()
> +		sys.stderr.write(stdout)
> +		sys.stderr.write(stderr)
> +
> +		if p.returncode != 0:
> +			raise Exception("Failed to run make base.pp (%d)." % p.returncode)
> +
> +		# output base module
> +		options.output.write(open("base.pp", "r").read())
> +	finally:
> +		if to_bool(options.cleanup):
> +			shutil.rmtree(options.tmp)
> +
> +		options.output.close()
> +
> +		# return the saved directory
> +		os.chdir(saved_cwd)
> +
> +if __name__ == '__main__':
> +	try:
> +		main()
> +	except Exception as e:
> +		sys.stderr.write(sys.argv[0] + ": Error: " + str(e) + "\n")
> +		sys.exit(1)
> diff --git a/refpol_ilc/setup.py b/refpol_ilc/setup.py
> new file mode 100755
> index 0000000..31c3a14
> --- /dev/null
> +++ b/refpol_ilc/setup.py
> @@ -0,0 +1,13 @@
> +#!/usr/bin/python
> +
> +from distutils.core import setup
> +
> +setup(	name		= "refpol_ilc",
> +	version		= "0.1",
> +	description	= "Refpol Intermediate Language Compiler",
> +#	url		= "",
> +	author		= "Caleb Case",
> +	author_email	= "ccase@tresys.com",
> +	license		= "LGPL v2.1",
> +	packages	= ['refpol_ilc'],
> +	)

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
