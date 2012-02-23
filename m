Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1NKIf3c008721
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 15:18:41 -0500
Received: by eeke51 with SMTP id e51so846175eek.12
        for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 12:18:39 -0800 (PST)
Date: Thu, 23 Feb 2012 21:17:35 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: libsemanage/libsepol still supported for non-MLS/MCS setups?
Message-ID: <20120223201735.GA5810@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi guys,

Is libsemanage (and libsepol) still supported on policies without MLS/MCS?
For some reason, I get segfaults when using libsemanage-2.1.6 on a "strict"
policy (one without levels).

The backtrace is as follows:

(gdb) run -B
Starting program: /usr/sbin/semodule -B

Program received signal SIGSEGV, Segmentation fault.
__strlen_sse2 () at ../sysdeps/x86_64/multiarch/../strlen.S:32
32      ../sysdeps/x86_64/multiarch/../strlen.S: No such file or directory.
        in ../sysdeps/x86_64/multiarch/../strlen.S
(gdb) bt
#0  __strlen_sse2 () at ../sysdeps/x86_64/multiarch/../strlen.S:32
#1  0x000003a1d08ddce1 in ustr_replace_cstr () from /usr/lib64/libustr-1.0.so.1
#2  0x000003a1d1524835 in replace_all (str=0x3a1d88e93c0 "HOME_DIR/.+\tsystem_u:object_r:user_home_t", repl=0x3ffffffde00)
    at genhomedircon.c:499
#3  0x000003a1d1524b58 in write_home_dir_context (s=0x3ffffffdf20, out=0x3a1d7444510, tpl=0x3a1d6e1f1b0, 
    user=0x3a1d71b2680 "user_u", seuser=0x3a1d71b2680 "user_u", home=0x3a1d71e08a3 "/home/[^/]*", 
    role_prefix=0x3a1d71bafc0 "user", level=0x0) at genhomedircon.c:566
#4  0x000003a1d1525d68 in write_context_file (s=0x3ffffffdf20, out=0x3a1d7444510) at genhomedircon.c:998
#5  0x000003a1d1526054 in semanage_genhomedircon (sh=0x3a1d1b6b280, policydb=0x3a1d6e01dd0, usepasswd=1, ignoredirs=0x0)
    at genhomedircon.c:1076
#6  0x000003a1d151e30c in semanage_direct_commit (sh=0x3a1d1b6b280) at direct_api.c:994
#7  0x000003a1d15234fe in semanage_commit (sh=0x3a1d1b6b280) at handle.c:435
#8  0x000003a1d1969318 in main (argc=<optimized out>, argv=0x3ffffffe278) at semodule.c:466

As you can see in frame #3, level is 0x0, which is confirmed when
traversing the &s variable in the write_context_file function:

(gdb) frame 4
#4  0x000003a1d1525d68 in write_context_file (s=0x3ffffffdf20, out=0x3a1d7444510) at genhomedircon.c:998
998     genhomedircon.c: No such file or directory.
        in genhomedircon.c
(gdb) print s.fallback_user_level
$1 = 0x0
(gdb) print s.fallback_user      
$2 = 0x3a1d71b2680 "user_u"
(gdb) print s.fallback_user_prefix
$3 = 0x3a1d71bafc0 "user"

Looking at how this can become 0x0, I think that 

1. write_context_file calls setup_fallback_user
2. setup_fallback_user calls semanage_user_query (for a default account?)
   this returns >= 0
3. setup_fallback_user calls semanage_user_get_mlslevel
4. semanage_user_get_mlslevel eventually calls sepol_user_get_mlslevel
5. sepol_user_get_mlslevel returns 0x0

Should sepol_user_get_mlslevel return some default (like "s0") if the
system doesn't use MLS/MCS? Or shouldn't it be called if one doesn't have
MCS/MLS?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
