Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JFFIgA014954
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 11:15:18 -0400 (EDT)
Received: from rproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4JFBADf027539
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 15:11:10 GMT
Received: by rproxy.gmail.com with SMTP id c16so336275rne
        for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 08:11:26 -0700 (PDT)
Message-ID: <46ce702f050519081136af356@mail.gmail.com>
Date: Thu, 19 May 2005 10:11:24 -0500
From: Serge Hallyn <serge.hallyn@gmail.com>
Reply-To: Serge Hallyn <serge.hallyn@gmail.com>
To: selinux@tycho.nsa.gov
Subject: targeted policy patch
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_666_1333898.1116515484668"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_666_1333898.1116515484668
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

In order to compile the sf.net targeted policy on a gentoo system with
the sf.net checkpolicy, I needed the following patch.  It does several
small things, the last of which I expect is actually wrong, but at
least gets me a compiling policy:

1. preserves kernel.te to get its type declaration.
2. fixes what i assume is a type, 'rm -rf domains/misc/used' instead of unu=
sed
3. deletes setfiles.fc, since setfiles_exec_t is not declared in the policy
4. adds the unrestricted attribute to the insmod_t domain.  This stops
a conflict with the neverallow rule for ~signal -> unconfined_t.

thanks,
-serge

------=_Part_666_1333898.1116515484668
Content-Type: application/octet-stream; name="targeted_nits.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="targeted_nits.patch"

SW5kZXg6IHBvbGljeS9zZWxpbnV4LXBvbGljeS10YXJnZXRlZC5zcGVjCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IHBvbGljeS5vcmlnL3NlbGludXgtcG9saWN5LXRhcmdldGVkLnNwZWMJMjAwNS0wNS0xOSAwOTo1
NjowMy4wMDAwMDAwMDAgLTA1MDAKKysrIHBvbGljeS9zZWxpbnV4LXBvbGljeS10YXJnZXRlZC5z
cGVjCTIwMDUtMDUtMTkgMDk6NTc6MjguMDAwMDAwMDAwIC0wNTAwCkBAIC00OCw4ICs0OCwxMCBA
QAogZm9yIGkgaW4gYW1hbmRhLnRlIGFwYWNoZS50ZSBjaGtwd2QudGUgY3Vwcy50ZSBkaGNwZC50
ZSBkaWN0ZC50ZSBkb3ZlY290LnRlIGZpbmdlcmQudGUgZnRwZC50ZSBob3dsLnRlIGkxOG5faW5w
dXQudGUgaW5pdC50ZSBpbml0cmMudGUgaW5ldGQudGUgaW5uZC50ZSBrZXJiZXJvcy50ZSBrdGFs
a2QudGUgbGRjb25maWcudGUgbG9naW4udGUgbHBkLnRlIG1haWxtYW4udGUgbW9kdXRpbC50ZSBt
dGEudGUgbXlzcWxkLnRlIG5hbWVkLnRlIG5zY2QudGUgbnRwZC50ZSBwb3J0bWFwLnRlIHBvc3Rn
cmVzcWwudGUgcHJpdm94eS50ZSByYWRpdXMudGUgcmFkdmQudGUgcmxvZ2luZC50ZSBycGNkLnRl
IHJzaGQudGUgcnN5bmMudGUgc2FtYmEudGUgc2xhcGQudGUgc25tcGQudGUgc3BhbWQudGUgc3F1
aWQudGUgc3R1bm5lbC50ZSBzeXNsb2dkLnRlIHRlbG5ldGQudGUgdGZ0cGQudGUgd2luYmluZC50
ZSB5cGJpbmQudGUgeXBzZXJ2LnRlIHplYnJhLnRlOyBkbwogbXYgZG9tYWlucy9wcm9ncmFtL3Vu
dXNlZC8kaSBkb21haW5zL3Byb2dyYW0vIAogZG9uZSAKK2NwIGRvbWFpbnMvbWlzYy91bnVzZWQv
a2VybmVsLnRlIGRvbWFpbnMvbWlzYwogcm0gLXJmIGRvbWFpbnMvcHJvZ3JhbS91bnVzZWQgCi1y
bSAtcmYgZG9tYWlucy9taXNjL3VzZWQgCitybSAtcmYgZG9tYWlucy9taXNjL3VudXNlZCAKK3Jt
IGZpbGVfY29udGV4dHMvcHJvZ3JhbS9zZXRmaWxlcy5mYwogY3AgLVIgJXt0eXBlfS8qIC4KIGVj
aG8gImRlZmluZShcYHRhcmdldGVkX3BvbGljeScpIiAgPiB0dW5hYmxlcy90dW5hYmxlLnR1bgog
ZWNobyAiZGVmaW5lKFxgaGlkZV9icm9rZW5fc3ltcHRvbXMnKSIgID4+IHR1bmFibGVzL3R1bmFi
bGUudHVuCkluZGV4OiBwb2xpY3kvZG9tYWlucy9wcm9ncmFtL21vZHV0aWwudGUKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gcG9saWN5Lm9yaWcvZG9tYWlucy9wcm9ncmFtL21vZHV0aWwudGUJMjAwNS0wNS0xOSAw
OTo1NjowMy4wMDAwMDAwMDAgLTA1MDAKKysrIHBvbGljeS9kb21haW5zL3Byb2dyYW0vbW9kdXRp
bC50ZQkyMDA1LTA1LTE5IDA5OjU4OjE3LjAwMDAwMDAwMCAtMDUwMApAQCAtNzAsNyArNzAsNyBA
QAogIyBSdWxlcyBmb3IgdGhlIGluc21vZF90IGRvbWFpbi4KICMKIAotdHlwZSBpbnNtb2RfdCwg
ZG9tYWluLCBwcml2bG9nLCBzeXNjdGxfa2VybmVsX3dyaXRlciwgcHJpdm1lbSwgcHJpdnN5c21v
ZCBpZmRlZihgdW5saW1pdGVkVXRpbHMnLCBgLCBhZG1pbiwgZXRjX3dyaXRlciwgZnNfZG9tYWlu
LCBhdXRoX3dyaXRlLCBwcml2b3duZXIsIHByaXZtb2R1bGUnICkKK3R5cGUgaW5zbW9kX3QsIGRv
bWFpbiwgdW5yZXN0cmljdGVkLCBwcml2bG9nLCBzeXNjdGxfa2VybmVsX3dyaXRlciwgcHJpdm1l
bSwgcHJpdnN5c21vZCBpZmRlZihgdW5saW1pdGVkVXRpbHMnLCBgLCBhZG1pbiwgZXRjX3dyaXRl
ciwgZnNfZG9tYWluLCBhdXRoX3dyaXRlLCBwcml2b3duZXIsIHByaXZtb2R1bGUnICkKIDsKIHJv
bGUgc3lzdGVtX3IgdHlwZXMgaW5zbW9kX3Q7CiByb2xlIHN5c2FkbV9yIHR5cGVzIGluc21vZF90
Owo=
------=_Part_666_1333898.1116515484668--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
