Date: Thu, 26 Aug 2004 10:07:45 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Justin Friel <capn_shoe@yahoo.com>, <SELinux@tycho.nsa.gov>
Subject: Re: Trouble building Policy-1.16
In-Reply-To: <1093524996.9280.77.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0408261004500.2542-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 26 Aug 2004, Stephen Smalley wrote:

> Rather than treating an entire ipv6 address as a single token, we could
> just scan the hexval components and separating colons as individual
> tokens and define ipv6 address in the grammar, as we do with
> ipv4_addr_def.  That would seem safer.

Well, you need to interpret embedded ipv4 addresses at the end, implied 
runs of zeroes etc.  Parsing as one token and feeding into inet_pton() is 
much simpler, and uses an existing, well tested library function for 
validation.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
