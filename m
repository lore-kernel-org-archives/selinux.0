Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4BEp9iB006117
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 10:51:09 -0400
Received: from yx-out-1718.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4BEpBgH025227
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 14:51:12 GMT
Received: by yx-out-1718.google.com with SMTP id 34so1657607yxf.84
        for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 07:51:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1242046120.5102.11.camel@gorn.columbia.tresys.com>
References: <1241804968.1819.9.camel@unix>
	 <1242046120.5102.11.camel@gorn.columbia.tresys.com>
Date: Mon, 11 May 2009 07:51:08 -0700
Message-ID: <dd18b0c30905110751hbc3f36n741bad8e57eeb1be@mail.gmail.com>
Subject: Re: [refpolicy] how to enable gconf(arole_dbus_t errors) and all of
	the gnome goodies
From: Justin Mattock <justinmattock@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 11, 2009 at 5:48 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Fri, 2009-05-08 at 10:49 -0700, Justin P. Mattock wrote:
>> with the latest policy:
>> I'm wondering what would be the best way to
>> allow gconf,evolution,nautilus,etc..
>>
>> If I start any of these during boot I'll
>> get system_dbus_t(which gets allowed)
>> but if I start evolution, nautilus, etc..
>> normally once Ive booted up I get an error
>> with checkpolicy.(due to arole_dbus_t instead of
>> system_dbus_t)
>>
>> Should I try and compile these programs
>> without orbit support(if possible), gconf support
>> and dbus support?
>>
>> is there a boolean that I'm missing?
>
> Can you provide the exact error messages?
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

If I start the system, and gather avc's
for(example) gnom-volume-control
(some of them below, then write them into the policy)

allow user_dbusd_t default_t:chr_file { read write getattr open ioctl };
allow user_dbusd_t gconf_etc_t:dir { search getattr };
allow user_dbusd_t gconf_home_t:dir { write search read remove_name
open getattr add_name };
allow user_dbusd_t gconf_home_t:file { rename setattr read create
write getattr unlink open append };
allow user_dbusd_t gconfd_exec_t:file { read execute open execute_no_trans };
allow user_dbusd_t mozilla_t:unix_stream_socket connectto;
allow user_dbusd_t self:process getsched;

the error is this:

m4 -D enable_mcs -D distro_redhat -D mls_num_sens=16 -D
mls_num_cats=256 -D mcs_num_cats=256 -D hide_broken_symptoms -D
self_contained_policy policy/support/file_patterns.spt
policy/support/ipc_patterns.spt policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/misc_patterns.spt
policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
tmp/generated_definitions.conf policy/global_booleans
policy/global_tunables > tmp/global_bools.conf
Creating mcs policy.conf
cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf >
policy.conf
Compiling mcs policy.22
/usr/bin/checkpolicy -M -c 22 -U deny policy.conf -o policy.22
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
policy/modules/services/xserver.te":1042:ERROR 'type user_dbusd_t is
not within scope' at token ';' on line 2597865:

allow user_dbusd_t default_t:chr_file { read write getattr open ioctl };
checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.22] Error 1

It's the whole dbus sends and receive info from the home directory then
create a directory in /tmp (orbit) transaction
that is happening.
I can try and start these programs during init,
(since system_dbusd_t seems to only be allowed)
but running evolution as root just seems a bit
too much, as well as any other app that just needs to be
ran normally.


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
