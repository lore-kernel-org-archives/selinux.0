Date: Wed, 19 Dec 2001 13:34:21 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Noah silva <nsilva@atari-source.com>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: Debian SE Linux ?
In-Reply-To: <Pine.LNX.4.21.0112191302320.26475-100000@sparcy.internal.lan>
Message-ID: <Pine.GSO.4.33.0112191314530.5056-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> looking back on the list, I saw some people have discussed using Debian
> Linux with the SELinux patch.  I was wondering if that ever came to
> anything other than talk.  I am currently working on setting up a test
> machine with Debian Testing (on x86) and SE Linux.  (ATM, I am still
> sorting out ext3 + initrd... can't believe there isn't a cleaner
> solution).

Russell Coker has a Debian kernel-patch package for SELinux at
http://www.coker.com.au/selinux.  I don't know whether the Debian folks
have made any progress with the daemon and utility patches or the example
policy configuration.  I'm not sure what you mean when you say
"I am still sorting out ext3 + initrd."  The current release of SELinux
works fine with ext3 - we were just waiting for ext3 to be merged into the
mainstream kernel, and it is present in the 2.4.16 kernel.  As far as
initrd is concerned, you can probably make it work if you really need it.
I think you just need to create an initrd image that includes a copy of the
compiled policy configuration so that it is available.

> Looking at the way SELinux works, I assume I will have at least to alter
> the policies because of the differences in paths?

You will need to adapt the daemon and utility patches to the corresponding
Debian packages, although only a few of these patches are critical (login,
sshd, crond).  You will have to customize setfiles/file_contexts for your
filesystem layout.  If you build with NSA SELinux Development Module
option, then you can run your system in permissive mode for a while to
collect audit messages, and can then work on customizing the policy
configuration based on those audit messages, possibly using Justin Smith's
perl script.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
