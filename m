MIME-Version: 1.0
In-Reply-To: <1345566914.23408.5.camel@moss-pluto.epoch.ncsc.mil>
References: <CAN93Rk+MnaUMaG_2r-S11TWpsOuDjomCjmZtJ7jiVQ6agLrkEg@mail.gmail.com>
 <CADQgGG2_xbPNy-HYjeD6jSf9+3_3Arfhv6FiRBPAT+jVLDzXVA@mail.gmail.com>
 <CADQgGG22RppyavV=Mi5ZC99v7pzdpYK-YmdfALPxqXeH08FnXg@mail.gmail.com>
 <CAN93Rk+5OSUiG7KJ-GhLcxNddepN+uYwpn+iXjYDbr9dnW2kQg@mail.gmail.com> <1345566914.23408.5.camel@moss-pluto.epoch.ncsc.mil>
From: Cesar Maiorino <cesar.maiorino@gmail.com>
Date: Thu, 23 Aug 2012 13:15:33 -0400
Message-ID: <CAN93RkLphK169NfUgcqPvCM8Lh+TtwFtmHki9oJYxD=b_a06hg@mail.gmail.com>
Subject: Re: Porting seandroid to qualcomm MSM8960
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Robert Craig <robertpcraig@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00504502d53149bc7804c7f204e6
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504502d53149bc7804c7f204e6
Content-Type: text/plain; charset=ISO-8859-1

Thanks. It's helpful to know which patches are important.


> Rather than having to manually identify and extract each patch, you can
> use the branches to help you.  For each regular android-* kernel branch,
> we have a corresponding seandroid-* kernel branch with our patches
> applied, so you can do the following:
> cd kernel/samsung
> git checkout bitbucket/seandroid-samsung-3.0-jb
> git format-patch bitbucket/android-samsung-3.0-jb
>
> Notice that the checked-out branch is the seandroid-* branch, while you
> generate the patches starting from the android-* branch.
>
> You only need the yaffs patches if you are using the yaffs2 filesystem
> on the device.  The defconfig patch has to be ported over to your
> specific board defconfig file.  Disabling the ratelimit on audit
> messages is not strictly necessary, just nice for bringing up policy for
> a new board.  Permission checking for binder is desirable but not
> strictly required for operation.  Secmark labeling and the netfilter
> security table is optional.
>
>
>
> --
> Stephen Smalley
> National Security Agency
>
>

--00504502d53149bc7804c7f204e6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks. It&#39;s helpful to know which patches are important.<br><br><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im">
<br>
</div>Rather than having to manually identify and extract each patch, you c=
an<br>
use the branches to help you. =A0For each regular android-* kernel branch,<=
br>
we have a corresponding seandroid-* kernel branch with our patches<br>
applied, so you can do the following:<br>
cd kernel/samsung<br>
git checkout bitbucket/seandroid-samsung-3.0-jb<br>
git format-patch bitbucket/android-samsung-3.0-jb<br>
<br>
Notice that the checked-out branch is the seandroid-* branch, while you<br>
generate the patches starting from the android-* branch.<br>
<br>
You only need the yaffs patches if you are using the yaffs2 filesystem<br>
on the device. =A0The defconfig patch has to be ported over to your<br>
specific board defconfig file. =A0Disabling the ratelimit on audit<br>
messages is not strictly necessary, just nice for bringing up policy for<br=
>
a new board. =A0Permission checking for binder is desirable but not<br>
strictly required for operation. =A0Secmark labeling and the netfilter<br>
security table is optional.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote><br></div><br>

--00504502d53149bc7804c7f204e6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
