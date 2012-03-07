MIME-Version: 1.0
In-Reply-To: <1331127372.16697.21.camel@moss-pluto>
References: <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
	<1331127372.16697.21.camel@moss-pluto>
Date: Wed, 7 Mar 2012 08:57:25 -0500
Message-ID: <CAD8iFzwjZbUsmPJan6tU-un9goYWxZFbrykqYXr3HU+o6ea1_Q@mail.gmail.com>
Subject: Re: CTS failure on SEAndroid Galaxy Nexus
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,

Thanks for the response, my comments are inlined

On Wed, Mar 7, 2012 at 8:36 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2012-03-07 at 08:18 -0500, Subramani Venkatesh wrote:
>> Hi,
>> Trying to execute CTS on SEAndroid with security enforce, but I am not
>> successful getting it working, it crashes at the very beginning with
>> an exeception, is anyone else seeing the same issue?
>
> First, did you make sure that you had no avc messages before going into
> enforcing mode and even trying to run the CTS?  adb shell dmesg | grep
> avc should yield no output.
<Subbu>: I fixed most of it, they were couple of them missing, I will
fix them and try again.
>
> Second, make sure you can run the CTS in permissive mode without any
> difficulties as your baseline.
<Subbu>: Yes CTS executes in permissive mode without any issues.
>
> Third, make sure you enable the android_cts policy boolean before
> running the CTS.  If you have configured the CTS to not reboot the
> device (set maxTestCount to -1 in repository/host_config.xml), then you
> can just do this once via adb shell su 0 setsebool android_cts=1.
> Otherwise, if you want to allow periodic reboots during the CTS, you
> need to add setsebool android_cts=1 and setenforce 1 to your init.rc or
> init.<board>.rc file so that it happens on each boot.
<Subbu>: I did enable android_cts_policy boolean, I shall try changed
my init.rc file to setenforce 1 all the time.

>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
