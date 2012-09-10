Message-ID: <1347305301.9456.122.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: The SELinux Notebook 3rd Edition
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Date: Mon, 10 Sep 2012 15:28:21 -0400
In-Reply-To: <1346683819.9228.YahooMailClassic@web87706.mail.ir2.yahoo.com>
References: <1346683819.9228.YahooMailClassic@web87706.mail.ir2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-09-03 at 15:50 +0100, Richard Haines wrote:
> I've just published the 3rd edition of the SELinux Notebook at:
> http://www.freetechbooks.com/the-selinux-notebook-the-foundations-t785.html
> that covers:
>     a) SELinux and its purpose in life.
>     b) The LSM / SELinux architecture, its supporting services and how
>        they are implemented within GNU / Linux.
>     c) SELinux Networking, Virtual Machine, X-Windows, PostgreSQL and
>        Apache/SELinux-Plus SELinux-aware capabilities.
>     d) The core SELinux policy language and how basic policy modules can
>        be constructed for instructional purposes.
>     e) The core SELinux policy management tools with examples of usage.
>     f) The Reference Policy architecture, its supporting services and how
>        it is implemented.
>     g) The integration of SELinux within Android - SEAndroid.
> 
> To demonstrate some of the SELinux capabilities, a supporting Notebook
> source tarball is available (notebook-source-3.0.tar.gz) that contains:
>     a) Building a Basic Policy - Describes how to build monolithic, base
>        and loadable policy modules using core policy language statements
>        and SELinux commands. This expands to a simple message filter
>        using SECMARK, NetLabel and Labeled IPSec that also has a CIL
>        policy version.
>     b) Example libselinux applications - This contains over 100 samples
>        that use all libselinux 2.1.6 functions. There are also some
>        supporting policy modules for the Fedora 16/17 targeted policy
>        to show how the functions work.
>     c) Experimenting with X-Windows - Builds a sample selection manager
>        application, a simple test application for the XSELinux extension
>        Get/Set functions.
>     d) Experimenting with PostgreSQL 9.1 using sepgsql - This shows how
>        to create a simple database that uses SELinux functionality.
>        This is then expanded to demonstrate adding additional functions
>        to support libselinux. There are also demos using Apache with
>        threads (mod_selinux), PHP, Labeled IPSec and NetLabel.
>        The policy modules supplied have been tested using Fedora 16/17
>        targeted policy.
> 
> I'll start updating the selinuxproject.org site with the new text over
> the next month or so. If you find any errors please let me know.

You are a brave soul to start documenting SE Android ;)  Some minor
corrections:

* 7.1.2 SEAndroid Project Updates, page 300:  There have been some
changes/additions to the libselinux interfaces, e.g. _setfilecon2 which
takes a seinfo argument and the new interfaces for policy loading.
Also, the reload interface isn't being used anymore (from outside of
libselinux), as we switched installd from calling it upon a policy
reload to simply re-starting installd completely.

* 7.2 Policy Configuration Files, page 303:  The list of device specific
files isn't quite right; in particular sepolicy.fs_use,
sepolicy.genfs_contexts, sepolicy.initial_sid_contexts.  Plus the recent
addition of a per-device seapp_contexts configuration that is merged
into the base seapp_contexts via the checkseapp utility.  system.prop
isn't a SE Android file.  I suspect there will be further changes here
before we are done, likely ending with a per-device sepolicy
subdirectory tree that can override/augment any of the base policy
files.

* Same section, page 304: The property name is selinux.reload_policy.
Needs to be fixed both in the body and the footnote 64.

* 7.2.1 seapp_context (should be seapp_contexts), page 304:  Looks like
you have an extra word in item 3 ("user= equal string").  Typically the
configuration is automatically loaded on first use of one of the
_setcontext() or _setfilecon() interfaces.

* 7.2.1.1 selinux_android_setcontext, page 304-306:  Not sure this will
make sense to anyone without an understanding of what the inputs all
mean, the Android username encoding, and the history of the code
(particularly the evolution in Android username encodings from app_N to
uM_aN and uM_iN in the 4.1/JB release).  Also, the username encoding has
further changed in latest master, so we now have to deal with uM_system
and the like.  But the Examples section is nice.

* 7.2.1.2, selinux_android_setfilecon, page 307-:  We have replaced this
with an extended interface, _setfilecon2, that takes the seinfo argument
as well, thereby allowing labeling the /data/data directory based on
seinfo.  As the core logic is now essentially the same, might want to
just describe it once with the differences noted within.

* 7.2.2 property_context, page 309:  Should be property_contexts.

* Same section, page 310:  I think the label backend only supports a
fixed string (that is used as a prefix match) or a * (that is used to
cover anything not otherwise specified).  No ? and no string containing
any meta-characters.

* 7.3, SEAndroid Classes & Permissions, page 312:
Actual meanings of the binder permissions:
** impersonate: Perform a binder IPC on behalf of another process. Can A
impersonate B on an IPC?
** call: Perform a binder IPC to a given target process.  Can A call B?
** set_context_mgr:  Register self as the Binder Context Manager aka
servicemanager (global name service).  Can A set the context manager to
B, where normally A == B.
** transfer: Transfer a binder reference to another process.  Can A
transfer a binder reference owned by B?
** receive:  Receive a binder reference from another process.  Can A
receive a binder referenced owned by B?

* Same section, page 313:
** specifyseinfo:  Specify a seinfo string for use in determining the
app security label.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
