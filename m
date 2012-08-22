Message-ID: <1345668870.7532.2.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Problems getting source using repo sync
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Cesar Maiorino <cesar.maiorino@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 22 Aug 2012 16:54:30 -0400
In-Reply-To: <CAN93RkL87Hscd1pdG8SUKqpNjZiwZ6Xyih=g+8HhL-vtP549Hw@mail.gmail.com>
References: 
	<CAN93RkL87Hscd1pdG8SUKqpNjZiwZ6Xyih=g+8HhL-vtP549Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-08-22 at 16:46 -0400, Cesar Maiorino wrote:
> I'm following the instructions on
> http://selinuxproject.org/page/SEAndroid to get the ICS seandroid
> source, but keep getting messages like this when syncing (the second
> sync with the seandroid manifest):
> 
> error:
> '/home/cmaiorin/seandroid-4.0.4/.repo/projects/external/libsepol.git/clone.bundle' does not look like a v2 bundle file
> fatal: Could not read bundle
> '/home/cmaiorin/seandroid-4.0.4/.repo/projects/external/libsepol.git/clone.bundle'.
> 
> Any ideas what the problem is?

Does it happen if you pass -j1 to repo sync, i.e.
	repo sync -j1

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
