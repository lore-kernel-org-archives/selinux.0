Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6FFVQ8r008219
	for <selinux@tycho.nsa.gov>; Sun, 15 Jul 2012 11:31:26 -0400
Received: by weyt57 with SMTP id t57so3684953wey.12
        for <selinux@tycho.nsa.gov>; Sun, 15 Jul 2012 08:31:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1342292366.87435.YahooMailClassic@web87702.mail.ir2.yahoo.com>
References: <1342292366.87435.YahooMailClassic@web87702.mail.ir2.yahoo.com>
Date: Sun, 15 Jul 2012 11:31:07 -0400
Message-ID: <CADQgGG2J9mvgVdm7oOdsAPoCWnhcc0Hh1ry7yEsawXZOZAb=2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Android build project: Fix 'mkyaffs2image -f ...'
 selabel_lookup error
From: Robert Craig <robertpcraig@gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=00504502d3ad893b4104c4e00052
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504502d3ad893b4104c4e00052
Content-Type: multipart/alternative; boundary=00504502d3ad893b3b04c4e00050

--00504502d3ad893b3b04c4e00050
Content-Type: text/plain; charset=ISO-8859-1

Thanks for bringing this to our attention. I think we should instead make a
change to the yaffs code. This will help with any other wrapper code.
Try the attached patch (worked for me).


On Sat, Jul 14, 2012 at 2:59 PM, Richard Haines <
richard_c_haines@btinternet.com> wrote:

> When building SE-Android, mkyaffs2image fails with an selabel_lookup error
> as the 'mountpoint' parameter does not match the file_context entry
> (requires a leading '/').
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  tools/releasetools/build_image.py |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/releasetools/build_image.py
> b/tools/releasetools/build_image.py
> index a615d1a..2b42d7d 100755
> --- a/tools/releasetools/build_image.py
> +++ b/tools/releasetools/build_image.py
> @@ -126,11 +126,11 @@ def main(argv):
>    image_filename = os.path.basename(out_file)
>    mount_point = ""
>    if image_filename == "system.img":
> -    mount_point = "system"
> +    mount_point = "/system"
>    elif image_filename == "userdata.img":
> -    mount_point = "data"
> +    mount_point = "/data"
>    elif image_filename == "cache.img":
> -    mount_point = "cache"
> +    mount_point = "/cache"
>    else:
>      print >> sys.stderr, "error: unknown image file name ", image_filename
>      exit(1)
> --
> 1.7.10.4
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--00504502d3ad893b3b04c4e00050
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for bringing this to our attention. I think we should instead make a=
 change to the yaffs code. This will help with any other wrapper code.=A0<d=
