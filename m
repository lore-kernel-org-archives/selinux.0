Subject: Re: CTS failure on SEAndroid Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Subramani Venkatesh <selinuxv31@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1331129177.16697.26.camel@moss-pluto>
References: 
	 <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
	 <1331127372.16697.21.camel@moss-pluto>
	 <CAD8iFzwjZbUsmPJan6tU-un9goYWxZFbrykqYXr3HU+o6ea1_Q@mail.gmail.com>
	 <1331129177.16697.26.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Mar 2012 09:40:02 -0500
Message-ID: <1331131202.16697.39.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-07 at 09:06 -0500, Stephen Smalley wrote:
> On Wed, 2012-03-07 at 08:57 -0500, Subramani Venkatesh wrote:
> > Hi Stephen,
> > 
> > Thanks for the response, my comments are inlined
> > 
> > On Wed, Mar 7, 2012 at 8:36 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On Wed, 2012-03-07 at 08:18 -0500, Subramani Venkatesh wrote:
> > >> Hi,
> > >> Trying to execute CTS on SEAndroid with security enforce, but I am not
> > >> successful getting it working, it crashes at the very beginning with
> > >> an exeception, is anyone else seeing the same issue?
> > >
> > > First, did you make sure that you had no avc messages before going into
> > > enforcing mode and even trying to run the CTS?  adb shell dmesg | grep
> > > avc should yield no output.
> > <Subbu>: I fixed most of it, they were couple of them missing, I will
> > fix them and try again.
> > >
> > > Second, make sure you can run the CTS in permissive mode without any
> > > difficulties as your baseline.
> > <Subbu>: Yes CTS executes in permissive mode without any issues.
> > >
> > > Third, make sure you enable the android_cts policy boolean before
> > > running the CTS.  If you have configured the CTS to not reboot the
> > > device (set maxTestCount to -1 in repository/host_config.xml), then you
> > > can just do this once via adb shell su 0 setsebool android_cts=1.
> > > Otherwise, if you want to allow periodic reboots during the CTS, you
> > > need to add setsebool android_cts=1 and setenforce 1 to your init.rc or
> > > init.<board>.rc file so that it happens on each boot.
> > <Subbu>: I did enable android_cts_policy boolean, I shall try changed
> > my init.rc file to setenforce 1 all the time.
> 
> If you can run the CTS while in permissive mode, then you should do that
> again (leaving it in permissive mode, with android_cts=1) and collect up
> the denials.
> 
> adb shell su 0 cat /proc/kmsg > dmesg.txt
> 
> You can then add any necessary rules to cts.te under the boolean.

Just tried this myself, and I see that we'll need to make a few
adjustments to policy for the current CTS.  Some of those will be made
unconditionally outside of the android_cts boolean, while others are
really only appropriate under test conditions and not production use.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
