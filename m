Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA29934
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 17:44:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA12180
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 21:43:13 GMT
Received: from swan.mail.pas.earthlink.net (swan.mail.pas.earthlink.net [207.217.120.123])
	by jazzswing.ncsc.mil  with ESMTP id VAA12176
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 21:43:12 GMT
From: "John Scroggins" <dataefx@earthlink.net>
To: "Stephen Smalley" <sds@tislabs.com>, "James Bishop" <james.bishop@jrc.it>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: Compiling for SuSE 7.2
Date: Tue, 4 Sep 2001 14:45:52 -0700
Message-ID: <LOBBKHHMGNHFHNPEJJLBGEEBCAAA.dataefx@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.GSO.4.33.0110041101190.7555-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James,

I did a little checking for you... :)

If you still have unresolved issues with installing SELinux on SuSE, fell
free to contact Chris Mahmood at SuSE for help. He is trying to work on a
set of guidelines for installation on the SuSE distro. He would gladly
accept your questions and help you to resolve some of these issues.

please contact me directly for his e-mail address

HTH

--John

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Stephen Smalley
Sent: Thursday, October 04, 2001 8:25 AM
To: James Bishop
Cc: selinux@tycho.nsa.gov
Subject: Re: Compiling for SuSE 7.2



On Thu, 4 Oct 2001, James Bishop wrote:

> The SELinux kernel boots (I attach the kernel configuration in
> sek_config);

I would recommend applying the patch to add support for stacking
capabilities with SELinux and the patch to fix a bug in the netlink_send
hook functions.  Also, you may want to apply the policy patches that have
been posted since the release.  These are available in the mailing list
archives via email to majordomo@tycho.nsa.gov or at
http://marc.theaimsgroup.com/?l=selinux.

> There are several "avc: denied" warnings logged in the /var/log/boot.msg
> log file (attached), which I've not yet had time to decipher, I expect
> there are inconsistencies between my file_contexts and my startup
> scripts, or something.

It appears that the init process isn't transitioning from the init_t
domain to the initrc_t domain when it starts running your startup scripts.
Hence, the rest of your processes are probably in the wrong domains as
well, as should be evident in the ps -e --context output.  It looks like
you need to add the following entry to your file_contexts file:
/etc/init.d/boot system_u:object_r:initrc_exec_t

I see that you have an /etc/rc.d/boot entry in your file_contexts file.
Is that supposed to be /etc/init.d/boot?

After you fix this and the rest of your processes are put into the
correct domains, you'll likely find that you need other customization
to the policy for your system.

> The modified ps and ls utilities work - I've not tried any others yet. X
> and Gnome are working; I'm not yet networked - I'm using a laptop for
> this experiment. Everything seems to be chugging away quite happily...
> Now I'd better read the manual :-)

Unfortunately, there isn't really any kind of "user manual" yet.
Make sure that each system daemon is in a separate domain, as mentioned in
the README.  Also, please note that the module is built as a development
module by default and is initially in permissive mode, as also discussed
in the README.  You'll need to check your dmesg output or
/var/log/messages file to see what other permissions must be added to the
policy for your system.

With regard to X, make sure that your current configuration is not set
up to run an X Display Manager (xdm, gdm, kdm).  The default runlevel
specified in /etc/inittab should be runlevel 3 (Full multiuser mode), not
runlevel 5 (X11).  We have not yet modified xdm/gdm/kdm and their helper
programs to set the security context for the user session.  Consequently,
you should not enable an X Display Manager when running SELinux.  A
SELinux user, Mark Westerman, has created a modified gdm and put it on
his sourceforge selinux project site, but we haven't tested it yet.

We have defined domains for the X server, and we have successfully run X
via startx after a normal login.  However, these domains require certain
permissions that are highly privileged.  The X server still requires study
to determine how to support it in a secure fashion.  To run X, you will
need to uncomment the allow statements preceded by comment lines that say
'# Commented out by default' in the policy/domains/program/xserver.te file
prior to building and installing the policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
