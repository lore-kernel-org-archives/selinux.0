Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3SEXiKI006943
 for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2015 10:33:44 -0400
References: <1430136696-1254-1-git-send-email-richard_c_haines@btinternet.com>
 <553E429F.8080909@tycho.nsa.gov> <553E450E.8090403@tycho.nsa.gov>
Message-ID: <1430231450.50153.YahooMailNeo@web133204.mail.ir2.yahoo.com>
Date: Tue, 28 Apr 2015 15:30:50 +0100
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [RFC PATCH] selinux: Merge Android libselinux changes with
 upstream
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <553E450E.8090403@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Eric Paris <eparis@redhat.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for the feedback on this. As I'm in the process of adding the
file_contexts.bin support to Android I'll complete this and also add
the best match and partial match support to upstream. I'll try various
corrupt file contexts files and fix any problems I find.

I'll probably have ago at the context translation as that is the major
difference between the two. If anyone has ideas about how to best
implement this let me know.

As for the rest - well who knows !!!



----- Original Message -----
> From: Stephen Smalley <sds@tycho.nsa.gov>
> To: Richard Haines <richard_c_haines@btinternet.com>; selinux@tycho.nsa.gov
> Cc: Daniel J Walsh <dwalsh@redhat.com>; Eric Paris <eparis@redhat.com>; Miroslav Grepl <mgrepl@redhat.com>; Petr Lautrbach <plautrba@redhat.com>
> Sent: Monday, 27 April 2015, 15:17
> Subject: Re: [RFC PATCH] selinux: Merge Android libselinux changes with upstream
> 
> On 04/27/2015 10:07 AM, Stephen Smalley wrote:
> 
>>  On 04/27/2015 08:11 AM, Richard Haines wrote:
>>>  This RFC patch takes the libselinux changes from AOSP master
>>>  and merges them into the SELinux project source from
>>>  https://github.com/SELinuxProject/selinux
>>> 
>>>  checkpolicy, libselinux and libsepol have been updated with the
>>>  appropriate Android.mk files and licences.
>>> 
>>>  The majority of changes were minor and use ifdef/ifndef, however:
>>>  1) label_file.c from Android was renamed label_android_file.c
>>>     as the changes between them were great (Android does not
>>>     currently use the *.bin file_contexts file)
>>>     There is a request to add this support to Android (see
>>>     https://bitbucket.org/seandroid/wiki/wiki/ToDo), but left it
>>>     until later (just in case this patch does not fly at all).
>>> 
>>>  2) procattr.c has been modified to support both but looks messy.
>>> 
>>>  3) Not all Android changes were added as they did not seem necessary,
>>>     for example include/selinux/selinux.h was not modified.
>>> 
>>>  4) libselinux/src/Makefile was modified to build the required modules.
>>> 
>>>  5) The Android.mk file was modified to add src/enabled.c because
>>>     callbacks.c calls is_selinux_enabled.
>>>     Also for non-user TARGET_BUILD_VARIANT add booleans.c because
>>>     external/ltrace/sysdeps/linux-gnu/trace.c requires
>>>     security_get_boolean_active, otherwise booleans could be removed.
>>> 
>>>  These changes have been tested on Fedora 21 and Android master
>>>  builds (eng and user) using the emulator with no problems (the
>>>  external/checkpolicy, external/libselinux and external/libsepol
>>>  projects were removed).
>>>  The testing was not extensive and consisted of checking bootloading,
>>>  labeling and running apps (Android) and checking the libselinux/sepol
>>>  functions on Fedora.
>>> 
>>>  Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> 
>>  NAK.  I agree with the end goal but not the approach taken here.
>> 
>>  What I would prefer is a more incremental approach, e.g. (in no specific
>>  order):
>> 
>>  - port individual changes from upstream libselinux to Android libselinux
>>  that occurred after the fork, such as the file_contexts.bin support (in
>>  doing so, taking a careful look at that change and consider improving
>>  it, as it looked a bit suspect to me; consider an ill-formed/corrupted
>>  file_contexts.bin file and how well the current parsing code will handle
>>  that situation),
>> 
>>  - port individual changes from Android libselinux to upstream
>>  libselinux, such as the extensions to the selabel interface and
>>  label_file backend for best match and partial match support, and
>>  consider using them for equivalent functionality in Linux distributions
>>  for enabling labeling of device nodes based on stable partition names
>>  and fast labeling of all of /sys at boot,
>> 
>>  - wrap any residual glibc-specific dependencies in upstream libselinux
>>  with conditional code to allow use of other libc implementations like
>>  bionic,
>> 
>>  - reconsider the handling of context translation in upstream libselinux;
>>  it adds overhead to every non-raw call and mcstrans is not
>>  installed/active by default, so this is wasted on most installs; for
>>  Android, we made the _raw behavior the default and only behavior,
>> 
>>  - reconsider the procattr cache in upstream libselinux; it was allegedly
>>  added to improve performance but seems to have grown ever more complex
>>  and has caused subtle breakages; it would be useful to revisit whether
>>  it is in fact worth retaining,
>> 
>>  - consider dropping some legacy functions/interfaces and compatibility
>>  code from upstream libselinux that we intentionally dropped from the
>>  Android libselinux,
>> 
>>  - generalize all policy pathname definition/code in upstream libselinux
>>  so that it works cleanly on Android or Linux distributions,
>> 
>>  - Consider taking selinux_android_restorecon() to upstream libselinux as
>>  a general selinux_restorecon() function and rewriting
>>  policycoreutils/setfiles to use it instead.
>> 
>>  Also, it makes no sense to add MODULE_LICENSE_* or NOTICE files to
>>  upstream selinux because they merely duplicate information already in
>>  upstream COPYING or LICENSE files just for the sake of conventions
>>  preferred by Android.  Those additional files only need to exist in the
>>  Android tree.  Possibly even the Android.mk files don't belong in the
>>  upstream selinux tree since they are only ever used in the Android
>>  build, but I did previously upstream the files for libsepol and
>>  checkpolicy.  I don't think those are usually upstreamed however for
>>  other external projects.
>> 
>>  I would minimize use of #ifdefs, and only use them when it is truly an
>>  Android-specific change.
>> 
>>  I recognize that this approach is a lot more work and will take longer,
>>  but I think it will yield a better result for both upstream and Android.
> 
> Also, note that some of the differences between upstream libselinux and
> Android libselinux were due to limitations of bionic at the time we
> originally did the port and are no longer true of current bionic, e.g.
> bionic did not have a getline() implementation when we started but now
> includes OpenBSD's getline() implementation.
> 
