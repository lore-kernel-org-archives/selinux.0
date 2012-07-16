MIME-Version: 1.0
In-Reply-To: <CAKi3PuqfNoefmyOMx5Q0OnnGeBHUVvJP5Ebb1Adh_HpCPwYvtA@mail.gmail.com>
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
	<CADQgGG2dr4U36Pajg5XY1-vJO0uFszrpA2hXi6B-AwuBzyhbhQ@mail.gmail.com>
	<CAKi3PuqfNoefmyOMx5Q0OnnGeBHUVvJP5Ebb1Adh_HpCPwYvtA@mail.gmail.com>
Date: Mon, 16 Jul 2012 14:40:47 +0200
Message-ID: <CAKi3Pur20_u_BFEkHm++OydrN4zCm+o0jSzeY04DpmQ+aAOmqA@mail.gmail.com>
Subject: Re: SE Android (Was: Re: Welcome to selinux)
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: Robert Craig <robertpcraig@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d041825bc37d61b04c4f1bd19
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d041825bc37d61b04c4f1bd19
Content-Type: text/plain; charset=ISO-8859-1

My phone is now is in enforcing mode but I can not install anything.
I tried from google play but after the download, when it tries to install
says:
"the download url is not valid"

Do I have to change the policies? I saw the app.te files in
external/sepolicy in the build directory, but where can I fine the same
file on the phone?
Do I need to rebuild and reflash every time I change the policies?



On Mon, Jul 16, 2012 at 12:47 PM, Alexandra Test <
testalexandrainstitute@gmail.com> wrote:

> it works, thank you! :-)
>
>
> On Sun, Jul 15, 2012 at 6:25 AM, Robert Craig <robertpcraig@gmail.com>wrote:
>
>> On Fri, Jul 13, 2012 at 8:50 AM, Alexandra Test <
>> testalexandrainstitute@gmail.com> wrote:
>>
>>
>>> I tried to investigate without success, so I decided to try to use the
>>> restorecon. is it needed to be root?
>>> on which files do I need to use restorecon? how?
>>>
>>>
>> You'll not only have to be root, but you'll also need to remount your
>> system partition (android mounts it read only).
>>  I would try:
>> adb shell
>> su
>> mount -o rw,remount </dev/block path for your device> /system
>> restorecon -R /system
>>
>
>

--f46d041825bc37d61b04c4f1bd19
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

My phone is now is in enforcing mode but I can not install anything.<br>I t=
ried from google play but after the download, when it tries to install says=
:<br>&quot;the download url is not valid&quot;<br><br>Do I have to change t=
he policies? I saw the app.te files in external/sepolicy in the build direc=
tory, but where can I fine the same file on the phone?<br>
Do I need to rebuild and reflash every time I change the policies?<br><br><=
br><div><br><div class=3D"gmail_quote">On Mon, Jul 16, 2012 at 12:47 PM, Al=
exandra Test <span dir=3D"ltr">&lt;<a href=3D"mailto:testalexandrainstitute=
@gmail.com" target=3D"_blank">testalexandrainstitute@gmail.com</a>&gt;</spa=
n> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">it works, thank you! :-)<div><div><br><br><d=
iv class=3D"gmail_quote">On Sun, Jul 15, 2012 at 6:25 AM, Robert Craig <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:robertpcraig@gmail.com" target=3D"_blan=
k">robertpcraig@gmail.com</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div>On Fri, Jul 13, 2012 at 8:50 AM, A=
lexandra Test <span dir=3D"ltr">&lt;<a href=3D"mailto:testalexandrainstitut=
e@gmail.com" target=3D"_blank">testalexandrainstitute@gmail.com</a>&gt;</sp=
an> wrote:</div>


</div><div class=3D"gmail_quote"><div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">I tried to investigate without=
 success, so I decided to try to use the restorecon. is it needed to be roo=
t?<br>



on which files do I need to use restorecon? how?<br><br></blockquote><div><=
br></div></div><div>You&#39;ll not only have to be root, but you&#39;ll als=
o need to remount your system partition (android mounts it read only).</div=
>


<div>
I would try:</div><div>adb shell</div><div>su</div><div>mount -o rw,remount=
 &lt;/dev/block path for your device&gt; /system</div><div>restorecon -R /s=
ystem</div></div>
</blockquote></div><br>
</div></div></blockquote></div><br></div>

--f46d041825bc37d61b04c4f1bd19--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
