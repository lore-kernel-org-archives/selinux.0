Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA9NRaNP011632
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2012 18:27:36 -0500
Received: by mail-vc0-f181.google.com with SMTP id n11so5039708vch.12
        for <selinux@tycho.nsa.gov>; Fri, 09 Nov 2012 15:27:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <C1432A7484D61749AF22A060C2B03C5D0B537D7F54@StaEx7mb3.telecom.sna.samsung.com>
References: <C1432A7484D61749AF22A060C2B03C5D0B537D7F54@StaEx7mb3.telecom.sna.samsung.com>
Date: Fri, 9 Nov 2012 18:27:34 -0500
Message-ID: <CAB9W1A3Y2bFqZ=MX__8wFNuB=Q+nDnEoxq9Th1=ZeTcFuywScg@mail.gmail.com>
Subject: Re: reload seandroid policy
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Shuiqing Wang <s.wang@sta.samsung.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 9, 2012 at 5:26 PM, Shuiqing Wang <s.wang@sta.samsung.com> wrote:
> I am new to SEAndroid and I have a couple of questions about reloading
> policy, on Android 4.0.4.
>
> 1. I read from the SEAndroid wiki that I can copy a new policy file
> to /data/system, and issue a "setprop selinux.reload_policy 1" command
> in adb shell to trigger a reload of policy. I did this but nothing
> happened. How do I know the reload is successful or not? I checked dmesg
> but saw nothing useful.
>
> 2. How to I know which policy file is pointed to by the kernel currently
> if multiple policies exist on my device? Is there a adb shell command or
> log file that can help?

Questions about SE Android should be directed to the seandroid-list
these days; see the wiki for how to subscribe.
Assuming that you have in fact built with SE Android enabled, then you
should have output in dmesg about the policy load and which policy
file was loaded.
Any particular reason you are using 4.0.4 rather than 4.1.2 or master?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
