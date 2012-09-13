Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8D8Dg4p016602
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2012 04:13:42 -0400
Received: by wgbdt14 with SMTP id dt14so1644084wgb.30
        for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2012 01:13:41 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 13 Sep 2012 10:13:41 +0200
Message-ID: <CAKi3Pur6qLVmK5qv4QuWcuYFY_g+GNzcxOQjyQHj0Wxxm4FLcA@mail.gmail.com>
Subject: maguro 4.1.4
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8f13ea889bfe0804c990e296
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8f13ea889bfe0804c990e296
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
I am trying to update my seandroid release on my Samsung Galaxy Nexus.

Yesterday I compiled the full maguro 4.1.4 and put it in the phone. The
compiling has done well but now the phone can't turn on.

Do you know what can be the problem?

This is the procedure I follow.

git clone -b seandroid-4.1.1 https://bitbucket.org/seandroid/manifests.git
mkdir seandroid-4.1.1
cd seandroid-4.1.1
repo init -u https://android.googlesource.com/platform/manifest -b
android-4.1.1_r4
repo sync
cp ../manifests/local_manifest.xml .repo/
repo sync -j1

export PREFIX=/path/to/your/aospclone
cd $PREFIX/kernel/omap
make ARCH=arm tuna_defconfig
make ARCH=arm CROSS_COMPILE=$PREFIX/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-

cd $PREFIX
source build/envsetup.sh
lunch full_maguro-userdebug
export HAVE_SELINUX=true
make


Thanks for your help.

--e89a8f13ea889bfe0804c990e296
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<div>I am trying to update my seandroid release on my Samsung Galaxy=
 Nexus.</div><div><br></div><div>Yesterday I compiled the full maguro 4.1.4=
 and put it in the phone. The compiling has done well but now the phone can=
&#39;t turn on.=A0</div>
<div><br></div><div>Do you know what can be the problem?=A0</div><div><br><=
/div><div>This is the procedure I follow.</div><div><br></div><div><pre sty=
le=3D"padding:1em;border:1px dashed rgb(47,111,171);background-color:rgb(24=
9,249,249);line-height:1.1em">
git clone -b seandroid-4.1.1 <a href=3D"https://bitbucket.org/seandroid/man=
ifests.git">https://bitbucket.org/seandroid/manifests.git</a>
mkdir seandroid-4.1.1
cd seandroid-4.1.1
repo init -u <a href=3D"https://android.googlesource.com/platform/manifest"=
>https://android.googlesource.com/platform/manifest</a> -b android-4.1.1_r4
repo sync
cp ../manifests/local_manifest.xml .repo/
repo sync -j1</pre></div><div><pre style=3D"padding:1em;border:1px dashed r=
gb(47,111,171);background-color:rgb(249,249,249);line-height:1.1em">export =
PREFIX=3D/path/to/your/aospclone
cd $PREFIX/kernel/omap
make ARCH=3Darm tuna_defconfig
make ARCH=3Darm CROSS_COMPILE=3D$PREFIX/prebuilts/gcc/linux-x86/arm/arm-eab=
i-4.6/bin/arm-eabi-</pre></div><div><pre style=3D"padding:1em;border:1px da=
shed rgb(47,111,171);background-color:rgb(249,249,249);line-height:1.1em">c=
d $PREFIX
source build/envsetup.sh
lunch full_maguro-userdebug
export HAVE_SELINUX=3Dtrue
make</pre></div><div><br></div><div>Thanks for your help.</div>

--e89a8f13ea889bfe0804c990e296--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
