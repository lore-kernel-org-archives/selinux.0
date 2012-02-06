Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q16EoUii023067
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2012 09:50:30 -0500
Subject: Re: SE Android release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1325884109.28294.65.camel@moss-pluto>
References: <1325884109.28294.65.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 06 Feb 2012 09:50:30 -0500
Message-ID: <1328539830.9705.49.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-01-06 at 16:08 -0500, Stephen Smalley wrote:
> Hi,
> 
> We have made an initial public release of SE Android. More information
> is available at:
> http://selinuxproject.org/page/SEAndroid

We have updated the source code repositories.  A repo sync -j1 will
refresh your copy of the source code if you already have a copy.  The
changes are:

- The Settings app can now be used to manage the SELinux enforcing
status and policy booleans (under Security options).  Changes made via
the Settings app are not yet saved and restored across reboot; this is
work in progress.  The ability of the Settings app to manage SELinux can
be controlled via a new settings_manage_selinux policy boolean. 

- The JNI bindings for the SELinux APIs have been extended to support
the new Settings functionality.   They have also been reworked to ensure
that the framework services and apps can safely call the SELinux APIs
even when SELinux is disabled.

- Support for -R has been added to the init chown built-in command so
that ownership can be set on all SELinux booleans in selinuxfs to permit
management by the Settings app (which runs in the system UID).  The
init.rc file has been modified to apply this ownership change at boot.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
