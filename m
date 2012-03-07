Subject: Re: CTS failure on SEAndroid Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Subramani Venkatesh <selinuxv31@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1331131202.16697.39.camel@moss-pluto>
References: 
	 <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
	 <1331127372.16697.21.camel@moss-pluto>
	 <CAD8iFzwjZbUsmPJan6tU-un9goYWxZFbrykqYXr3HU+o6ea1_Q@mail.gmail.com>
	 <1331129177.16697.26.camel@moss-pluto>
	 <1331131202.16697.39.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Mar 2012 15:28:03 -0500
Message-ID: <1331152083.16697.73.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-07 at 09:40 -0500, Stephen Smalley wrote:
> Just tried this myself, and I see that we'll need to make a few
> adjustments to policy for the current CTS.  Some of those will be made
> unconditionally outside of the android_cts boolean, while others are
> really only appropriate under test conditions and not production use.

I tracked down a subtle issue that was being hidden by a dontaudit rule
in the policy, and updated sepolicy for various denials that I saw in
getting the latest CTS started.  No guarantees that it will run all the
way through, but it certainly gets started now.  Prior to running the
CTS, I do the following:

adb shell su 0 setsebool android_cts=1
adb shell su 0 setenforce 1
adb shell su 0 cat /proc/kmsg > dmesg.txt &
adb logcat *:E > log.txt &

Later you can do something like the following to reduce dmesg.txt to
just the unique allow rules for easy review, although you would
typically evaluate each one to decide whether it should be generalized
(e.g. written in terms of a type attribute or using a macro), changed to
introduce a new domain or type, or replaced with a dontaudit rule.

audit2allow -p out/target/product/<device>/root/sepolicy.24 < dmesg.txt

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
