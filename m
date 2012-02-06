Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q16FuwnZ027961
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2012 10:56:58 -0500
Received: from mail-ee0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q16FuvDo027059
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2012 15:56:57 GMT
Received: by eeke51 with SMTP id e51so2149677eek.12
        for <selinux@tycho.nsa.gov>; Mon, 06 Feb 2012 07:56:56 -0800 (PST)
Message-ID: <1328543813.1905.2.camel@x220.mydomain.internal>
Subject: Re: SELinux on Wheezy
From: Dominick Grift <dominick.grift@gmail.com>
To: cjac@colliertech.org
Cc: SE-Linux <selinux@tycho.nsa.gov>
Date: Mon, 06 Feb 2012 16:56:53 +0100
In-Reply-To: <1328502407.14110.7074.camel@calcifer>
References: <1328502407.14110.7074.camel@calcifer>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2012-02-05 at 20:26 -0800, C.J. Adams-Collier KF7BMP wrote:
> Hey folks,
> 
> I brought up a wheezy install on an alternate lvm root a couple of weeks
> ago.  I turned SELinux on shortly thereafter.  I think I updated my
> kernel, and now X won't start.  Could someone look at these logs with me
> and help figure out what's going on?  Something showed up during boot
> that said something about updating labels, but I didn't capture it.
> Where should I look to find these boot logs, do you think?
> 
> http://www.colliertech.org/federal/nsa/selinux-20120205T2023PST.log
> 
> Thank you in advance!
> 
> C.J.
> 
> 

Seems to be an XACE issue.

> > /var/log/Xorg.56.log.old:[    46.050] SELinux: a property label lookup failed!
> > /var/log/Xorg.56.log.old:[    46.050] SELinux: Failed to set label property on window!

getsebool -a | xserver_object_manager

Does it work if you set it to off?

setsebool -P xserver_object_manager off

http://selinuxproject.org/page/NB_XWIN



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
