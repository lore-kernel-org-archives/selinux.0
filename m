Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: redhat.te and suse.te (was Re: pppd with ipppd)
Date: Thu, 12 Sep 2002 19:21:49 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200209082234.38885.russell@coker.com.au> <200209121632.39393.russell@coker.com.au> <20020912170340.C3722FA8D@ivanova.coker.com.au>
In-Reply-To: <20020912170340.C3722FA8D@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <200209121921.49843.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Sep 2002 18:56, Carsten Grohmann wrote:
> > The fact is that I proposed using M4 in the file contexts before, Steve
> > rejected the idea, and we now have an alternate solution.
> >
> > If we need a redhat.fc or suse.fc then we may need to use M4, however I
> > think that we will not need such entries.  I don't expect different
> > distributions to need different types for the same file, and therefore we
> > can put all definitions needed by all distributions in the main files.
> >
> > I suggest that we keep the current method in place until we have a
> > concrete example of something failing with it.
>
> You have right. This little example shows the boundary of the current
> method.

Actually your example does not show it at all.

> << suse.fc >>
>
> ifdef(`cups.fc',`
> ....
> dev/usb/lp*		system_u:object_r:printer_device_t
> ....
> ')

Firstly such an ifdef should probably make reference to lpd as well as cups...

Anyway /dev/usb/lp* is not a SUSE specific thing, it's documented in 
/usr/src/linux/Documentation/devices.txt so it applies to all distributions.

We should probably change the policy to match this now.

> ifdef(`ntpd.fc',`
> /var/log/ntp		system_u:object_r:var_log_ntp_t
> ')

Again this does not require anything special for SUSE.  Most distributions 
will not have a /var/log/ntp entry (I think).  However I am certain that no 
distribution will have /var/log/ntp unless it's a log file/directory for the 
NTP daemon, in which case that entry is OK.

It's OK to have entries in the file_contexts that don't match anything.

> I see there are more disadvantages then advantages. But if we like to merge
> the single suse file (apmd_suse.(fc|te) crond_suse, cups_suse, inetd_suse)
> , we need an fc file like this example, I think.
> The suse fc file are not empty. SuSE use in some cases similar filenames or
> it uses new "devices" like /dev/blog.

I see no advantages.  As long as there is no conflict there is no problem.  If 
SUSE uses a file named "foo" while Debian uses a file named "bar" for the 
same purpose, then we just put both in the file_contexts (it's what we have 
been doing so far).  It's only if the same file is used for different 
purposes that we have a problem.

This problem has not occurred yet, so I don't think that we need to try 
solving it.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