iv>Try the attached patch (worked for me).<div><br></div><div><br><div>On S=
at, Jul 14, 2012 at 2:59 PM, Richard Haines <span dir=3D"ltr">&lt;<a href=
=3D"mailto:richard_c_haines@btinternet.com" target=3D"_blank">richard_c_hai=
nes@btinternet.com</a>&gt;</span> wrote:</div>
<div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">When buildin=
g SE-Android, mkyaffs2image fails with an selabel_lookup error<br>
as the &#39;mountpoint&#39; parameter does not match the file_context entry=
<br>
(requires a leading &#39;/&#39;).<br>
<br>
Signed-off-by: Richard Haines &lt;<a href=3D"mailto:richard_c_haines@btinte=
rnet.com">richard_c_haines@btinternet.com</a>&gt;<br>
---<br>
=A0tools/releasetools/build_image.py | =A0 =A06 +++---<br>
=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/tools/releasetools/build_image.py b/tools/releasetools/build_i=
mage.py<br>
index a615d1a..2b42d7d 100755<br>
--- a/tools/releasetools/build_image.py<br>
+++ b/tools/releasetools/build_image.py<br>
@@ -126,11 +126,11 @@ def main(argv):<br>
=A0 =A0image_filename =3D os.path.basename(out_file)<br>
=A0 =A0mount_point =3D &quot;&quot;<br>
=A0 =A0if image_filename =3D=3D &quot;system.img&quot;:<br>
- =A0 =A0mount_point =3D &quot;system&quot;<br>
+ =A0 =A0mount_point =3D &quot;/system&quot;<br>
=A0 =A0elif image_filename =3D=3D &quot;userdata.img&quot;:<br>
- =A0 =A0mount_point =3D &quot;data&quot;<br>
+ =A0 =A0mount_point =3D &quot;/data&quot;<br>
=A0 =A0elif image_filename =3D=3D &quot;cache.img&quot;:<br>
- =A0 =A0mount_point =3D &quot;cache&quot;<br>
+ =A0 =A0mount_point =3D &quot;/cache&quot;<br>
=A0 =A0else:<br>
=A0 =A0 =A0print &gt;&gt; sys.stderr, &quot;error: unknown image file name =
&quot;, image_filename<br>
=A0 =A0 =A0exit(1)<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.10.4<br>
<br>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></span></blockquote></div><br></div></div></div>

--00504502d3ad893b3b04c4e00050--

--00504502d3ad893b4104c4e00052
Content-Type: application/octet-stream; name="yaffs.patch"
Content-Disposition: attachment; filename="yaffs.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h4oa4pmr0

ZGlmZiAtLWdpdCBhL3lhZmZzMi91dGlscy9ta3lhZmZzMmltYWdlLmMgYi95YWZmczIvdXRpbHMv
bWt5YWZmczJpbWFnZS5jCmluZGV4IDJiMTUyZTYuLmE5NTYyNTYgMTAwNjQ0Ci0tLSBhL3lhZmZz
Mi91dGlscy9ta3lhZmZzMmltYWdlLmMKKysrIGIveWFmZnMyL3V0aWxzL21reWFmZnMyaW1hZ2Uu
YwpAQCAtMzgyLDEyICszODIsMjUgQEAgc3RhdGljIGludCBwcm9jZXNzX2RpcmVjdG9yeShpbnQg
cGFyZW50LCBjb25zdCBjaGFyICpwYXRoLCBpbnQgZml4c3RhdHMpCiAJCQkJCQkJbW50cG9pbnQs
IHN1ZmZpeCk7CiAJCQkJCQlleGl0KDEpOwogCQkJCQl9CisKKwkJCQkJY2hhciAqc2VwYXRoID0g
TlVMTDsKKwkJCQkJaWYgKGRlc3RfbmFtZVswXSA9PSAnLycpCisJCQkJCSAgICAgICAgc2VwYXRo
ID0gc3RyZHVwKGRlc3RfbmFtZSk7CisJCQkJCWVsc2UKKwkJCQkJICAgICAgICBhc3ByaW50Zigm
c2VwYXRoLCAiLyVzIiwgZGVzdF9uYW1lKTsKKwkJCQkJaWYgKCFzZXBhdGgpIHsKKwkJCQkJICAg
ICAgICBwZXJyb3IoIm1hbGxvYyIpOworCQkJCQkgICAgICAgIGV4aXQoMSk7CisJCQkJCX0KKwog
CQkJCQlpZiAoc2VsYWJlbF9sb29rdXAoc2VobmQsICZzZWNvbnRleHQsCi0JCQkJCQkJICAgZGVz
dF9uYW1lLAorCQkJCQkJCSAgIHNlcGF0aCwKIAkJCQkJCQkgICBzdGF0cy5zdF9tb2RlKSA8IDAp
IHsKLQkJCQkJCXBlcnJvcigic2VsYWJlbF9sb29rdXAiKTsKLQkJCQkJCWV4aXQoMSk7CisJCQkJ
CSAgICAgICAgcGVycm9yKCJzZWxhYmVsX2xvb2t1cCIpOworCQkJCQkgICAgICAgIGZyZWUoc2Vw
YXRoKTsKKwkJCQkJICAgICAgICBleGl0KDEpOwogCQkJCQl9CisJCQkJCWZyZWUoc2VwYXRoKTsK
IAkJCQl9CiAjZW5kaWYKIApAQCAtNjM2LDEwICs2NDksMjQgQEAgaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKmFyZ3ZbXSkKIAkvL3ByaW50ZigiUHJvY2Vzc2luZyBkaXJlY3RvcnkgJXMgaW50byBp
bWFnZSBmaWxlICVzXG4iLGRpcixpbWFnZSk7CiAjaWZkZWYgSEFWRV9TRUxJTlVYCiAgICAgaWYg
KHNlaG5kKSB7Ci0JICAgIGlmIChzZWxhYmVsX2xvb2t1cChzZWhuZCwgJnNlY29udGV4dCwgbW50
cG9pbnQsIHN0YXRzLnN0X21vZGUpIDwgMCkgewotCQkgICAgcGVycm9yKCJzZWxhYmVsX2xvb2t1
cCIpOwotCQkgICAgZXhpdCgxKTsKLQkgICAgfQorCisgICAgICAgIGNoYXIgKnNlcGF0aCA9IE5V
TEw7CisgICAgICAgIGlmIChtbnRwb2ludFswXSA9PSAnLycpCisJICAgIHNlcGF0aCA9IHN0cmR1
cChtbnRwb2ludCk7CisgICAgICAgIGVsc2UKKwkgICAgYXNwcmludGYoJnNlcGF0aCwgIi8lcyIs
IG1udHBvaW50KTsKKyAgICAgICAgaWYgKCFzZXBhdGgpIHsKKwkgICAgcGVycm9yKCJtYWxsb2Mi
KTsKKwkgICAgZXhpdCgxKTsKKwl9CisKKwlpZiAoc2VsYWJlbF9sb29rdXAoc2VobmQsICZzZWNv
bnRleHQsIHNlcGF0aCwgc3RhdHMuc3RfbW9kZSkgPCAwKSB7CisJICAgIHBlcnJvcigic2VsYWJl
bF9sb29rdXAiKTsKKwkgICAgZnJlZShzZXBhdGgpOworCSAgICBleGl0KDEpOworCX0KKworCWZy
ZWUoc2VwYXRoKTsKICAgICB9CiAjZW5kaWYKIAo=
--00504502d3ad893b4104c4e00052--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
