Date: Tue, 22 Jan 2002 16:13:00 -0800
From: Paul Krumviede <pwk@acm.org>
To: forrest whitcher <fw@fwsystems.com>, SELinux@tycho.nsa.gov
Subject: Re: switching between SE Linux utils - kernel versions ? ... also
 ntp
Message-ID: <197460933.1011715980@localhost>
In-Reply-To: <20020122171507.060a9821.fw@fwsystems.com>
References: <20020122171507.060a9821.fw@fwsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Tuesday, 22 January, 2002 17:15 -0500 forrest whitcher 
<fw@fwsystems.com> wrote:

>
> A note on NTP: ntpd / ntpdate on my selinux installation has
> (surprsingly) not raised any AVC: messages in develop/permissive mode.
> Does this suggest that setting system time is not LSM / SEL hooked?

if ntpddate/ntpd are (only) run out of the init scripts, then ntpd
is probably still running in the initrc domain, which may not be
desirable. i recall having to make some changes for things
like adjtime at system shutdown (this was interesting because
it occured after syslog was stopped, so i only saw it as a console
message).

every version of the selinux/README file i've read has text
along the lines of "run 'ps -e --context' and if anything is running
in the initrc domain then check it carefully as it should either have
its own domain or the executable may not have been labelled
correctly."

as to selinux/kernel versions, i've had problems with the
utilities from versions 2.4.16 and afterwards running on
pre-2.4.16 kernels. i'm not sure if the selinux versions of
login will work correctly on the different kernel versions
(i know i wound up with a version of login that wouldn't
allow logins in the process of booting yet another selinux
version, but i don't recall the exact details). for safety's
sake i keep one non-selinux kernel around i can boot
from in an emergency, along with all the selinux/utils
directories so i can do a combination of "make install"
for the utilities and then relabel (but i might not do
that on production machines).

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
