Date: Fri, 16 Apr 2004 00:17:39 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Thorsten Sauter <tsauter@gmx.net>
Cc: SELinux Developers <SELinux@tycho.nsa.gov>
Subject: Re: pam_selinux.so question
Message-ID: <20040415221739.GA28260@rom.cip.ifi.lmu.de>
References: <20040414220007.GA15471@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20040414220007.GA15471@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Thorsten Sauter <tsauter@gmx.net> [2004-04-15 01:37]:
> I have installed a fresh Debian Sid system (powerpc) and compiled my own
> 2.6.5 (vanilla kernel) with selinux support.
> 
> All required packages for selinux are installed (simply rebuild the
> debian packages).
> 
> But now, I have a mysterious behavior with the pam_selinux.so module,
> which is required in /etc/pam.d/login.
> 
> If I login as root I got the normal info text:
> "Your default context is root:sysadm_r:sysadm_t." [...]
> 
> But as soon as I try this as an normal user I got a new question:
> "Would you like to enter a security context? [y]"
> 
> Hitting "n" will end with an "authentication failure" and logout this
> user.
> Using "y" and insering user_r/user_t will help, and allow the user to
> login.
> 
> But why I get this "manual" question?

My guess is that you have not labeled your filesystem. pam_selinux.so
seems to behave this way if it can't find any labels on the fs.
If you do a "make reload relabel" and reboot, it should work.

HTH,
Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
