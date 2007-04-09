Subject: Re: [patch] reducing size of libselnux/libsepol for embedded
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <461A32E0.6020102@manicmethod.com>
References: <20070409135030.d27a3177.ynakam@hitachisoft.jp>
	 <461A32E0.6020102@manicmethod.com>
Content-Type: text/plain
Date: Mon, 09 Apr 2007 09:27:23 -0400
Message-Id: <1176125243.15415.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-09 at 08:34 -0400, Joshua Brindle wrote:
> Yuichi Nakamura wrote:
> > <snip>
> In the future could you please inline the patch?
> > 2. About patch
> > We prepare 2 build options in libselinux/libsepol.
> > 1) make EMBEDDED=1
> > This is for people who want to use only monolitic policy with boolean support.
> > * libselinux
> >   Files related to userland avc is not compiled
> > * libsepol
> >   libselinux uses sepol functions(such as sepol_genusers, sepol_genboolean). 
> >   If people do not need modular policy, we need only to compile such functions.
> >
> > 2) make DISABLE_SEPOL=1
> > This can be combined with "EMBEDDED=1".
> > This is for people who uses poor resource devices.
> > libsepol functions are removed from libselinux 
> > so libsepol can be removed.
> > By that, size of libse*  can be reduced more, 
> > but some features(such as boolean) can not be used.
> >
> >   
> I think the defines should be more descriptive, perhaps NO_AVC, NO_BOOL, 
> etc.
> 
> Is there ever a reason to use DISABLE_SEPOL without EMBEDDED? it seems 
> like you leave the option open but never describe why it would be used 
> or what the side effects would be.
> 
> > More detail:
> > * libselinux 
> >   - selinux_mk_loadpolicy is replaced with limited version:
> >      - policy filename is assumed as /etc/selinux/<policy type>/policy/policy.<version in selinuxfs>
> >   
> This won't reduce the code much, is there a reason that you don't try to 
> search for the policy file at all? Granted this shouldn't be an issue in 
> embedded environments since you should have control of the kernel and 
> policy at all times but it could be useful to load a policy of differing 
> version than the kernel supports.
> 
> OTOH this could be a good time to get rid of the .version convention 
> anyway, there is little reason for it anymore and it causes stale 
> policies to be left around when libsepol is upgraded.

The .version convention and the fallback code path in the (current)
selinux_mkload_policy() function is still useful as a way of handling
the case where the latest policy version cannot be downgraded to the
kernel-supported version.  If we were to ever make a non-backward
compatible change in the format or the flask definitions (e.g. major
rewrite of initial_sids, security_classes, and access_vectors to purge
obsolete definitions and optimize the layout), then we'd still want that
support.  I'm not sure we can definitively rule that out forever.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
