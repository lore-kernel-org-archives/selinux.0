From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149100148.524.263.camel@moss-spartans.epoch.ncsc.mil> 
References: <1149100148.524.263.camel@moss-spartans.epoch.ncsc.mil>  <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov, dhowells@redhat.com
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Thu, 01 Jun 2006 11:13:52 +0100
Message-ID: <11317.1149156832@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> No change to the existing key permission bits, and plenty of room for them
> to grow still.

There's not all that much room.  There're only two bits, and one of them is
tentatively reserved for key cloning as requested by Kyle Moffett.

Key cloning involves breaking the key into two bits: a handle with security
and permissions info on it and the payload.  A key could then be "cloned" to
get a new handle upon which new permissions could be enscribed.  There are a
few problems with this: how do you manage quota and how do you deal with
joining session keyrings?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
