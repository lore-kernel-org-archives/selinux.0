Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <11225.1149156553@warthog.cambridge.redhat.com>
References: <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil>
	 <11225.1149156553@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 07:39:31 -0400
Message-Id: <1149161971.524.283.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-01 at 11:09 +0100, David Howells wrote:
> It isn't as trivial as you think.  Unlink is implied by several operations you
> haven't altered: link, add key, request key, clear keyring and search keyring.
> This is because you can displace a key link from a keyring by adding a link to
> another key of matching type and description.
> 
> > If any of you decide it should be split off into some other patch, I'd be
> > glad to remove it.
> 
> It certainly needs be split off into its own patch as it's a fairly major
> change.  Your changes in this area are also incomplete.
> 
> I also don't really want unlinkable keys for a number of reasons:
> 
>  (1) You can't get rid of them when they're dead (unless you allow a specific
>      bypass).
> 
>  (2) If they're your keys, they eat your quota and but you may not be able to
>      ditch them.
> 
>  (3) If someone accidentally zeroes the mask on the key, they're left with a
>      key that they can't get rid of.
> 
>  (4) What are the semantics of dealing with a keyring that has a link to an
>      unlinkable key within it?  Does the keyring become automatically
>      unlinkable too?
> 
>  (5) How do we deal with an unlinkable session keyring?  Should this prevent
>      someone joining a new session?  And should this affect all their heirs
>      also?
> 
> I feel that unlinkability really should apply to the link to a key, not to the
> key itself if we have it at all.
> 
> Why do you want unlinkable keys anyway?

The concern is that any process that requires write access to the
keyring for any reason would otherwise be able to unlink all keys from
it, irrespective of what may have created the link in the first place.
The individual links in a single keyring could have been created by
processes in different security contexts, as a single user session can
have processes running in multiple security contexts.  Having a per-key
unlink check parallels the existing checking on the link side.  And 
unlinking a key can lead to its destruction (if it is the last link),
right, so it has a potentially modifying impact on the key itself?
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
