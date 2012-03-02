Subject: Re: SE Android on Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Subramani Venkatesh <selinuxv31@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
References: 
	 <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Mar 2012 10:39:36 -0500
Message-ID: <1330702776.2616.43.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-03-02 at 10:29 -0500, Subramani Venkatesh wrote:
> Hi,
> I got SE Android working on Galaxy Nexus, followed instructions from
> http://selinuxproject.org/page/SEAndroid
> After executing "setenforce 1", launching applications works as
> expected, but it is only short period of time, later it reboots. Would
> like to debug the issues, Is their any guide to debug SE on Android?

Did you try the policy changes posted by Bryan Hinton for the Galaxy
Nexus?  See:
http://marc.info/?l=selinux&m=132752617008734&w=2

Before running setenforce 1, you should check for any avc messages in
your dmesg output, e.g.
adb shell dmesg | grep avc

Such denials need to be addressed through policy changes or labeling
changes before you go to enforcing mode.

You might want to start a process capturing dmesg output just before you
go to enforcing mode, e.g.
adb shell su 0 cat /proc/kmsg

adb logcat *:E can also be helpful.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
