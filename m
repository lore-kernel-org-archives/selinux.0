Subject: Re: determining security level domination
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matt Anderson <mra@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4491FBE5.10902@hp.com>
References: <4491FBE5.10902@hp.com>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 08:12:44 -0400
Message-Id: <1150459964.18071.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-15 at 20:31 -0400, Matt Anderson wrote:
> I'm working on lpq and I need to determine if a user can see a job in
> the queue.  By this time the user's context is known, and all the jobs
> in the queue have a context associated with them.
> 
> It seems like avc_has_perm_noaudit() is close to what I need, but I'm
> not sure.  The main problem I see with that is avc_has_perm may fail
> based on user, role, or type, which I don't think I'm concerned with.
> Conceivably I could get around this by mangling one of the contexts so
> that I was only comparing levels and categories, but that doesn't sound
> like a good idea at all.
> 
> Is there some function I've missed that does something like this?

The goal in SELinux is to abstract away the specific security model
behind general interfaces so that the model can change without needing
to modify all of the enforcement code and so that we can support
composite models like TE+MLS.  Hence, we'd prefer to abstract away a
traditional dominance check to instead be a SELinux permission check on
the context pair.  Then we can also apply TE controls as desired, as we
might actually want to prevent a user in one domain from seeing jobs in
another domain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
