Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA12462
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2001 16:52:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA09376
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2001 20:51:58 GMT
Received: from truffula.epoch.ncsc.mil (truffula.epoch.ncsc.mil [144.51.25.134])
	by jazzband.ncsc.mil  with ESMTP id UAA09372
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2001 20:51:58 GMT
Date: Thu, 12 Jul 2001 16:51:48 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Ying-Hung Chen <ying@yingternet.com>
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: development of SELinux
Message-ID: <20010712165148.C1566@truffula.epoch.ncsc.mil>
References: <00da01c10b0c$4496a140$bd6e13d1@yinglaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00da01c10b0c$4496a140$bd6e13d1@yinglaptop>; from ying@yingternet.com on Thu, Jul 12, 2001 at 12:53:05PM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

First, let me respond to what seems to be the main concern.  Is the project
on hold?  The answer is that the project is still under active development.
We regret that the website has not been the subject of frequent updates.  As
pointed out by Ying-Hung Chen the archives of the mailing list are available
although not all on the website.  The website does indeed point to the
majordomo archives in the text on "SELinux List Archive Access" at
<http://www.nsa.gov/selinux/list.html>.

We hope to update the website soon.  Of course, the web-based mailing list
archives will be updated then.  One of the issues we've been wrestling with
here is what work to present.  The SELinux project has recently been focused
on working with the linux-security-modules (LSM) project to integrate a set of
module interfaces into the linux kernel which could be used by security projects
such as SELinux.  In doing this, work on porting SELinux to new kernel versions
has suffered.  We are contemplating releasing work-in-progress on the LSM-based
SELinux, although it is less stable than the non-LSM SELinux code.  We are
also considering just how much effort we should extend in improvements to
non-LSM SELinux vice putting all our effort into an LSM-based version.

We welcome input about what the community would like to see.  Although I
would ask that you keep in mind our research interests are our primary
guide for decisions on our effort.

On Thu, Jul 12, 2001 at 12:53:05PM -0700, Ying-Hung Chen wrote:
> Hi,
> 
>     I noticed that there is no more releases of SELinux since April, and
> also the mailinglist archive hasn't get updated on the NSA's SELinux website
> too. Since everthing seems to be on hold right now, I would be very
> interested to know what's going to happen for this project? are there
> anymore releases? or we are on our own?
> 
> Thanks,
> 
> -Ying
> 
> PS. yes, I know the emaillist are still active and archived. but why the
> main webside didn't even have the pointer to the archives too?

--
Howard Holm <hdholm@epoch.ncsc.mil>
Information Assurance Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
