Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14JH5LO003380
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 14:17:05 -0500
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m14JH3g3021844
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 19:17:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Seth D. Guikema" <sguikema@jhu.edu>
Subject: Re: reindexing time for SELinux?
Date: Tue, 5 Feb 2008 06:16:48 +1100
Cc: selinux@tycho.nsa.gov
References: <47A71F79.1020300@jhu.edu>
In-Reply-To: <47A71F79.1020300@jhu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802050616.50247.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 05 February 2008 01:21, "Seth D. Guikema" <sguikema@jhu.edu> wrote:
> I am trying to set up SELinux on my Fedora Core 7 workstation. I am
> using the pre-installed GUI SELinux configuration tool in FC7. I
> selected a targeted set-up.

Is it a fresh install or did you just enable SE Linux after previously having 
it disabled?

> I was warned that the workstation would need 
> to reindex the files at the next reboot and that this would take a
> while. I clicked ok. I rebooted the workstation Saturday morning at
> about 10am. It is still unresponsive (and not available for remote
> connections) and working hard this morning, almost 48 hours later. How
> long should reindexing take?

Not 48 hours.  It's a function of the speed of CPU and disk and the number of 
files on disk.  I haven't seen it take more than about an hour on a slow 
machine, but as there is no upper limit on the number of files there is also 
no upper limit on the theoretical amount of time taken.

Did you boot the machine in permissive or enforcing mode?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
