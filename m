Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1NKglsi010315
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 15:42:47 -0500
Received: by vbbfc21 with SMTP id fc21so1300943vbb.12
        for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 12:42:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120223201735.GA5810@siphos.be>
References: <20120223201735.GA5810@siphos.be>
Date: Thu, 23 Feb 2012 15:42:45 -0500
Message-ID: <CACLa4ptWFe_uEeUQgd2TYmL-W6YMb8msAtSxc-csrKwhUffD1g@mail.gmail.com>
Subject: Re: libsemanage/libsepol still supported for non-MLS/MCS setups?
From: Eric Paris <eparis@parisplace.org>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=f46d043c7ba4bbee9704b9a7afa2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d043c7ba4bbee9704b9a7afa2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I got a patch a week ago about this and haven't look at/applied yet.
Would you like to test?

-Eric

On Thu, Feb 23, 2012 at 3:17 PM, Sven Vermeulen
<sven.vermeulen@siphos.be> wrote:
> Hi guys,
>
> Is libsemanage (and libsepol) still supported on policies without MLS/MCS=
?
> For some reason, I get segfaults when using libsemanage-2.1.6 on a "stric=
t"
> policy (one without levels).
>
> The backtrace is as follows:
>
> (gdb) run -B
> Starting program: /usr/sbin/semodule -B
>
> Program received signal SIGSEGV, Segmentation fault.
> __strlen_sse2 () at ../sysdeps/x86_64/multiarch/../strlen.S:32
> 32 =A0 =A0 =A0../sysdeps/x86_64/multiarch/../strlen.S: No such file or di=
rectory.
> =A0 =A0 =A0 =A0in ../sysdeps/x86_64/multiarch/../strlen.S
> (gdb) bt
> #0 =A0__strlen_sse2 () at ../sysdeps/x86_64/multiarch/../strlen.S:32
> #1 =A00x000003a1d08ddce1 in ustr_replace_cstr () from /usr/lib64/libustr-=
1.0.so.1
> #2 =A00x000003a1d1524835 in replace_all (str=3D0x3a1d88e93c0 "HOME_DIR/.+=
\tsystem_u:object_r:user_home_t", repl=3D0x3ffffffde00)
> =A0 =A0at genhomedircon.c:499
> #3 =A00x000003a1d1524b58 in write_home_dir_context (s=3D0x3ffffffdf20, ou=
t=3D0x3a1d7444510, tpl=3D0x3a1d6e1f1b0,
> =A0 =A0user=3D0x3a1d71b2680 "user_u", seuser=3D0x3a1d71b2680 "user_u", ho=
me=3D0x3a1d71e08a3 "/home/[^/]*",
> =A0 =A0role_prefix=3D0x3a1d71bafc0 "user", level=3D0x0) at genhomedircon.=
c:566
> #4 =A00x000003a1d1525d68 in write_context_file (s=3D0x3ffffffdf20, out=3D=
0x3a1d7444510) at genhomedircon.c:998
> #5 =A00x000003a1d1526054 in semanage_genhomedircon (sh=3D0x3a1d1b6b280, p=
olicydb=3D0x3a1d6e01dd0, usepasswd=3D1, ignoredirs=3D0x0)
> =A0 =A0at genhomedircon.c:1076
> #6 =A00x000003a1d151e30c in semanage_direct_commit (sh=3D0x3a1d1b6b280) a=
t direct_api.c:994
> #7 =A00x000003a1d15234fe in semanage_commit (sh=3D0x3a1d1b6b280) at handl=
e.c:435
> #8 =A00x000003a1d1969318 in main (argc=3D<optimized out>, argv=3D0x3fffff=
fe278) at semodule.c:466
>
> As you can see in frame #3, level is 0x0, which is confirmed when
> traversing the &s variable in the write_context_file function:
>
> (gdb) frame 4
> #4 =A00x000003a1d1525d68 in write_context_file (s=3D0x3ffffffdf20, out=3D=
0x3a1d7444510) at genhomedircon.c:998
> 998 =A0 =A0 genhomedircon.c: No such file or directory.
> =A0 =A0 =A0 =A0in genhomedircon.c
> (gdb) print s.fallback_user_level
> $1 =3D 0x0
> (gdb) print s.fallback_user
> $2 =3D 0x3a1d71b2680 "user_u"
> (gdb) print s.fallback_user_prefix
> $3 =3D 0x3a1d71bafc0 "user"
>
> Looking at how this can become 0x0, I think that
>
> 1. write_context_file calls setup_fallback_user
> 2. setup_fallback_user calls semanage_user_query (for a default account?)
> =A0 this returns >=3D 0
> 3. setup_fallback_user calls semanage_user_get_mlslevel
> 4. semanage_user_get_mlslevel eventually calls sepol_user_get_mlslevel
> 5. sepol_user_get_mlslevel returns 0x0
>
> Should sepol_user_get_mlslevel return some default (like "s0") if the
> system doesn't use MLS/MCS? Or shouldn't it be called if one doesn't have
> MCS/MLS?
>
> Wkr,
> =A0 =A0 =A0 =A0Sven Vermeulen
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--f46d043c7ba4bbee9704b9a7afa2
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-libsemanage-Fix-segfault-for-building-standard-polic.patch"
Content-Disposition: attachment;
	filename="0001-libsemanage-Fix-segfault-for-building-standard-polic.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gz09dm4w0

