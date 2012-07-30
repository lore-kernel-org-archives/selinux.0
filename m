Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6UFa0oY030589
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2012 11:36:00 -0400
Received: from [192.168.1.114] (79.sub-70-192-192.myvzw.com [70.192.192.79])
	by mail.metronome-software.com (Postfix) with ESMTP id 7EB92320168
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2012 08:35:55 -0700 (PDT)
Date: Mon, 30 Jul 2012 11:35:52 -0400
Subject: SEAndroid 4.0.4 make error since the code move
From: "Gia T. Nguyen" <gia.nguyen@metronome-software.com>
To: <selinux@tycho.nsa.gov>
Message-ID: <CC3C2203.6A7B%gia.nguyen@metronome-software.com>
In-Reply-To: <CC3C1F53.6A7B%gia.nguyen@metronome-software.com>
Mime-version: 1.0
Content-type: multipart/alternative;
	boundary="B_3426492958_580499"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3426492958_580499
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit


Hi everyone,

I needed to go back and pull the 4.0.4 source, so I followed these
instructions from the website:

git clone -b seandroid-4.0.4 https://bitbucket.org/seandroid/manifests.git
mkdir seandroid-4.0.4
cd seandroid-4.0.4
repo init -u https://android.googlesource.com/platform/manifest -b
android-4.0.4_r2.1
cp ../manifests/local_manifest.xml .repo/
repo sync

However, now I'm getting these make errors when I'm building:

<command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined [enabled by
default]
<command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>:0:0: note: this is the location of the previous definition
cc1plus: all warnings being treated as errors
make: *** [out/host/linux-x86/obj/EXECUTABLES/obbtool_intermediates/Main.o]
Error 1

Has anyone else seen this since the move of the code to git?

Regards,
Gia Nguyen





--B_3426492958_580499
Content-type: text/html;
	charset="US-ASCII"
Content-transfer-encoding: quoted-printable

<html><head></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space; color: rgb(0, 0, 0); font-size:=
 14px; font-family: Calibri, sans-serif; "><div><div><div><br></div></div></=
div><span id=3D"OLK_SRC_BODY_SECTION"><div><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; color: rgb(=
0, 0, 0); font-size: 14px; font-family: Calibri, sans-serif; "><div><div><di=
v><div>Hi everyone,</div><div><br></div><div>I needed to go back and pull th=
e 4.0.4 source, so I followed these instructions from the website:</div><div=
><br></div><div>git clone -b seandroid-4.0.4 <a href=3D"https://bitbucket.org/=
seandroid/manifests.git">https://bitbucket.org/seandroid/manifests.git</a></=
div><div>mkdir seandroid-4.0.4</div><div>cd seandroid-4.0.4</div><div>repo i=
nit -u <a href=3D"https://android.googlesource.com/platform/manifest">https://=
android.googlesource.com/platform/manifest</a> -b android-4.0.4_r2.1</div><d=
iv>cp ../manifests/local_manifest.xml .repo/</div><div>repo sync</div></div>=
<div><br></div><div>However, now I'm getting these make errors when I'm buil=
ding:</div><div><br></div><div><div style=3D"font-family: Calibri; font-size: =
medium; ">&lt;command-line&gt;:0:0: warning: "_FORTIFY_SOURCE" redefined [en=
abled by default]</div><div style=3D"font-family: Calibri; font-size: medium; =
">&lt;command-line&gt;:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]</di=
v><div style=3D"font-family: Calibri; font-size: medium; ">&lt;built-in&gt;:0:=
0: note: this is the location of the previous definition</div><div style=3D"fo=
nt-family: Calibri; font-size: medium; ">cc1plus: all warnings being treated=
 as errors</div><div style=3D"font-family: Calibri; font-size: medium; ">make:=
 *** [out/host/linux-x86/obj/EXECUTABLES/obbtool_intermediates/Main.o] Error=
 1</div><div style=3D"font-family: Calibri; font-size: medium; "><br></div></d=
iv><div style=3D"font-family: Calibri; font-size: medium; ">Has anyone else se=
en this since the move of the code to git?</div><div style=3D"font-family: Cal=
ibri; font-size: medium; "><br></div><div style=3D"font-family: Calibri; font-=
size: medium; ">Regards,</div><div style=3D"font-family: Calibri; font-size: m=
edium; ">Gia Nguyen</div><div style=3D"font-family: Calibri; font-size: medium=
; "><br></div><div style=3D"font-family: Calibri; font-size: medium; "><br></d=
iv><div><div><div><p></p></div></div></div></div></div></div></div></span></=
body></html>

--B_3426492958_580499--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
