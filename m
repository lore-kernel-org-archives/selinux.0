MIME-Version: 1.0
In-Reply-To: <CAKi3PurKGD7-HibnqcCiJYjFzYMu0Nb2D5BcuGCMCLEE8wbpQg@mail.gmail.com>
References: <201206211329.q5LDT6PW031262@tarius.tycho.ncsc.mil>
	<CAKi3Pur-Ne8vAfbw6t4hutrqJO73x=wOaHvTg8dca4W-LUOuLg@mail.gmail.com>
	<1340288275.4234.48.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3PuqSFBw8EHLCXuASBxoMEEX4wTuW0MZOdEURO5_GWTVcnA@mail.gmail.com>
	<CAKi3PurC2T92r2mhzPKj7WoYb0Rf5Foz3W332Nov=Q5HZ8Ac3g@mail.gmail.com>
	<CAKi3Puqf0u=H379cBk+uXtSNCbpQjtM-cDcyTifDGG8CdV93nA@mail.gmail.com>
	<1340980684.15948.7.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3PupzMRZsYzPAj_U0ff_QyN1VJUkVB9mciL=D_K3Hinm5AQ@mail.gmail.com>
	<1341866938.10134.23.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3Pup04kG+JPu+oudi1Bet2d0S=dz1t1RDwiYuFLLtHkCV4g@mail.gmail.com>
	<CADQgGG35SABA6ZjDneqeGOrvbLT722Pvxsn6=G5S744d-TPxoA@mail.gmail.com>
	<CAKi3PuqyCBS1fzjhSh1TVRsXCxR2_UnxXJG5ZCFL2XzF91MP4A@mail.gmail.com>
	<CADQgGG1ry-x+0B2LHjY_SPvDiyUWBq4Pa5BVf6bFVokWvV3=qQ@mail.gmail.com>
	<CAKi3PurKGD7-HibnqcCiJYjFzYMu0Nb2D5BcuGCMCLEE8wbpQg@mail.gmail.com>
Date: Sun, 15 Jul 2012 00:25:43 -0400
Message-ID: <CADQgGG2dr4U36Pajg5XY1-vJO0uFszrpA2hXi6B-AwuBzyhbhQ@mail.gmail.com>
Subject: Re: SE Android (Was: Re: Welcome to selinux)
From: Robert Craig <robertpcraig@gmail.com>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d04428de8e3943c04c4d6b474
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04428de8e3943c04c4d6b474
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jul 13, 2012 at 8:50 AM, Alexandra Test <
testalexandrainstitute@gmail.com> wrote:


> I tried to investigate without success, so I decided to try to use the
> restorecon. is it needed to be root?
> on which files do I need to use restorecon? how?
>
>
You'll not only have to be root, but you'll also need to remount your
system partition (android mounts it read only).
I would try:
adb shell
su
mount -o rw,remount </dev/block path for your device> /system
restorecon -R /system

--f46d04428de8e3943c04c4d6b474
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>On Fri, Jul 13, 2012 at 8:50 AM, Alexandra Test <span dir=3D"ltr">&lt;=
<a href=3D"mailto:testalexandrainstitute@gmail.com" target=3D"_blank">testa=
lexandrainstitute@gmail.com</a>&gt;</span> wrote:</div><div class=3D"gmail_=
quote">
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">I tried to investigate without=
 success, so I decided to try to use the restorecon. is it needed to be roo=
t?<br>
on which files do I need to use restorecon? how?<br><br></blockquote><div><=
br></div><div>You&#39;ll not only have to be root, but you&#39;ll also need=
 to remount your system partition (android mounts it read only).</div><div>
I would try:</div><div>adb shell</div><div>su</div><div>mount -o rw,remount=
 &lt;/dev/block path for your device&gt; /system</div><div>restorecon -R /s=
ystem</div></div>

--f46d04428de8e3943c04c4d6b474--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
