Date: Wed, 27 Jun 2001 10:15:01 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Ward, Robert D" <robert.d.ward@lmco.com>
cc: SELinux@tycho.nsa.gov
Subject: RE: Slackware
In-Reply-To: <B1B0DD19298CD41195A600508BF9067A02C14F24@emss04m08.ems.lmco.com>
Message-ID: <Pine.SOL.3.95.1010627100253.7280O-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 27 Jun 2001, Ward, Robert D wrote:

> I am running Slackware 7.0 with SE Linux on a home PC.  It seems to be
> working fairly well, but I did have some difficulties on the installation as
> described below.  If you have any specific questions I would be happy to
> help.  Please bear in mind that my experience level is "enthusiastic
> amateur", so I haven't really tried anything too challenging on the system.

Are you running SELinux in enforcing mode?  Did you customize the
policy configuration for the Slackware environment?  The example policy
configuration and file_contexts configuration was based on RedHat,
so I would expect you to have to make a number of changes for other
distributions.

> I still have problems getting the tools to install, but that should work for
> the kernel.  When you do a uname -a after finishing, it should show the
> FLASK kernel.  Hope this helps.

Which tools/utilities caused problems for you?  Were you able to
install the modified login program and modified crond program?
Since Slackware may have its own patched versions of these programs,
you should be careful about blindly replacing the Slackware versions.
Those are the most important modified applications, since they
are needed in order to properly set the security contexts on
user processes and cron jobs.  The other modified applications
are less important, although useful.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
