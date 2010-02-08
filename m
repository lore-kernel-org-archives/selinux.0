Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o189WY40004709
	for <selinux@tycho.nsa.gov>; Mon, 8 Feb 2010 04:32:34 -0500
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o189WN2H021463
	for <selinux@tycho.nsa.gov>; Mon, 8 Feb 2010 09:32:24 GMT
Received: by wwc33 with SMTP id 33so1533254wwc.12
        for <selinux@tycho.nsa.gov>; Mon, 08 Feb 2010 01:32:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100207161635.GQ1750@myhost.felk.cvut.cz>
References: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com>
	 <20100207161635.GQ1750@myhost.felk.cvut.cz>
Date: Mon, 8 Feb 2010 10:32:31 +0100
Message-ID: <bf30b281002080132r486c8760hf45ac9f7c6ab144e@mail.gmail.com>
Subject: Re: Selinux in enforcing mode prevent network interface to be
	configured at boot for Debian stable ( 5.0)
From: Elko Kuric <elkokuric@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Michal,

your suggestion solved issue

change in /etc/network/interfaces

#allow-hotplug eth0
auto eth0

did a trick.


Thank+regards,

Elko

On Sun, Feb 7, 2010 at 5:16 PM, Michal Svoboda
<michal.svoboda@agents.felk.cvut.cz> wrote:
> Elko Kuric wrote:
>> I decided to move my debian installation to use Selinux, and I
>> installed it using
>> http://wiki.debian.org/SELinux  howto ( Debian 5 )
>> When Selinux is in "permissive" mode, network connection is up and it
>> works but when I switch Selinux to "enforcing" mode network interface
>> is down after reboot.
>
> From what I can remember this is an issue with the network hotplug.
> A short way to solve this is to simply disable hotplug for all your
> interfaces in /etc/network/interfaces (see man interfaces). You have
> a server anyway so you shouldn't need to plug network cards in and out
> while it's running.
>
> For a permanent fix, kindly report this to the debian folk.
>
> You will probably also experience AVC denials for all the scripts in
> /etc/network/*.d directories as they are not run in proper context.
> Again a quick solution is to disable them.
>
> I also recommend looking at Russell Coker's page [1] as he has created
> some packages that fix the most outcrying problems (eg. postfix).
>
> I am successfully running SELinux on debian lenny (5.0), so it can be
> done, only it needs some patience.
>
> Regards,
> Michal Svoboda
>
> [1] http://doc.coker.com.au/computers/installing-se-linux-on-lenny
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
