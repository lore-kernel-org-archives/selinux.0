Subject: Re: RFE: inheritance
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1109400342.4581.25.camel@cobra.ivg2.net>
References: <1109400342.4581.25.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 14:16:07 -0500
Message-Id: <1109618167.28470.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-02-26 at 01:45 -0500, Ivan Gyurdiev wrote:
> The Java problem is not solved yet.
> The problem is that:
> - Java needs its own domain due to legacy requirements
> - Java should get all the permissions granted to user_t, since
> it's a programming language, not an application to be confined.
> - Calling base_user_macro($1_java_t) will not work IMHO.

At least for java and other legacy binaries, this issue should be
handled by the kernel change I've proposed.  I have a final form of the
patch ready for submission post 2.6.11.  It will prevent SELinux from
checking execmem and file execute when execute permission was not
directly requested by the application and is only being added by the
read-implies-exec logic in the kernel.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
