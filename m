Subject: Re: Avc denies while running in Permissive mode...
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Hasan Rezaul-CHR010 <CHR010@motorola.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <1229535751.31499.22.camel@localhost.localdomain>
References: <1228865476.3737.13.camel@localhost.localdomain>
	 <1228916038.23307.1.camel@localhost.localdomain>
	 <D06FE0A2807BC145B0D38744789D4F5D051775A7@de01exm68.ds.mot.com>
	 <1229535751.31499.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 17 Dec 2008 13:00:04 -0500
Message-Id: <1229536804.3384.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-12-17 at 12:42 -0500, Stephen Smalley wrote:
> On Wed, 2008-12-17 at 12:08 -0500, Hasan Rezaul-CHR010 wrote:
> > Hi All,
> > 
> > Lets just say in my product, we are not confident enough to run in
> > Enforcing mode just yet !
> > 
> > I used Fedora Core 7 *strict* policy as my base policy, and built my own
> > additional myModule.pp policies on top of that. So, I have *strict*
> > SELinux policy running on an embedded Linux Card, in Permissive mode.
> > 
> > Due to auto-relabelling of the filesystem, files in the  /etc/
> > directory get appropriately labelled as  etc_t (as desired).
> > 
> > I have myModule.pp policy lines that say :
> > 
> > neverallow user_t etc_t:file write;
> > neverallow user_t etc_t:dir write;
> > 
> > My question is:
> > 
> > When I ssh in as a test user with a security context =
> > [user_u:user_r:user_t], and I attempt to modify/write some file in the
> > /etc/  directory,  I do get an avc deny message in the audit.log file,
> > as desired  :-)
> > 
> > But subsequent attempts to do the same thing doesn't generate any more
> > avc denies ??? In other words, when I attempt to modify the same file
> > again, or modify a different file under /etc/  as the same test user...
> > I DON'T get any more avc deny messages ?!?
> > 
> > I know that if I switch from Permissive to Enforcing mode, I get avc
> > deny msgs for EVERY single violation !
> > 
> > But in Permissive mode, I would like to also get a deny for every
> > violation attempt.. How do I achieve this ?
> > 
> > Because I am running with *strict* policy, during normal operation of my
> > Linux card, I have numerous avc deny messages that pop up from time to
> > time. So I collect all those deny messages, run audit2allow on them, and
> > try to eliminate these denies in the policy.  
> > 
> > But what confuses me is that, there are some avc denies that seem to be
> > about the same operation, and those avc denies keep popping up
> > repeatedly in the Permissive mode... Why then cant the scenario
> > described above produce repeated avc denies ???
> > 
> > I understand that there is a mechanism to prevent flooding of avc denies
> > in Permissive mode. And I did try to change the
> > /selinux/avc/cache_threshold file, by putting a "1" there instead of
> > "512". But doing that causes a lot of CPU to be chewed up by SELinux.   
> > 
> > Any other suggestions for why the scenario I described above, about a
> > test user (user_t), trying to modify multiple files under the /etc/
> > directory creates only one avc deny message, and doesn't generate an avc
> > deny for each attempt ???
> > 
> > Apologize for the long mail. Thanks in advance for your help,
> 
> In permissive mode, when a permission would be denied for a given
> (source context, target context, target class) triple for the first
> time, the kernel audits the denial (avc:  denied) and then adds that
> permission to the allowed vector for that triple in the AVC (access
> vector cache).  Thus, subsequent uses of that same permission on that
> same triple will not trigger further denials until the cache entry is
> evicted from the cache (which can happen automatically if we need to
> free up space for use by other entries or explicitly upon either a
> policy reload or changing a policy boolean).
> 
> So you might for example see avc denials with different permissions on
> the same triple or avc denials with the same permission on different
> triples.  You may also see avc denials with the same permission and the
> same triple across a period of time if the cache entry was evicted in
> between the two avc denials.
> 
> In terms of getting the behavior you want (i.e. see all instances of an
> avc denial), you really only have these choices without modifying code:
> 1) use enforcing mode, or
> 2) set the cache threshold to 1
> 
> Or you could modify the kernel for your development purposes.  It would
> be a pretty trivial patch.  What's your base kernel version?

I also think you could get something like the notification you want
using an audit rule sorta like

auditctl -a exit,always -S write -F subj_type=user_t obj_type=etc_t

again, it's not an AVC denial, but it will tell you ever time the
operation happened....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
