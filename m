Date: Thu, 20 Dec 2001 09:44:04 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Noah silva <nsilva@atari-source.com>,
        SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: Debian SE Linux ?
In-Reply-To: <20011220114333.80B9616F59@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0112200911490.16420-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 20 Dec 2001, Russell Coker wrote:

> Having the policy on the initrd is painful.  I think that the best solution
> is to turn on the SE functionality after the root FS has been mounted (if
> they can crack your machine at initrd time you're pretty much stuffed
> anyway).  Stephen, I got the impression from a previous message that such
> delayed startup of SE functionality is possible with the
> CONFIG_SECURITY_SELINUX_DEVELOP option, but I haven't looked into that yet.

SELinux initially tries to load the security policy configuration when the
LSM post_mountroot hook is called after the root filesystem has been
mounted.  However, I think that if an initrd is used, this occurs when the
initrd is mounted as the initial root filesystem, so if the policy isn't
on the initrd, you have a problem.  But I haven't actually tried using an
initrd with SELinux for a long time, and it hasn't been a priority for us.

With the current SELinux release, the kernel will panic if it can't load
the policy configuration when the root filesystem is mounted, regardless
of whether the Development option is enabled.  I've started making some
changes to the SELinux initialization code that will permit a delayed load
if this initial load fails when the Development option is enabled, but
this change isn't in the current release.  If the initial load fails
while booting a development kernel, it is probably sufficient to defer
loading until the system is toggled into enforcing mode.  At that point,
if SELinux still can't load the policy, it should probably panic rather
than allowing the system to proceed in an insecure state.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
