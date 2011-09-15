Subject: Re: [PATCH v5] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Eric Paris <eparis@redhat.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Thu, 15 Sep 2011 13:15:28 -0400
In-Reply-To: <1316102675.2202.23.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost>  <1315951507.2218.91.camel@vortex>
	 <1316004965.26965.9.camel@moss-pluto>  <1316054641.23290.48.camel@vortex>
	 <1316091385.16483.13.camel@moss-pluto> <1316102675.2202.23.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316106929.14578.0.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 18:04 +0200, Guido Trentalancia wrote:

> ...
> make -C src install
> make[2]: Entering directory
> `/usr/src/selinux-userspace/git/selinux-test/libsemanage/src'
> cc -O3 -march=corei7 -mtune=corei7 -fPIC -I../include
> -I/opt/out/usr/include -D_GNU_SOURCE   -shared -o libsemanage.so.1
> utilities.lo user_extra_record.lo modules.lo boolean_record.lo
> ports_file.lo interfaces_file.lo interfaces_local.lo seuser_record.lo
> user_base_record.lo booleans_file.lo genhomedircon.lo fcontexts_file.lo
> booleans_local.lo database_llist.lo parse_utils.lo nodes_policydb.lo
> policy_components.lo users_extra_file.lo debug.lo fcontext_record.lo
> database_file.lo seusers_file.lo fcontexts_local.lo ports_local.lo
> direct_api.lo seusers_local.lo context_record.lo nodes_file.lo
> port_record.lo users_base_policydb.lo semanage_store.lo
> users_base_file.lo fcontexts_policy.lo booleans_activedb.lo
> users_policy.lo handle.lo booleans_policydb.lo nodes_local.lo
> interfaces_policy.lo database.lo users_local.lo ports_policy.lo
> booleans_active.lo nodes_policy.lo booleans_policy.lo users_join.lo
> user_record.lo seusers_policy.lo database_join.lo database_activedb.lo
> ports_policydb.lo interfaces_policydb.lo database_policydb.lo
> iface_record.lo node_record.lo conf-scan.lo conf-parse.lo -lsepol
> -lselinux -lbz2 -lustr -L/usr/lib64/
> -Wl,-soname,libsemanage.so.1,--version-script=libsemanage.map,-z,defs
> /usr/lib/gcc/x86_64-unknown-linux-gnu/4.6.1/../../../../x86_64-unknown-linux-gnu/bin/ld: /usr/lib64//libselinux.a(selinux_config.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
> /usr/lib64//libselinux.a: could not read symbols: Bad value
> collect2: ld returned 1 exit status
> make[2]: *** [libsemanage.so.1] Error 1
> make[2]: Leaving directory
> `/usr/src/selinux-userspace/git/selinux-test/libsemanage/src'
> make[1]: *** [install] Error 2
> make[1]: Leaving directory
> `/usr/src/selinux-userspace/git/selinux-test/libsemanage'
> make: *** [install] Error 1


My patch 1/2 from yesterday fixes this problem with the current upstream
master branch.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
