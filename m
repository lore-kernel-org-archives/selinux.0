Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAPNB2Rb016993
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 18:11:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAPNASp5008628
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 23:10:28 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAPNARt0008625
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 23:10:27 GMT
Date: Tue, 25 Nov 2003 23:11:00 +0000
From: Dale Amon <amon@vnl.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: Still no authentication from new debian packages
Message-ID: <20031125231100.GQ2718@vnl.com>
References: <20031125140255.GI2718@vnl.com> <20031125205010.GA2174@rom.cip.informatik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031125205010.GA2174@rom.cip.informatik.uni-muenchen.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 25, 2003 at 09:50:11PM +0100, Thomas Bleher wrote:
> I'm using Russel's packages on a new Debian install and am booting up
> fine in enforcing mode. The one thing I had to change in policy to be
> able to login was to add the line
> 
>         allow system_chkpwd_t tty_device_t:chr_file rw_file_perms;
> 
> to macros/program/chkpwd_macros.te
> 
> I also appended the line 
>         session required pam_selinux.so
> to /etc/pam.d/{login,ssh}

That is worth a look also. But I think Russell might
need to look into some of this... the object of what
I'm doing is not to get selinux working on this 
machine per-se. It's to verify that I can define a
full build process from bare disk to running selinux
with as little fiddling as possible.

I suspect I'll be annoying Russ with trivia for 
quite some time.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
