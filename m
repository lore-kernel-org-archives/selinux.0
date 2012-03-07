Subject: Re: CTS failure on SEAndroid Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Subramani Venkatesh <selinuxv31@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
References: 
	 <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Mar 2012 08:36:12 -0500
Message-ID: <1331127372.16697.21.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-07 at 08:18 -0500, Subramani Venkatesh wrote:
> Hi,
> Trying to execute CTS on SEAndroid with security enforce, but I am not
> successful getting it working, it crashes at the very beginning with
> an exeception, is anyone else seeing the same issue?

First, did you make sure that you had no avc messages before going into
enforcing mode and even trying to run the CTS?  adb shell dmesg | grep
avc should yield no output.

Second, make sure you can run the CTS in permissive mode without any
difficulties as your baseline.

Third, make sure you enable the android_cts policy boolean before
running the CTS.  If you have configured the CTS to not reboot the
device (set maxTestCount to -1 in repository/host_config.xml), then you
can just do this once via adb shell su 0 setsebool android_cts=1.
Otherwise, if you want to allow periodic reboots during the CTS, you
need to add setsebool android_cts=1 and setenforce 1 to your init.rc or
init.<board>.rc file so that it happens on each boot.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
