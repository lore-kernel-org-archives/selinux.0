Date: Thu, 20 Dec 2001 10:46:59 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Noah silva <nsilva@atari-source.com>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: Debian SE Linux ?
In-Reply-To: <Pine.LNX.4.21.0112201030220.27491-100000@sparcy.internal.lan>
Message-ID: <Pine.GSO.4.33.0112201041530.16420-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 20 Dec 2001, Noah silva wrote:

> I was going to ask exactly how you toggle the enforcement with the debug
> options.  (I am sure it is in the FAQ somewhere, and I am just blind
> though.).

Just for future reference, this is discussed in step 19 of the README and
in the help text (from the make menuconfig) for the Development option.
When built with the Development option, the SELinux module starts in
permissive mode and can be toggled into enforcing mode using the
avc_toggle program.  But be sure that the policy configuration is
sufficient for your system to continue operating before toggling into
enforcing mode.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
