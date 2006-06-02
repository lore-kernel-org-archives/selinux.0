From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149255931.7506.13.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1149255931.7506.13.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        dhowells@redhat.com
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Fri, 02 Jun 2006 15:10:34 +0100
Message-ID: <17826.1149257434@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> Introduce SELinux hooks to support the access key retention subsystem
> within the kernel.  Incorporate new flask headers from a modified
> version of the SELinux reference policy, with support for the new
> security class representing retained keys.  Extend the "key_alloc"
> security hook with a task parameter representing the intended
> ownership context for the key being allocated.  Attach security
> information to root's default keyrings within the SELinux
> initialization routine.
> 
> Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

I've thrown my testsuite at it and that seems to work still:

	http://people.redhat.com/~dhowells/keyutils/keyutils-tests.tar.bz2


Signed-Off-By: David Howells <dhowells@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
