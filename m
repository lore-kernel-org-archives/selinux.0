Message-ID: <1345566914.23408.5.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Porting seandroid to qualcomm MSM8960
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Cesar Maiorino <cesar.maiorino@gmail.com>
Cc: Robert Craig <robertpcraig@gmail.com>, selinux@tycho.nsa.gov
Date: Tue, 21 Aug 2012 12:35:14 -0400
In-Reply-To: <CAN93Rk+5OSUiG7KJ-GhLcxNddepN+uYwpn+iXjYDbr9dnW2kQg@mail.gmail.com>
References: 
	<CAN93Rk+MnaUMaG_2r-S11TWpsOuDjomCjmZtJ7jiVQ6agLrkEg@mail.gmail.com>
	 <CADQgGG2_xbPNy-HYjeD6jSf9+3_3Arfhv6FiRBPAT+jVLDzXVA@mail.gmail.com>
	 <CADQgGG22RppyavV=Mi5ZC99v7pzdpYK-YmdfALPxqXeH08FnXg@mail.gmail.com>
	 <CAN93Rk+5OSUiG7KJ-GhLcxNddepN+uYwpn+iXjYDbr9dnW2kQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-08-21 at 09:52 -0400, Cesar Maiorino wrote:
> I am targeting kernel version 3.0.8, so I guess I will start with one
> of the 3.0 kernels.
> Thanks for the detailed reply. It's a big help

Rather than having to manually identify and extract each patch, you can
use the branches to help you.  For each regular android-* kernel branch,
we have a corresponding seandroid-* kernel branch with our patches
applied, so you can do the following:
cd kernel/samsung
git checkout bitbucket/seandroid-samsung-3.0-jb
git format-patch bitbucket/android-samsung-3.0-jb

Notice that the checked-out branch is the seandroid-* branch, while you
generate the patches starting from the android-* branch.

You only need the yaffs patches if you are using the yaffs2 filesystem
on the device.  The defconfig patch has to be ported over to your
specific board defconfig file.  Disabling the ratelimit on audit
messages is not strictly necessary, just nice for bringing up policy for
a new board.  Permission checking for binder is desirable but not
strictly required for operation.  Secmark labeling and the netfilter
security table is optional.



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
