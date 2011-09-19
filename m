Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8JBV6Ll008330
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2011 07:31:06 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8JBV32U022025
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2011 11:31:04 GMT
Message-ID: <4E7727D9.1060002@redhat.com>
Date: Mon, 19 Sep 2011 07:30:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: Eric Paris <eparis@parisplace.org>, russell@coker.com.au,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v3] semanage.conf manual page
References: <201109011509.05872.russell@coker.com.au>  <4E5F8BAA.6060208@redhat.com> <1314912106.2334.2.camel@vortex>  <CACLa4ptfSU3obZ8OyMVFfKDsqwLQn58-O9YRUbCyU8=mLzn=tA@mail.gmail.com>  <1315862884.2223.33.camel@vortex> <1315890045.2177.47.camel@vortex>  <1315891657.2177.49.camel@vortex> <1315929804.2248.5.camel@vortex> <1316062311.23290.89.camel@vortex>
In-Reply-To: <1316062311.23290.89.camel@vortex>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/15/2011 12:51 AM, Guido Trentalancia wrote:
> An updated version of this patch is now available because the
> previous patch was no longer applying cleanly after a few Makefiles
> had been changed:
> 
> Create a manual page for semanage.conf (section 5).
> 
> Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> 
> --- diff -pruN
> selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/man/Makefile
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libselinux/man/Makefile
>
> 
- ---
selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/man/Makefile
2011-09-15 05:21:20.959262094 +0200
> +++
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libselinux/man/Makefile
> 2011-09-15 06:38:01.739574479 +0200 @@ -1,7 +1,8 @@ # Installation
> directories. -MAN8DIR ?= $(DESTDIR)/usr/share/man/man8 -MAN5DIR ?=
> $(DESTDIR)/usr/share/man/man5 -MAN3DIR ?=
> $(DESTDIR)/usr/share/man/man3 +PREFIX ?= $(DESTDIR)/usr +MAN3DIR ?=
> $(PREFIX)/share/man/man3 +MAN5DIR ?= $(PREFIX)/share/man/man5 
> +MAN8DIR ?= $(PREFIX)/share/man/man8
> 
> all:
> 
> @@ -12,4 +13,3 @@ install: install -m 644 man3/*.3 $(MAN3DIR) 
> install -m 644 man5/*.5 $(MAN5DIR) install -m 644 man8/*.8
> $(MAN8DIR) - diff -pruN
> selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/man/Makefile.orig
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libselinux/man/Makefile.orig
>
> 
- ---
selinux-14092011-patch-v5-do-not-modify-library-link-creation/libselinux/man/Makefile.orig
1970-01-01 01:00:00.000000000 +0100
> +++
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libselinux/man/Makefile.orig
> 2011-09-15 06:28:17.238120345 +0200 @@ -0,0 +1,15 @@ +#
> Installation directories. +MAN8DIR ?=
> $(DESTDIR)/usr/share/man/man8 +MAN5DIR ?=
> $(DESTDIR)/usr/share/man/man5 +MAN3DIR ?=
> $(DESTDIR)/usr/share/man/man3 + +all: + +install: +	mkdir -p
> $(MAN3DIR) +	mkdir -p $(MAN5DIR) +	mkdir -p $(MAN8DIR) +	install -m
> 644 man3/*.3 $(MAN3DIR) +	install -m 644 man5/*.5 $(MAN5DIR) +
> install -m 644 man8/*.8 $(MAN8DIR) + diff -pruN
> selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/man/Makefile
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libsemanage/man/Makefile
>
> 
- ---
selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/man/Makefile
2011-09-15 05:21:20.959262094 +0200
> +++
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libsemanage/man/Makefile
> 2011-09-15 06:42:00.734396974 +0200 @@ -1,9 +1,12 @@ # Installation
> directories. -MAN3DIR ?= $(DESTDIR)/usr/share/man/man3 +PREFIX ?=
> $(DESTDIR)/usr +MAN3DIR ?= $(PREFIX)/share/man/man3 +MAN5DIR ?=
> $(PREFIX)/share/man/man5
> 
> all:
> 
> install: mkdir -p $(MAN3DIR) +	mkdir -p $(MAN5DIR) install -m 644
> man3/*.3 $(MAN3DIR) - +	install -m 644 man5/*.5 $(MAN5DIR) diff
> -pruN
> selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/man/man5/semanage.conf.5
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libsemanage/man/man5/semanage.conf.5
>
> 
- ---
selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/man/man5/semanage.conf.5
1970-01-01 01:00:00.000000000 +0100
> +++
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libsemanage/man/man5/semanage.conf.5
> 2011-09-15 06:42:41.066704601 +0200 @@ -0,0 +1,93 @@ +.TH
> semanage.conf "5" "September 2011" "semanage.conf" "Linux System
> Administration" +.SH NAME +semanage.conf \- global configuration
> file for the SELinux Management library +.SH DESCRIPTION +.PP +The 
> +.BR semanage.conf +file is usually located under the directory
> /etc/selinux and it is used for run-time configuration of the 
> +behavior of the SELinux Management library. + +.PP +Each line
> should contain a configuration parameter followed by the equal sign
> ("=") and then followed by the configuration value for that 
> +parameter. Anything after the "#" symbol is ignored similarly to
> empty lines. + +.PP +The following parameters are allowed: + +.RS 
> +.TP +.B module-store +Specify how the SELinux Management library
> should interact with the SELinux policy store. When set to
> "direct", the SELinux +Management library writes to the SELinux
> policy module store directly (this is the default setting). 
> +Otherwise a socket path or a server name can be used for the
> argument. +If the argument begins with "/" (as in "/foo/bar"), it
> represents the path to a named socket that should be used to
> connect the policy management +server. +If the argument does not
> begin with a "/" (as in "foo.com:4242"), it should be interpreted
> as the name of a remote policy management server +to be used
> through a TCP connection (default port is 4242 unless a different
> one is specified after the server name using the colon to separate 
> +the two fields). + +.TP +.B policy-version +When generating the
> policy, by default +.BR semanage +will set the policy version to
> POLICYDB_VERSION_MAX, as defined in <sepol/policydb/policydb.h>.
> Change this setting if a different +version needs to be set for the
> policy. + +.TP +.B expand-check +Whether or not to check
> "neverallow" rules when executing all +.BR semanage +command. It
> can be set to either "0" (disabled) or "1" (enabled) and by default
> it is enabled. There might be a large +penalty in execution time if
> this option is enabled. + +.TP +.B file-mode +By default the
> permission mode for the run-time policy files is set to 0644. + 
> +.TP +.B save-previous +It controls whether the previous module
> directory is saved after a successful commit to the policy store
> and it can be set to +either "true" or "false". By default it is
> set to "false" (the previous version is deleted). + +.TP +.B
> save-linked +It controls whether the previously linked module is
> saved (with name "base.linked") after a successful commit to the
> policy store. +It can be set to either "true" or "false" and by
> default it is set to "false" (the previous module is deleted). + 
> +.TP +.B usepasswd +Whether or not to enable the use getpwent() to
> obtain a list of home directories to label. It can be set to either
> "true" or "false". +By default it is set to "true". + +.TP +.B
> disable-genhomedircon +It controls whether or not the genhomedircon
> function is executed when using the +.BR semanage +command and it
> can be set to either "false" or "true". By default the
> genhomedircon functionality is enabled (equivalent +to this option
> set to "false"). + +.TP +.B handle-unknown +This option controls
> the kernel behavior for handling permissions defined in the kernel
> but missing from the actual policy. +It can be set to "deny",
> "reject" or "allow". + +.TP +.B bzip-blocksize +It should be in the
> range 0-9. A value of 0 means no compression. By default the bzip
> block size is set to 9 (actual block +size value is obtained after
> multiplication by 100000). + +.TP +.B bzip-small +When set to
> "true", the bzip algorithm shall try to reduce its system memory
> usage. It can be set to either "true" or "false" and +by default it
> is set to "false". + +.SH "SEE ALSO" +.TP +semanage(8) +.PP + +.SH
> AUTHOR +This manual page was written by Guido Trentalancia
> <guido@trentalancia.com>. + +The SELinux management library was
> written by Tresys Technology LLC and Red Hat Inc. diff -pruN
> selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsemanage/tests/test_semanage_store.c
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libsemanage/tests/test_semanage_store.c
>
> 
diff -pruN
selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsepol/man/Makefile
selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libsepol/man/Makefile
> ---
> selinux-14092011-patch-v5-do-not-modify-library-link-creation/libsepol/man/Makefile
> 2011-09-15 05:21:20.959262094 +0200 +++
> selinux-14092011-patch-v5-do-not-modify-library-link-creation-new-semanage.conf-manual-page/libsepol/man/Makefile
> 2011-09-15 06:38:54.892976846 +0200 @@ -1,6 +1,7 @@ # Installation
> directories. -MAN8DIR ?= $(DESTDIR)/usr/share/man/man8 -MAN3DIR ?=
> $(DESTDIR)/usr/share/man/man3 +PREFIX ?= $(DESTDIR)/usr +MAN3DIR ?=
> $(PREFIX)/share/man/man3 +MAN8DIR ?= $(PREFIX)/share/man/man8
> 
> all:
> 
> 
> On Tue, 2011-09-13 at 18:03 +0200, Guido Trentalancia wrote:
>> The new semanage.conf(5) manual page actually goes much better in
>> the libsemanage directory...
>> 
>> First introduce the support for the PREFIX variable in the
>> Makefiles for libraries' manual pages:
>> 
>> --- selinux/libselinux/man/Makefile	2011-09-09 20:12:55.982662190
>> +0200 +++
>> selinux-13092011-new-manual-pages/libselinux/man/Makefile
>> 2011-09-13 17:48:46.300905476 +0200 @@ -1,7 +1,8 @@ #
>> Installation directories. -MAN8DIR ?=
>> $(DESTDIR)/usr/share/man/man8 -MAN5DIR ?=
>> $(DESTDIR)/usr/share/man/man5 -MAN3DIR ?=
>> $(DESTDIR)/usr/share/man/man3 +PREFIX ?= $(DESTDIR)/usr +MAN3DIR
>> ?= $(PREFIX)/share/man/man3 +MAN5DIR ?= $(PREFIX)/share/man/man5 
>> +MAN8DIR ?= $(PREFIX)/share/man/man8
>> 
>> install: mkdir -p $(MAN3DIR) @@ -10,4 +11,3 @@ install: install
>> -m 644 man3/*.3 $(MAN3DIR) install -m 644 man5/*.5 $(MAN5DIR) 
>> install -m 644 man8/*.8 $(MAN8DIR) - ---
>> selinux/libsepol/man/Makefile	2011-09-09 20:12:56.021662468
>> +0200 +++ selinux-13092011-new-manual-pages/libsepol/man/Makefile
>> 2011-09-13 17:47:39.752630529 +0200 @@ -1,6 +1,7 @@ #
>> Installation directories. -MAN8DIR ?=
>> $(DESTDIR)/usr/share/man/man8 -MAN3DIR ?=
>> $(DESTDIR)/usr/share/man/man3 +PREFIX ?= $(DESTDIR)/usr +MAN3DIR
>> ?= $(PREFIX)/share/man/man3 +MAN8DIR ?= $(PREFIX)/share/man/man8
>> 
>> install: mkdir -p $(MAN3DIR) --- selinux/libsemanage/man/Makefile
>> 2011-09-09 20:12:56.003662337 +0200 +++
>> selinux-13092011-new-manual-pages/libsemanage/man/Makefile
>> 2011-09-13 17:46:49.324420640 +0200 @@ -1,7 +1,7 @@ #
>> Installation directories. -MAN3DIR ?=
>> $(DESTDIR)/usr/share/man/man3 +PREFIX ?= $(DESTDIR)/usr +MAN3DIR
>> ?= $(PREFIX)/share/man/man3
>> 
>> install: mkdir -p $(MAN3DIR) install -m 644 man3/*.3 $(MAN3DIR) 
>> -
>> 
>> Then introduce the new semanage.conf(5) manual page as
>> appropriate:
>> 
>> diff -pruN
>> selinux-13092011-new-manual-pages/libsemanage/man/Makefile
>> selinux-13092011-new-manual-pages-semanage.conf/libsemanage/man/Makefile
>>
>> 
- --- selinux-13092011-new-manual-pages/libsemanage/man/Makefile
2011-09-13 17:46:49.324420640 +0200
>> +++
>> selinux-13092011-new-manual-pages-semanage.conf/libsemanage/man/Makefile
>> 2011-09-13 17:52:46.605950570 +0200 @@ -1,7 +1,10 @@ #
>> Installation directories. PREFIX ?= $(DESTDIR)/usr MAN3DIR ?=
>> $(PREFIX)/share/man/man3 +MAN5DIR ?= $(PREFIX)/share/man/man5
>> 
>> install: mkdir -p $(MAN3DIR) +	mkdir -p $(MAN5DIR) install -m 644
>> man3/*.3 $(MAN3DIR) +	install -m 644 man5/*.5 $(MAN5DIR) diff
>> -pruN
>> selinux-13092011-new-manual-pages/libsemanage/man/man5/semanage.conf.5
>> selinux-13092011-new-manual-pages-semanage.conf/libsemanage/man/man5/semanage.conf.5
>>
>> 
- ---
selinux-13092011-new-manual-pages/libsemanage/man/man5/semanage.conf.5
1970-01-01 01:00:00.000000000 +0100
>> +++
>> selinux-13092011-new-manual-pages-semanage.conf/libsemanage/man/man5/semanage.conf.5
>> 2011-09-13 06:54:47.309754193 +0200 @@ -0,0 +1,93 @@ +.TH
>> semanage.conf "5" "September 2011" "semanage.conf" "Linux System
>> Administration" +.SH NAME +semanage.conf \- global configuration
>> file for the SELinux Management library +.SH DESCRIPTION +.PP 
>> +The +.BR semanage.conf +file is usually located under the
>> directory /etc/selinux and it is used for run-time configuration
>> of the +behavior of the SELinux Management library. + +.PP +Each
>> line should contain a configuration parameter followed by the
>> equal sign ("=") and then followed by the configuration value for
>> that +parameter. Anything after the "#" symbol is ignored
>> similarly to empty lines. + +.PP +The following parameters are
>> allowed: + +.RS +.TP +.B module-store +Specify how the SELinux
>> Management library should interact with the SELinux policy store.
>> When set to "direct", the SELinux +Management library writes to
>> the SELinux policy module store directly (this is the default
>> setting). +Otherwise a socket path or a server name can be used
>> for the argument. +If the argument begins with "/" (as in
>> "/foo/bar"), it represents the path to a named socket that should
>> be used to connect the policy management +server. +If the
>> argument does not begin with a "/" (as in "foo.com:4242"), it
>> should be interpreted as the name of a remote policy management
>> server +to be used through a TCP connection (default port is 4242
>> unless a different one is specified after the server name using
>> the colon to separate +the two fields). + +.TP +.B policy-version
>>  +When generating the policy, by default +.BR semanage +will set
>> the policy version to POLICYDB_VERSION_MAX, as defined in
>> <sepol/policydb/policydb.h>. Change this setting if a different 
>> +version needs to be set for the policy. + +.TP +.B expand-check 
>> +Whether or not to check "neverallow" rules when executing all 
>> +.BR semanage +command. It can be set to either "0" (disabled) or
>> "1" (enabled) and by default it is enabled. There might be a
>> large +penalty in execution time if this option is enabled. + 
>> +.TP +.B file-mode +By default the permission mode for the
>> run-time policy files is set to 0644. + +.TP +.B save-previous 
>> +It controls whether the previous module directory is saved after
>> a successful commit to the policy store and it can be set to 
>> +either "true" or "false". By default it is set to "false" (the
>> previous version is deleted). + +.TP +.B save-linked +It controls
>> whether the previously linked module is saved (with name
>> "base.linked") after a successful commit to the policy store. +It
>> can be set to either "true" or "false" and by default it is set
>> to "false" (the previous module is deleted). + +.TP +.B usepasswd
>>  +Whether or not to enable the use getpwent() to obtain a list of
>> home directories to label. It can be set to either "true" or
>> "false". +By default it is set to "true". + +.TP +.B
>> disable-genhomedircon +It controls whether or not the
>> genhomedircon function is executed when using the +.BR semanage 
>> +command and it can be set to either "false" or "true". By
>> default the genhomedircon functionality is enabled (equivalent 
>> +to this option set to "false"). + +.TP +.B handle-unknown +This
>> option controls the kernel behavior for handling permissions
>> defined in the kernel but missing from the actual policy. +It can
>> be set to "deny", "reject" or "allow". + +.TP +.B bzip-blocksize 
>> +It should be in the range 0-9. A value of 0 means no
>> compression. By default the bzip block size is set to 9 (actual
>> block +size value is obtained after multiplication by 100000). + 
>> +.TP +.B bzip-small +When set to "true", the bzip algorithm shall
>> try to reduce its system memory usage. It can be set to either
>> "true" or "false" and +by default it is set to "false". + +.SH
>> "SEE ALSO" +.TP +semanage(8) +.PP + +.SH AUTHOR +This manual page
>> was written by Guido Trentalancia <guido@trentalancia.com>. + 
>> +The SELinux management library was written by Tresys Technology
>> LLC and Red Hat Inc.
>> 
>> Regards,
>> 
>> Guido
>> 
>> On Tue, 2011-09-13 at 07:27 +0200, Guido Trentalancia wrote:
>>> With the bits to install it:
>>> 
>>> diff -pruN
>>> selinux-13092011-new/policycoreutils/semanage/Makefile
>>> selinux-13092011-new-manual-pages/policycoreutils/semanage/Makefile
>>>
>>> 
- --- selinux-13092011-new/policycoreutils/semanage/Makefile	2011-09-13
03:10:39.427692261 +0200
>>> +++
>>> selinux-13092011-new-manual-pages/policycoreutils/semanage/Makefile
>>> 2011-09-13 07:22:46.159015090 +0200 @@ -11,9 +11,11 @@
>>> TARGETS=semanage all: $(TARGETS)
>>> 
>>> install: all +	[ -d $(MANDIR)/man5 ] || mkdir -p
>>> $(MANDIR)/man5 [ -d $(MANDIR)/man8 ] || mkdir -p
>>> $(MANDIR)/man8 -mkdir -p $(SBINDIR) install -m 755 semanage
>>> $(SBINDIR) +	install -m 644 semanage.conf.5 $(MANDIR)/man5 
>>> install -m 644 semanage.8 $(MANDIR)/man8 test -d
>>> $(PYTHONLIBDIR)/site-packages || install -m 755 -d
>>> $(PYTHONLIBDIR)/site-packages install -m 755 seobject.py
>>> $(PYTHONLIBDIR)/site-packages
>>> 
>>> On Tue, 2011-09-13 at 07:00 +0200, Guido Trentalancia wrote:
>>>> So, here is a first new manual page that I propose to
>>>> introduce: semanage.conf(5).
>>>> 
>>>> On Mon, 2011-09-12 at 23:28 +0200, Guido Trentalancia wrote:
>>>>> On Thu, 2011-09-01 at 21:52 -0400, Eric Paris wrote:
>>>>>> On Thu, Sep 1, 2011 at 5:21 PM, Guido Trentalancia 
>>>>>> <guido@trentalancia.com> wrote:
>>>>>>> On Thu, 2011-09-01 at 09:42 -0400, Daniel J Walsh
>>>>>>> wrote:
>>>>>>>> On 09/01/2011 01:09 AM, Russell Coker wrote:
>>>>>>>>> Has anyone written manpages for genhomedircon,
>>>>>>>>> sepolgen-ifgen, and seunshare? If not is there
>>>>>>>>> someone with some spare time and man page writing
>>>>>>>>> skill?
>>>> 
>>>> [cut]
>>>> 
>>>>> I would like to take this opportunity to suggest that we
>>>>> create manual pages for configuration files where possible
>>>>> (none available at the moment ?!?).
>>>>> 
>>>>> For example, the very first one I would like to have is 
>>>>> semanage.conf.5.
>>>> 
>>>> diff -pruN selinux/policycoreutils/semanage/semanage.conf.5
>>>> selinux-13092011-new-manual-pages/policycoreutils/semanage/semanage.conf.5
>>>>
>>>> 
- --- selinux/policycoreutils/semanage/semanage.conf.5	1970-01-01
01:00:00.000000000 +0100
>>>> +++
>>>> selinux-13092011-new-manual-pages/policycoreutils/semanage/semanage.conf.5
>>>> 2011-09-13 06:54:47.309754193 +0200 @@ -0,0 +1,93 @@ +.TH
>>>> semanage.conf "5" "September 2011" "semanage.conf" "Linux
>>>> System Administration" +.SH NAME +semanage.conf \- global
>>>> configuration file for the SELinux Management library +.SH
>>>> DESCRIPTION +.PP +The +.BR semanage.conf +file is usually
>>>> located under the directory /etc/selinux and it is used for
>>>> run-time configuration of the +behavior of the SELinux
>>>> Management library. + +.PP +Each line should contain a
>>>> configuration parameter followed by the equal sign ("=") and
>>>> then followed by the configuration value for that +parameter.
>>>> Anything after the "#" symbol is ignored similarly to empty
>>>> lines. + +.PP +The following parameters are allowed: + +.RS 
>>>> +.TP +.B module-store +Specify how the SELinux Management
>>>> library should interact with the SELinux policy store. When
>>>> set to "direct", the SELinux +Management library writes to
>>>> the SELinux policy module store directly (this is the default
>>>> setting). +Otherwise a socket path or a server name can be
>>>> used for the argument. +If the argument begins with "/" (as
>>>> in "/foo/bar"), it represents the path to a named socket that
>>>> should be used to connect the policy management +server. +If
>>>> the argument does not begin with a "/" (as in
>>>> "foo.com:4242"), it should be interpreted as the name of a
>>>> remote policy management server +to be used through a TCP
>>>> connection (default port is 4242 unless a different one is
>>>> specified after the server name using the colon to separate 
>>>> +the two fields). + +.TP +.B policy-version +When generating
>>>> the policy, by default +.BR semanage +will set the policy
>>>> version to POLICYDB_VERSION_MAX, as defined in
>>>> <sepol/policydb/policydb.h>. Change this setting if a
>>>> different +version needs to be set for the policy. + +.TP +.B
>>>> expand-check +Whether or not to check "neverallow" rules when
>>>> executing all +.BR semanage +command. It can be set to either
>>>> "0" (disabled) or "1" (enabled) and by default it is enabled.
>>>> There might be a large +penalty in execution time if this
>>>> option is enabled. + +.TP +.B file-mode +By default the
>>>> permission mode for the run-time policy files is set to
>>>> 0644. + +.TP +.B save-previous +It controls whether the
>>>> previous module directory is saved after a successful commit
>>>> to the policy store and it can be set to +either "true" or
>>>> "false". By default it is set to "false" (the previous
>>>> version is deleted). + +.TP +.B save-linked +It controls
>>>> whether the previously linked module is saved (with name
>>>> "base.linked") after a successful commit to the policy
>>>> store. +It can be set to either "true" or "false" and by
>>>> default it is set to "false" (the previous module is
>>>> deleted). + +.TP +.B usepasswd +Whether or not to enable the
>>>> use getpwent() to obtain a list of home directories to label.
>>>> It can be set to either "true" or "false". +By default it is
>>>> set to "true". + +.TP +.B disable-genhomedircon +It controls
>>>> whether or not the genhomedircon function is executed when
>>>> using the +.BR semanage +command and it can be set to either
>>>> "false" or "true". By default the genhomedircon functionality
>>>> is enabled (equivalent +to this option set to "false"). + 
>>>> +.TP +.B handle-unknown +This option controls the kernel
>>>> behavior for handling permissions defined in the kernel but
>>>> missing from the actual policy. +It can be set to "deny",
>>>> "reject" or "allow". + +.TP +.B bzip-blocksize +It should be
>>>> in the range 0-9. A value of 0 means no compression. By
>>>> default the bzip block size is set to 9 (actual block +size
>>>> value is obtained after multiplication by 100000). + +.TP +.B
>>>> bzip-small +When set to "true", the bzip algorithm shall try
>>>> to reduce its system memory usage. It can be set to either
>>>> "true" or "false" and +by default it is set to "false". + 
>>>> +.SH "SEE ALSO" +.TP +semanage(8) +.PP + +.SH AUTHOR +This
>>>> manual page was written by Guido Trentalancia
>>>> <guido@trentalancia.com>. + +The SELinux management library
>>>> was written by Tresys Technology LLC and Red Hat Inc.
>>>> 
>>>> Very simple, but possibly useful...
>>>> 
>>>> Regards,
>>>> 
>>>> Guido
> 
> 
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 


I added this man page to the Fedora libsemanage package, which is
where I believe it belongs.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk53J9kACgkQrlYvE4MpobMTwwCePiS2iHKs5RXaN7Rdnd7CPVyi
tAUAoMZm6cyZ5J47AAMLoTl5hduyexlu
=OHxB
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
