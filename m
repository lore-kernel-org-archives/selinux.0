Subject: Re: [Fwd: type class key]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Stefan Schulze Frielinghaus <stefan@seekline.net>, selinux@tycho.nsa.gov
In-Reply-To: <22421.1194637689@redhat.com>
References: <1194628263.3630.14.camel@vogon>
	 <1194554589.3198.24.camel@moss-spartans.epoch.ncsc.mil>
	 <24708.1194612682@redhat.com>  <22421.1194637689@redhat.com>
Content-Type: text/plain
Date: Fri, 09 Nov 2007 14:51:37 -0500
Message-Id: <1194637897.624.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-09 at 19:48 +0000, David Howells wrote:
> Okay, it looks like it's probably the problem I'm thinking of.  If it is, I
> need to think carefully about how to deal with it.
> 
> Stephen: Would it be possible for me to create the per-UID keyring without
> reference to the security label of the current process?
> 
> The other alternative is to accept that if the label can't be linked because
> of a security label disagreement than that's that, and we don't give an error.
> 
> I don't like that second option, though, because that can seriously limit the
> utility of the per-UID keyring by it being a lottery as to what label it gets
> created with - basically who gets to try creating it first.
> 
> Any suggestions?

(taking discussion back on list)

We already provide a way to create a key with a specified label other
than the current process, via setkeycreatecon(3) aka writing the label
to /proc/self/attr/keycreate before allocating the key.

So why can't the userland code that is allocating these per-uid keyrings
use that interface to set the context appropriately for the actual user
rather than defaulting to its own context?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
