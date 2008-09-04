Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m843Lrvg009380
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 23:21:53 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m843Lr4T009360
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 03:21:53 GMT
Received: by wr-out-0506.google.com with SMTP id c37so2677318wra.26
        for <selinux@tycho.nsa.gov>; Wed, 03 Sep 2008 20:21:53 -0700 (PDT)
Message-ID: <48BF5551.5080702@gmail.com>
Date: Wed, 03 Sep 2008 23:26:09 -0400
From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Manoj Srivastava <srivasta@debian.org>, Caleb Case <ccase@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][origin/autotools] fix libtool_compat header error
References: <48B6FD13.1000204@windriver.com> <48BF4023.7010007@manicmethod.com>
In-Reply-To: <48BF4023.7010007@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Vikram Ambrose wrote:
>   
>> More stuff:
>>
>> 1. Fixed error for libtool_compat.h in libsepol/libselinux
>> 2. Renamed pam modules with pamd suffix to prevent overwriting
>> corresponding binaries
>> 3. Added --enable-test option to libsepol (no Makefile.am yet)
>> 4. Added few more autogen.sh scripts
>> 5. Added .gitignore file to prevent accidental checkin of autoconf temp
>> files
>>
>> Note: My SELinux work from now onwards will be unofficial, and any
>> correspondence should be to my personal email address,
>> noel.ambrose@gmail.com, or you can always catch me on IRC.
>>
>>     
>
> (Back on list)
>
> Looks much better, some things: policycoreutils apparently knows how to find libsepol.a by itself but checkpolicy doesn't?
>
>   

The tests that policycoreutils and checkpolicy does for libsepol.a is 
very similar, except checkpolicy does a little more to make sure the 
library is finds is actually compatible.

eg. line 48 of checkpolicy/configure.ac
if ! nm "$with_static_libsepol/libsepol.a" 2>&1 | grep -q 
sepol_polcap_getnum ; then
   AC_MSG_ERROR([libsepol.a not compatible])
fi

That function "sepol_polcap_getnum" was added relatively recently, and I 
noticed that when doing development, by mistake I would build against a 
older system wide version of the library that didnt have this function, 
and the build would error out, so i added this test, to make sure that 
the libsepol.a found, was indeed compatible, if you are getting strange 
results, pastebin your config.log and i'll have a look at it.



> Also, I'm still getting this from libselinux when I build out the optional support:
> ./configure --disable-rpm --disable-avc --disable-bool --disable-swig --disable-docs
>
> gcc -shared  .libs/compute_member.o .libs/get_default_type.o .libs/lgetfilecon.o .libs/selinux_config.o .libs/compute_relabel.o .libs/getenforce.o .libs/load_policy.o .libs/compute_user.o .libs/getfilecon.o .libs/lsetfilecon.o .libs/setenforce.o .libs/context.o .libs/get_initial_context.o .libs/setfilecon.o .libs/disable.o .libs/getpeercon.o .libs/matchmediacon.o .libs/setrans_client.o .libs/callbacks.o .libs/enabled.o .libs/init.o .libs/matchpathcon.o .libs/seusers.o .libs/canonicalize_context.o .libs/fgetfilecon.o .libs/is_customizable_type.o .libs/policyvers.o .libs/freeconary.o .libs/label.o .libs/procattr.o .libs/check_context.o .libs/freecon.o .libs/label_file.o .libs/query_user_context.o .libs/compute_av.o .libs/fsetfilecon.o .libs/label_media.o .libs/compute_create.o .libs/get_context_list.o .libs/label_x.o .libs/selinux_check_securetty_context.o  -ldl  -Wl,--as-needed -Wl,-soname -Wl,libselinux.so.1 -o .libs/libselinux.so.1.0.0
> /usr/bin/ld: .libs/load_policy.o: relocation R_X86_64_PC32 against undefined symbol `security_get_boolean_names_internal' can not be used when making a shared object; recompile with -fPIC
> /usr/bin/ld: final link failed: Bad value
> collect2: ld returned 1 exit status
>
>   

I was missing a macro, fixed.

Will email patch later on, after some more testing.


Oh before i forget. It would be nice to add NEWS, README and AUTHORS 
files to each package folder, no mandatory, but would make life easier, 
as these files need to be generated before autoconf can be run, and it 
would be better to have meaningful content for these files then stubbing 
it out on the fly from the autogen.sh script. If there is no objection I 
will create a separate commit for these files.

Vikram




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
