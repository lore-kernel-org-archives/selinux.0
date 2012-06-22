Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5MKhQDj028661
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2012 16:43:26 -0400
Received: by dadg9 with SMTP id g9so2760361dad.12
        for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2012 13:43:24 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 22 Jun 2012 13:43:23 -0700
Message-ID: <CAFftDdqF5WPAx3ESGbzFFaXvW8jb5Qxsk6oqz-f47UH3fqQkyA@mail.gmail.com>
Subject: [PATCH] hiding SELinux status on Settings app if HAVE_SELINUX:=false
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=047d7b10ce79f546fc04c315ae0f
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b10ce79f546fc04c315ae0f
Content-Type: multipart/alternative; boundary=047d7b10ce79f546fa04c315ae0d

--047d7b10ce79f546fa04c315ae0d
Content-Type: text/plain; charset=ISO-8859-1

This should hide the SELinux status in settings if you don't have
HAVE_SELINUX:=true during the build.

Please verify these patches before merging them. I only tested on Maguro.

Right now, you must do a CLEAN build to get these to work right. For some
reason props doesn't get updated right for me.

These for addressing the issues in Change-Id:
I69529fb7a3adfe31eccb16d79740fc4952ff5e68<https://android-review.googlesource.com/#/q/I69529fb7a3adfe31eccb16d79740fc4952ff5e68,n,z>
on
garret

-- 
Respectfully,

William C Roberts

--047d7b10ce79f546fa04c315ae0d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>This should hide the SELinux status in settings if you don&#39;t have =
HAVE_SELINUX:=3Dtrue during the build.</div><div><br></div><div>Please veri=
fy these patches before merging them. I only tested on Maguro.</div><div><b=
r>
</div><div>Right now, you must do a CLEAN build to get these to work right.=
 For some reason props doesn&#39;t get updated right for me.</div><div><br>=
</div><div>These for addressing the issues in=A0<span style=3D"background-c=
olor:rgb(255,255,255);font-family:&#39;Lucida Console&#39;,&#39;Lucida Sans=
 Typewriter&#39;,Monaco,monospace;font-size:8pt">Change-Id: </span><a href=
=3D"https://android-review.googlesource.com/#/q/I69529fb7a3adfe31eccb16d797=
40fc4952ff5e68,n,z" style=3D"font-family:&#39;Lucida Console&#39;,&#39;Luci=
da Sans Typewriter&#39;,Monaco,monospace;font-size:8pt;color:rgb(0,0,170)">=
I69529fb7a3adfe31eccb16d79740fc4952ff5e68</a>=A0on garret</div>
<div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>

--047d7b10ce79f546fa04c315ae0d--

--047d7b10ce79f546fc04c315ae0f
Content-Type: application/octet-stream;
	name="build_core_se_linux_property.patch"
Content-Disposition: attachment;
	filename="build_core_se_linux_property.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3rq6dao0

ZGlmZiAtLWdpdCBhL2NvcmUvbWFpbi5tayBiL2NvcmUvbWFpbi5tawppbmRleCAzZDhkNmUwLi5k
OWIyMDI3IDEwMDY0NAotLS0gYS9jb3JlL21haW4ubWsKKysrIGIvY29yZS9tYWluLm1rCkBAIC0y
MTgsNiArMjE4LDEwIEBAIGlmbmVxICgkKGZpbHRlciBzZGsgd2luX3NkayBzZGtfYWRkb24sJChN
QUtFQ01ER09BTFMpKSwpCiBpc19zZGtfYnVpbGQgOj0gdHJ1ZQogZW5kaWYKIAorIyMgaGF2ZSBz
ZWxpbnV4ICMjCitpZmVxICgkKEhBVkVfU0VMSU5VWCksdHJ1ZSkKK0FERElUSU9OQUxfQlVJTERf
UFJPUEVSVElFUyA6PSByby5oYXZlX3NlbGludXg9MQorZW5kaWYgIyBIQVZFX1NFTElOVVgKIAog
IyMgdXNlci91c2VyZGVidWcgIyMKIAo=
--047d7b10ce79f546fc04c315ae0f
Content-Type: application/octet-stream;
	name="packages_apps_Settings_selinux_status_hide.patch"
Content-Disposition: attachment;
	filename="packages_apps_Settings_selinux_status_hide.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3rq6daq1

