From: "Leslie J. French" <ljf@semandex.net>
To: "SELinux" <SELinux@tycho.nsa.gov>
Subject: poweroff problem?
Date: Sat, 6 Jul 2002 11:35:17 -0400
Message-ID: <BFEMIIHKHLALNELLMPOMMEKBCBAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1025911273.8785.1.camel@phobos>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just installed lsm 2-4 selinux 2002070313 on top of RH7.3 (2.4.18-3)

I never tried on my older version, but I found that /sbin/poweroff doesn't
work under SELinux as I configured/built it.  If I boot into the RH kernel,
it works (turns off the machine power), but in SELinux it shuts down as far
as "Powering off" message but leaves the machine running. In the config I
set:

  ACPI support; APM-enable-at-boot, idle-when-idle and
use-APM-bios-to-poweroff

The system is running [kapmd] and apmd daemons, but I'm wondering if there
is a conflict between the RH and LSM versions, since the boot log shows:

   apm BIOS 1.2
   ....
   Capability LSM initialised
   ACPI: APM is already active, exiting.

And there are a lot of avc violations associated with killall from apmd_t to
various other types (e.g. kernet_t).  This is as "out of the box" as I can
make my system, none of my users or domains are in the system, and I'm using
the .te and .fc files directly from the distribution.

If a more knowledgable person could give me a hint as to what might be going
wrong, I would appreciate it.  If you need the config/log files I will post
them separately.

Thanks,  Leslie


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
