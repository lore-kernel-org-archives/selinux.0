MIME-Version: 1.0
In-Reply-To: <1330702776.2616.43.camel@moss-pluto>
References: <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
	<1330702776.2616.43.camel@moss-pluto>
Date: Fri, 2 Mar 2012 11:03:44 -0500
Message-ID: <CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
Subject: Re: SE Android on Galaxy Nexus
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Stephen,
I did not add Bryan changes, i will add them now and see the difference.
Thanks for debug information.

Regards,
Subbu

On Fri, Mar 2, 2012 at 10:39 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2012-03-02 at 10:29 -0500, Subramani Venkatesh wrote:
>> Hi,
>> I got SE Android working on Galaxy Nexus, followed instructions from
>> http://selinuxproject.org/page/SEAndroid
>> After executing "setenforce 1", launching applications works as
>> expected, but it is only short period of time, later it reboots. Would
>> like to debug the issues, Is their any guide to debug SE on Android?
>
> Did you try the policy changes posted by Bryan Hinton for the Galaxy
> Nexus?  See:
> http://marc.info/?l=selinux&m=132752617008734&w=2
>
> Before running setenforce 1, you should check for any avc messages in
> your dmesg output, e.g.
> adb shell dmesg | grep avc
>
> Such denials need to be addressed through policy changes or labeling
> changes before you go to enforcing mode.
>
> You might want to start a process capturing dmesg output just before you
> go to enforcing mode, e.g.
> adb shell su 0 cat /proc/kmsg
>
> adb logcat *:E can also be helpful.
>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
