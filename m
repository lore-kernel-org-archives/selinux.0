Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB3HT1e7022158
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2013 12:29:01 -0500
Received: by mail-ee0-f48.google.com with SMTP id e49so1684010eek.35
        for <selinux@tycho.nsa.gov>; Tue, 03 Dec 2013 09:28:59 -0800 (PST)
Message-ID: <1386091735.27087.31.camel@d30>
Subject: Re: subscribe selinux
From: Dominick Grift <dominick.grift@gmail.com>
To: "Marino, Claudio" <cmarino@integrity-apps.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Tue, 03 Dec 2013 18:28:55 +0100
In-Reply-To: <D06E30E1B8C24A4DAB7535F0E91D6275F3FA97@CHUNEX01.integrity-apps.com>
References: 
	<D06E30E1B8C24A4DAB7535F0E91D6275F3FA97@CHUNEX01.integrity-apps.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2013-12-03 at 17:11 +0000, Marino, Claudio wrote:
> Hello,
> 
> I am looking at using SELinux for a GUI based MLS workstation.
> 
> For my example I have created a user (user_s1) with a classification of s2 and a second user (user_s2) with classification s3.  When in the enforcing mode I am not able to log in (from the GUI)  to either users.  It just bring be back to the login screen.
> 
> After going into permissive mode I try and see what is being blocked by searching the /var/log/audit/audit.log file and looking for "AVC" but I can't find anything about the login denial.  I have used setroubleshoot but still can't understand what needs to be modified to make it work.
> 
> Has anyone gotten a GUI to work with SELinux?  If so what polices need to be modified?
> 
> Thanks for our help,
> 
> Claudio
> 

Whats your distro? I have it working in RHEL 6.4 with some minor tweaks.
If i remember correctly they were xserver related tweaks ( so in MLS
systems also keep and eye on /var/log/Xorg.0.log since thats were X
object AVC denials go )

Anyhow I create two screencasts in which i demo how to use MLS in GUI
environment, and how to use netlabel. Unfortunately i seem to not have
recorded the process of actually configuring the environment:

https://www.youtube.com/watch?v=HRMC2gKCax4
https://www.youtube.com/watch?v=qeJUC753wg0

So yes it pretty much works but they are some gotchas.
If i remember correctly there were issues which gnome terminal where i
was able to declassify info by copying from one terminal and pasting to
another ( using xterm instead fixed that issues )

But other than that everything looks fine if you do not expect too much.
E.g. it only works with minimal desktops and there are limitations in
functionality (for example no sound)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
