Subject: RE: SELinux query
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Devendra Talegaonkar <Devendra.Talegaonkar@kpitcummins.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <A2F8C1DC917AEC409BE49BB1E1DEF34D1FDF7253@KCHJEXMB02.kpit.com>
References: <A2F8C1DC917AEC409BE49BB1E1DEF34D1FDF6F78@KCHJEXMB02.kpit.com>
	 <4F2FE956.3050403@redhat.com>
	 <A2F8C1DC917AEC409BE49BB1E1DEF34D1FDF7074@KCHJEXMB02.kpit.com>
	 <4F31591B.8090402@redhat.com> <1328636271.2162.56.camel@moss-pluto>
	 <A2F8C1DC917AEC409BE49BB1E1DEF34D1FDF7253@KCHJEXMB02.kpit.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 08 Feb 2012 08:33:52 -0500
Message-ID: <1328708032.19254.23.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-02-08 at 09:50 +0000, Devendra Talegaonkar wrote:
> Hello,
> I am trying to load policy in kernel with  load_policy utility.
> Selinuxfs is mounted on /selinux and there is enough space on the /selinux. But at the time of  mounting it is giving me error as "No space left on device"
> Can you please guide on this?

- Need to know what libselinux you are using, e.g. the upstream one (if
so, what version) or the port to Android.
- Need to know what load_policy you are using, e.g. the one from
policycoreutils (if so, what version), the port to busybox (if so, what
version), or the port to Android toolbox.
- The actual error message would be helpful.
- strace of the failed load_policy would be helpful, if you have a
working strace for that target.
- libselinux was recently changed to mount selinuxfs on /sys/fs/selinux
and look for it there first, falling back to /selinux if it isn't there.
Don't know if that might be making a difference for you.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
