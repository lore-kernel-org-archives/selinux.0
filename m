From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0605311635470.7334@d.namei> 
References: <Pine.LNX.4.64.0605311635470.7334@d.namei>  <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil> 
To: James Morris <jmorris@namei.org>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        dhowells@redhat.com
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Thu, 01 Jun 2006 10:32:48 +0100
Message-ID: <10131.1149154368@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris <jmorris@namei.org> wrote:

> What's the difference between reading and viewing a key?

"Viewing" is looking at the key's attributes.  "Reading" is reading the
payload of the key.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
