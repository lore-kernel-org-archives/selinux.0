Subject: Re: [redhat-lspp] libselinux get_default_context not working?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Wightman, Reid K Civ AFRL/IFEB" <Reid.Wightman@rl.af.mil>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <43055FDD054D464FA7923D0FFAF2C9C70291F7C2@fsjrez02.adm.rl.af.mil>
References: 
	 <43055FDD054D464FA7923D0FFAF2C9C70291F7C2@fsjrez02.adm.rl.af.mil>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 10:22:26 -0400
Message-Id: <1151590946.6999.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-28 at 16:07 -0400, Wightman, Reid K Civ AFRL/IFEB wrote:
> I'm playing with the refpolicy (20060307 from sourceforge...is there a
> redhat-blessed version of refpolicy w/source available?)

You can always grab the selinux-policy*.src.rpm from the Fedora download
server or mirrors, or check out selinux-policy from the public Fedora
CVS tree and generate a src rpm from it.

>  and am noticing
> some odd things in libselinux.  When calling get_default_context('user_u',
> NULL, &conref), the function eventually gets to get_context_list.c line 444
> where it tries to open /etc/selinux/refpolicy/contexts/users/user_u .  That
> file doesn't exist.  

That is ok - the per-user files are optional, and only necessary if you
want to use alternative defaults for a particular SELinux user than the
generic ones in default_contexts.  That support was used for the root
user at one time, to give him different defaults e.g. for console login.
Might be moot given the seusers mechanism these days for mapping Linux
users to SELinux users.

> I'm curious what the format of the file should be.

Same as default_contexts.

>   I don't see anything by
> the same name in the targeted or strict policies that come with FC5.  As it
> is, it eventually fails to order the reachable list it builds, so user_u is
> shown as having a default context of user_u:user_r:user_xserver_t, which
> probably isn't right, (it just happens to be the first entry on the
> reachable contexts list).  I'd think the default context for user_u in the
> default refpolicy would be user_u:user_r:user_t...

Under strict policy, yes, it would be user_u:user_r:user_t.  But
default_contexts is sufficient for that, and that appears to be working
on a strict policy system here.  Not sure what precisely you are
encountering - you didn't say why it fails.

> Would it be worthwhile for me to play with the Makefile to automatically
> generate some of these files?

No, they are only for local customization of particular SELinux users
defaults; they don't need to exist for operation, and it wouldn't make
sense to auto-generate them.

>   What stuff should the <user>_u files have in
> them?  Or shouldn't I be playing with refpolicy for policy analysis at this
> point (or, as above, is there a redhat version somewhere)?  I don't see a
> 'user_u' file in targeted o
> r strict policies, either, so I'd guess that this same sort of thing would
> happen in them?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