PkZyb20gNjRhZmYyYzgwZjI4MjgwNzI0ZjY0NjI4ZDZiZjRjNDcyMmI0Zjc1ZiBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogWGluIE91eWFuZyA8eGlucGFzY2FsQGdtYWlsLmNvbT4KRGF0
ZTogVGh1LCAxMiBKYW4gMjAxMiAxNjo1ODozNCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGxpYnNl
bWFuYWdlOiBGaXggc2VnZmF1bHQgZm9yIGJ1aWxkaW5nIHN0YW5kYXJkIHBvbGljaWVzLgoKSWYg
eW91IGFyZSBidWlsZGluZyAic3RhbmRhcmQiIHBvbGljaWVzKG5vdCBNQ1MvTUxTKSwgbGlic2Vt
YW5hZ2UKd2lsbCBjcmFzaCwgd2hpY2ggY2F1c2VkIGJ5IHN0cmR1cCgpIHRvICJsZXZlbCIgTlVM
TCBwb2ludGVycy4KRm9yIGV4YW1wbGUsIHNlbW9kdWxlIC1zIHJlZnBvbGljeSAtYiBiYXNlLnBw
IC1pIGEucHAKLS0tCiBsaWJzZW1hbmFnZS9zcmMvZ2VuaG9tZWRpcmNvbi5jIHwgICAgNCArKysr
CiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9saWJzZW1hbmFnZS9zcmMvZ2VuaG9tZWRpcmNvbi5jIGIvbGlic2VtYW5hZ2Uvc3Jj
L2dlbmhvbWVkaXJjb24uYwppbmRleCBkMjY0NmFlLi4yNjJhNmNkIDEwMDY0NAotLS0gYS9saWJz
ZW1hbmFnZS9zcmMvZ2VuaG9tZWRpcmNvbi5jCisrKyBiL2xpYnNlbWFuYWdlL3NyYy9nZW5ob21l
ZGlyY29uLmMKQEAgLTc3OCw2ICs3NzgsOCBAQCBzdGF0aWMgaW50IHNldHVwX2ZhbGxiYWNrX3Vz
ZXIoZ2VuaG9tZWRpcmNvbl9zZXR0aW5nc190ICogcykKIAkJCXsKIAkJCQlwcmVmaXggPSBzZW1h
bmFnZV91c2VyX2dldF9wcmVmaXgodSk7CiAJCQkJbGV2ZWwgPSBzZW1hbmFnZV91c2VyX2dldF9t
bHNsZXZlbCh1KTsKKwkJCQlpZiAobGV2ZWwgPT0gTlVMTCkKKwkJCQkJbGV2ZWwgPSAiIjsKIAkJ
CX0KIAogCQkJaWYgKHNldF9mYWxsYmFja191c2VyKHMsIHNldW5hbWUsIHByZWZpeCwgbGV2ZWwp
ICE9IDApCkBAIC04NjEsNiArODYzLDggQEAgc3RhdGljIGdlbmhvbWVkaXJjb25fdXNlcl9lbnRy
eV90ICpnZXRfdXNlcnMoZ2VuaG9tZWRpcmNvbl9zZXR0aW5nc190ICogcywKIAkJaWYgKHUpIHsK
IAkJCXByZWZpeCA9IHNlbWFuYWdlX3VzZXJfZ2V0X3ByZWZpeCgqdSk7CiAJCQlsZXZlbCA9IHNl
bWFuYWdlX3VzZXJfZ2V0X21sc2xldmVsKCp1KTsKKwkJCWlmIChsZXZlbCA9PSBOVUxMKQorCQkJ
CWxldmVsID0gIiI7CiAJCX0gZWxzZSB7CiAJCQlwcmVmaXggPSBuYW1lOwogCQkJbGV2ZWwgPSAi
czAiOwotLSAKMS43LjcuMwoK
--f46d043c7ba4bbee9704b9a7afa2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