ZGlmZiAtLWdpdCBhL3NyYy9jb20vYW5kcm9pZC9zZXR0aW5ncy9EZXZpY2VJbmZvU2V0dGluZ3Mu
amF2YSBiL3NyYy9jb20vYW5kcm9pZC9zZXR0aW5ncy9EZXZpY2VJbmZvU2V0dGluZ3MuamF2YQpp
bmRleCBjMjQxOGI2Li43NmMyYzI4IDEwMDY0NAotLS0gYS9zcmMvY29tL2FuZHJvaWQvc2V0dGlu
Z3MvRGV2aWNlSW5mb1NldHRpbmdzLmphdmEKKysrIGIvc3JjL2NvbS9hbmRyb2lkL3NldHRpbmdz
L0RldmljZUluZm9TZXR0aW5ncy5qYXZhCkBAIC01NSw2ICs1NSw3IEBAIHB1YmxpYyBjbGFzcyBE
ZXZpY2VJbmZvU2V0dGluZ3MgZXh0ZW5kcyBTZXR0aW5nc1ByZWZlcmVuY2VGcmFnbWVudCB7CiAg
ICAgcHJpdmF0ZSBzdGF0aWMgZmluYWwgU3RyaW5nIEtFWV9DT1BZUklHSFQgPSAiY29weXJpZ2h0
IjsKICAgICBwcml2YXRlIHN0YXRpYyBmaW5hbCBTdHJpbmcgS0VZX1NZU1RFTV9VUERBVEVfU0VU
VElOR1MgPSAic3lzdGVtX3VwZGF0ZV9zZXR0aW5ncyI7CiAgICAgcHJpdmF0ZSBzdGF0aWMgZmlu
YWwgU3RyaW5nIFBST1BFUlRZX1VSTF9TQUZFVFlMRUdBTCA9ICJyby51cmwuc2FmZXR5bGVnYWwi
OworICAgIHByaXZhdGUgc3RhdGljIGZpbmFsIFN0cmluZyBQUk9QRVJUWV9TRUxJTlVYX1NUQVRV
UyA9ICJyby5oYXZlX3NlbGludXgiOwogICAgIHByaXZhdGUgc3RhdGljIGZpbmFsIFN0cmluZyBL
RVlfS0VSTkVMX1ZFUlNJT04gPSAia2VybmVsX3ZlcnNpb24iOwogICAgIHByaXZhdGUgc3RhdGlj
IGZpbmFsIFN0cmluZyBLRVlfQlVJTERfTlVNQkVSID0gImJ1aWxkX251bWJlciI7CiAgICAgcHJp
dmF0ZSBzdGF0aWMgZmluYWwgU3RyaW5nIEtFWV9ERVZJQ0VfTU9ERUwgPSAiZGV2aWNlX21vZGVs
IjsKQEAgLTg1LDYgKzg2LDkgQEAgcHVibGljIGNsYXNzIERldmljZUluZm9TZXR0aW5ncyBleHRl
bmRzIFNldHRpbmdzUHJlZmVyZW5jZUZyYWdtZW50IHsKICAgICAgICAgICAgIHNldFN0cmluZ1N1
bW1hcnkoS0VZX1NFTElOVVhfU1RBVFVTLCAiZW5mb3JjaW5nIik7CiAgICAgICAgIH0KIAorCS8v
IFJlbW92ZSBzZWxpbnV4IGluZm9ybWF0aW9uIGlmIHByb3BlcnR5IGlzIG5vdCBwcmVzZW50CisJ
cmVtb3ZlUHJlZmVyZW5jZUlmUHJvcGVydHlNaXNzaW5nKGdldFByZWZlcmVuY2VTY3JlZW4oKSwg
InNlbGludXhfc3RhdHVzIiwgUFJPUEVSVFlfU0VMSU5VWF9TVEFUVVMpOworCiAgICAgICAgIC8v
IFJlbW92ZSBTYWZldHkgaW5mb3JtYXRpb24gcHJlZmVyZW5jZSBpZiBQUk9QRVJUWV9VUkxfU0FG
RVRZTEVHQUwgaXMgbm90IHNldAogICAgICAgICByZW1vdmVQcmVmZXJlbmNlSWZQcm9wZXJ0eU1p
c3NpbmcoZ2V0UHJlZmVyZW5jZVNjcmVlbigpLCAic2FmZXR5bGVnYWwiLAogICAgICAgICAgICAg
ICAgIFBST1BFUlRZX1VSTF9TQUZFVFlMRUdBTCk7Cg==
--047d7b10ce79f546fc04c315ae0f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
