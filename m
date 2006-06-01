Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <14858.1149164860@warthog.cambridge.redhat.com>
References: <1149161971.524.283.camel@moss-spartans.epoch.ncsc.mil>
	 <1149097853.2517.0.camel@moss-tarheels.epoch.ncsc.mil>
	 <11225.1149156553@warthog.cambridge.redhat.com>
	 <14858.1149164860@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 10:21:35 -0400
Message-Id: <1149171695.524.360.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-01 at 13:27 +0100, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > Why do you want unlinkable keys anyway?
> > 
> > The concern is that any process that requires write access to the
> > keyring for any reason would otherwise be able to unlink all keys from
> > it, irrespective of what may have created the link in the first place.
> 
> Yes.
> 
> > The individual links in a single keyring could have been created by
> > processes in different security contexts, as a single user session can
> > have processes running in multiple security contexts.
> 
> Hmmm... I think it's incorrect to have an unlink permission bit on the key as
> it causes too many potential problems, and would apply to all the links on a
> key, irrespective of the keyrings holding them.
> 
> Perhaps what's required is to have unlink permission controlled from the
> keyring's perspective.  How about adding another security op that takes the
> keyring, the key and the requesting process, and asks if that process may
> detach that key from that keyring.  Clearing a keyring would then be a filter
> operation.
> 
> There are still a couple of problems to deal with:
> 
>  (1) Key displacement.  How do you deal with a new link that's being made
>      displacing an old link that would otherwise be refused unlink permission?
>      It might be sufficient to do the check in advance and assume that things
>      won't then change whilst we create a new key, except that there's a race
>      between two processes both trying to displace the same link in the same
>      keyring.
> 
>      The alternative for new key addition is to do the check at the point of
>      link creation, and just accept that we'll not create a link if we can't
>      displace the old key.
> 
>      It would also be possible to store a bit of information with each pointer
>      in the keyring if that would be useful.  The problem with caching can
>      you/can't you data in the keyring is that it very much depends on who's
>      asking.
> 
>  (2) Permission percolation over keyrings.  What do you do about a keyring
>      that contains a key that you're not permitted to unlink?  Does the
>      keyring itself become unlinkable?  What about session keyrings?
> 
> > Having a per-key unlink check parallels the existing checking on the link
> > side.
> 
> I'm not sure they are exactly parallel: having a link check doesn't cause all
> the problems that having an unlink check does.
> 
> > And unlinking a key can lead to its destruction (if it is the last link),
> > right, so it has a potentially modifying impact on the key itself?
> 
> Yes, but you have to be able to live with that, otherwise the kernel might
> fill up with obsolete keys.  If a filesystem or some other kernel service is
> using a key, it should keep its own link to that key.

Ok, given these considerations, I think we should just drop the unlink
check for now, and proceed with the rest of the patch (modulo
CodingStyle issues).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
