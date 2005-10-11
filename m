Date: Tue, 11 Oct 2005 20:20:02 +0700
From: Dave Patterson <sdpatt2@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Re: System hang during boot on Debian Sid
Message-ID: <20051011132002.GA6249@localhost.localdomain>
References: <20051009083426.GA10995@localhost.localdomain> <1129033658.3308.48.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1129033658.3308.48.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley <sds@tycho.nsa.gov> [2005-10-11 08:27:38 -0400]:


> > and the system hangs.  Any suggestions?
> 
> That change was included in the 2.6.13-selinux1.patch and is going to be
> part of 2.6.14 upstream (already in 2.6.14-rcX, and has been in Fedora
> rawhide kernels for a while).
Ah. OK... 
> I don't know about the state of SELinux in Debian sid, but Russell's
> message indicated that udev doesn't work well with SELinux in Debian
> yet.  
> 
And I can see why - Debian's initrd is archaic, so I don't use it
unless I have to, and udev in our distro is indeed grumpy.
No, the main cause of my problems so far lie in my policy
configuration at the moment (the boot process was hanging at INIT) -
Russel's package is the strict policy, and I haven't edited it well
enough yet.  I'm attempting a prototype multiuser, multilingual
desktop install using this, and I've banged my shins on a few things so far.
-- 
Regards, Dave
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
