From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        dhowells@redhat.com
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Thu, 01 Jun 2006 15:40:42 +0100
Message-ID: <22010.1149172842@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> I've tested this patch using all four combinations of SELinux
> enabled/disabled and keys enabled/disabled, so I'm fairly
> confident that it won't cause any breakage.

Whilst that may be true, you haven't updated the documentation, and so the
patch is incomplete on those grounds too.  See:

	Documentation/keys.txt

You would certainly need to document the Unlink permission, should that be
added in your patch.  You should probably add a section detailing how SE Linux
governs keys management also.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
