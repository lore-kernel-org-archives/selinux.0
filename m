Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4BJQlHD023531
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 15:26:48 -0400
Received: from rv-out-0708.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4BJQlq7001044
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 19:26:47 GMT
Received: by rv-out-0708.google.com with SMTP id b17so2293697rvf.54
        for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 12:26:45 -0700 (PDT)
Subject: Re: [refpolicy] how to enable gconf(arole_dbus_t errors) and all
 of the gnome goodies
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <1242068307.27235.25.camel@gorn>
References: <1241804968.1819.9.camel@unix>
	 <1242046120.5102.11.camel@gorn.columbia.tresys.com>
	 <dd18b0c30905110751hbc3f36n741bad8e57eeb1be@mail.gmail.com>
	 <1242068307.27235.25.camel@gorn>
Content-Type: text/plain
Date: Mon, 11 May 2009 12:26:56 -0700
Message-Id: <1242070017.1991.7.camel@unix>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-05-11 at 14:58 -0400, Christopher J. PeBenito wrote:
> On Mon, 2009-05-11 at 07:51 -0700, Justin Mattock wrote:
> > On Mon, May 11, 2009 at 5:48 AM, Christopher J. PeBenito
> > <cpebenito@tresys.com> wrote:
> > > On Fri, 2009-05-08 at 10:49 -0700, Justin P. Mattock wrote:
> > >> with the latest policy:
> > >> I'm wondering what would be the best way to
> > >> allow gconf,evolution,nautilus,etc..
> > >>
> > >> If I start any of these during boot I'll
> > >> get system_dbus_t(which gets allowed)
> > >> but if I start evolution, nautilus, etc..
> > >> normally once Ive booted up I get an error
> > >> with checkpolicy.(due to arole_dbus_t instead of
> > >> system_dbus_t)
> > >>
> > >> Should I try and compile these programs
> > >> without orbit support(if possible), gconf support
> > >> and dbus support?
> > >>
> > >> is there a boolean that I'm missing?
> > >
> > > Can you provide the exact error messages?
> > >
> > If I start the system, and gather avc's
> > for(example) gnom-volume-control
> > (some of them below, then write them into the policy)
> > 
> > allow user_dbusd_t default_t:chr_file { read write getattr open ioctl };
> > allow user_dbusd_t gconf_etc_t:dir { search getattr };
> > allow user_dbusd_t gconf_home_t:dir { write search read remove_name
> > open getattr add_name };
> > allow user_dbusd_t gconf_home_t:file { rename setattr read create
> > write getattr unlink open append };
> > allow user_dbusd_t gconfd_exec_t:file { read execute open execute_no_trans };
> > allow user_dbusd_t mozilla_t:unix_stream_socket connectto;
> > allow user_dbusd_t self:process getsched;
> > 
> > the error is this:
> > 
> > m4 -D enable_mcs -D distro_redhat -D mls_num_sens=16 -D
> > mls_num_cats=256 -D mcs_num_cats=256 -D hide_broken_symptoms -D
> > self_contained_policy policy/support/file_patterns.spt
> > policy/support/ipc_patterns.spt policy/support/loadable_module.spt
> > policy/support/misc_macros.spt policy/support/misc_patterns.spt
> > policy/support/mls_mcs_macros.spt policy/support/obj_perm_sets.spt
> > tmp/generated_definitions.conf policy/global_booleans
> > policy/global_tunables > tmp/global_bools.conf
> > Creating mcs policy.conf
> > cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
> > tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf >
> > policy.conf
> > Compiling mcs policy.22
> > /usr/bin/checkpolicy -M -c 22 -U deny policy.conf -o policy.22
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > policy/modules/services/xserver.te":1042:ERROR 'type user_dbusd_t is
> > not within scope' at token ';' on line 2597865:
> > 
> > allow user_dbusd_t default_t:chr_file { read write getattr open ioctl };
> > checkpolicy:  error(s) encountered while parsing configuration
> > make: *** [policy.22] Error 1
> 
> user_dbusd_t is optionally declared, and the invocation is in
> policy/modules/roles/unprivuser.te line 37 (in current refpolicy trunk).
> You would have to put rules in that optional, otherwise the rule is out
> of scope.
> 

Cool, I'll have a look.
(sorry for bringing this up again, 
I've been going crazy with this for a while)

As for the policy, been running it for a while
(without any gnome support) but then decided to
add some sugar and spice to the system.

Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
