Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5N0VYGq005614
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2012 20:31:34 -0400
Received: by pbbrr13 with SMTP id rr13so4184125pbb.12
        for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2012 17:31:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdqF5WPAx3ESGbzFFaXvW8jb5Qxsk6oqz-f47UH3fqQkyA@mail.gmail.com>
References: <CAFftDdqF5WPAx3ESGbzFFaXvW8jb5Qxsk6oqz-f47UH3fqQkyA@mail.gmail.com>
Date: Fri, 22 Jun 2012 17:31:32 -0700
Message-ID: <CAFftDdo1Hfb8zVmQK6KNv5w=O5abcZrrVtJi7yFU_FW8mEZMmA@mail.gmail.com>
Subject: Re: [PATCH] hiding SELinux status on Settings app if HAVE_SELINUX:=false
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=e89a8ff244cfe9a95304c318def7
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff244cfe9a95304c318def7
Content-Type: multipart/alternative; boundary=e89a8ff244cfe9a95004c318def5

--e89a8ff244cfe9a95004c318def5
Content-Type: text/plain; charset=ISO-8859-1

These patches had an issue with the system ui dying. I thought it was a
problem on master but it was my problem.

I was accidentally resetting ADDITIONAL_BUILD_PROPERTIES instead of
appending to it, these patches correct that.


On Fri, Jun 22, 2012 at 1:43 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> This should hide the SELinux status in settings if you don't have
> HAVE_SELINUX:=true during the build.
>
> Please verify these patches before merging them. I only tested on Maguro.
>
> Right now, you must do a CLEAN build to get these to work right. For some
> reason props doesn't get updated right for me.
>
> These for addressing the issues in Change-Id:
> I69529fb7a3adfe31eccb16d79740fc4952ff5e68<https://android-review.googlesource.com/#/q/I69529fb7a3adfe31eccb16d79740fc4952ff5e68,n,z> on
> garret
>
> --
> Respectfully,
>
> William C Roberts
>
>
>


-- 
Respectfully,

William C Roberts

--e89a8ff244cfe9a95004c318def5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

These patches had an issue with the system ui dying. I thought it was a pro=
blem on master but it was my problem.<div><br></div><div>I was accidentally=
 resetting ADDITIONAL_BUILD_PROPERTIES instead of appending to it, these pa=
tches correct that.</div>

<div><br><br><div class=3D"gmail_quote">On Fri, Jun 22, 2012 at 1:43 PM, Wi=
lliam Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.=
com" target=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">

<div>This should hide the SELinux status in settings if you don&#39;t have =
HAVE_SELINUX:=3Dtrue during the build.</div><div><br></div><div>Please veri=
fy these patches before merging them. I only tested on Maguro.</div><div>

<br>
</div><div>Right now, you must do a CLEAN build to get these to work right.=
 For some reason props doesn&#39;t get updated right for me.</div><div><br>=
</div><div>These for addressing the issues in=A0<span style=3D"font-size:8p=
t;font-family:&#39;Lucida Console&#39;,&#39;Lucida Sans Typewriter&#39;,Mon=
aco,monospace">Change-Id: </span><a href=3D"https://android-review.googleso=
urce.com/#/q/I69529fb7a3adfe31eccb16d79740fc4952ff5e68,n,z" style=3D"font-f=
amily:&#39;Lucida Console&#39;,&#39;Lucida Sans Typewriter&#39;,Monaco,mono=
space;font-size:8pt;color:rgb(0,0,170)" target=3D"_blank">I69529fb7a3adfe31=
eccb16d79740fc4952ff5e68</a>=A0on garret</div>

<span><font color=3D"#888888">
<div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--e89a8ff244cfe9a95004c318def5--

--e89a8ff244cfe9a95304c318def7
Content-Type: application/octet-stream;
	name="build_core_se_linux_property.patch"
Content-Disposition: attachment;
	filename="build_core_se_linux_property.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3rx16se2

ZGlmZiAtLWdpdCBhL2NvcmUvbWFpbi5tayBiL2NvcmUvbWFpbi5tawppbmRleCAzZDhkNmUwLi45
MTNjZmJkIDEwMDY0NAotLS0gYS9jb3JlL21haW4ubWsKKysrIGIvY29yZS9tYWluLm1rCkBAIC0y
MTgsNiArMjE4LDEwIEBAIGlmbmVxICgkKGZpbHRlciBzZGsgd2luX3NkayBzZGtfYWRkb24sJChN
QUtFQ01ER09BTFMpKSwpCiBpc19zZGtfYnVpbGQgOj0gdHJ1ZQogZW5kaWYKIAorIyMgaGF2ZSBz
ZWxpbnV4ICMjCitpZmVxICgkKEhBVkVfU0VMSU5VWCksdHJ1ZSkKK0FERElUSU9OQUxfQlVJTERf
UFJPUEVSVElFUyArPSByby5oYXZlX3NlbGludXg9MQorZW5kaWYgIyBIQVZFX1NFTElOVVgKIAog
IyMgdXNlci91c2VyZGVidWcgIyMKIAo=
--e89a8ff244cfe9a95304c318def7
Content-Type: application/octet-stream;
	name="packages_apps_Settings_selinux_status_hide.patch"
Content-Disposition: attachment;
	filename="packages_apps_Settings_selinux_status_hide.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3rx16sf3

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
--e89a8ff244cfe9a95304c318def7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
