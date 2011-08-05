From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy is broken (which is not)
Date: Sat, 6 Aug 2011 01:30:49 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>
References: <4E3AEA75.3090602@redhat.com> <1312550851.19283.35.camel@moss-pluto> <4E3C0152.7000105@redhat.com>
In-Reply-To: <4E3C0152.7000105@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201108060130.49464.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 6 Aug 2011, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > So are you saying that you are fine with a newer checkpolicy not
> > accepting previously valid policy modules?  Such that someone who
> > wants to upgrade checkpolicy in an existing distribution release
> > (e.g. RHEL6) can only do so if they also upgrade/modify their
> > policy?
> 
> This is a theoretical about something we would never do.  RHEL Releases
> are stable and we don't update tool chains, just bug fix.  Maybe third
> parties would and then it would be up 2 them to fix their policies.

For Debian I want to provide forwards and backwards compatibility as much as 
possible.  Even in situations where I won't support a combination of policy 
and user-space I would like it to not be too difficult for people who want to 
do different things (as some RHEL and CentOS users are apparently doing).

I think that the ideal situation for a Debian upgrade (which can and usually 
is done in stages unlike a RHEL upgrade) is to support either the old policy 
with new user-space or the new policy with the old user-space.  Ideally this 
would also include the ability to rebuild the policy packages from source.

In regard to the "role httpd_t types httpd_t;" corner case, aren't there a 
heap of other corner cases where someone can accidentally write policy that 
doesn't do what they expect?

What about the macros for things like r_file_perms?  How long are we going to 
keep that around?  We've already had a couple of releases with the new 
version.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
