Message-ID: <1342703895.31048.13.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SE Android (Was: Re: Welcome to selinux)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: Robert Craig <robertpcraig@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 19 Jul 2012 09:18:15 -0400
In-Reply-To: <CAKi3Pur20_u_BFEkHm++OydrN4zCm+o0jSzeY04DpmQ+aAOmqA@mail.gmail.com>
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
	 <CAKi3Pur20_u_BFEkHm++OydrN4zCm+o0jSzeY04DpmQ+aAOmqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-16 at 14:40 +0200, Alexandra Test wrote:
> My phone is now is in enforcing mode but I can not install anything.
> I tried from google play but after the download, when it tries to
> install says:
> "the download url is not valid"
> 
> Do I have to change the policies? I saw the app.te files in
> external/sepolicy in the build directory, but where can I fine the
> same file on the phone?
> Do I need to rebuild and reflash every time I change the policies?

Check for avc denials.  With regard to updating the policy, you can
modify the policy source files, do a 'make sepolicy' to regenerate the
kernel policy file, do an 'adb push
out/target/product/<device>/root/sepolicy.24 /data/system/' and do a
'adb shell su 0 setprop selinux.loadpolicy 1' to reload policy
from /data/system rather than having to reflash the system partition
each time. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
