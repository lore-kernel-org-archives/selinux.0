Subject: Re: [patch] reducing size of libselnux/libsepol for embedded
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp
In-Reply-To: <461A32E0.6020102@manicmethod.com>
References: <20070409135030.d27a3177.ynakam@hitachisoft.jp>
	 <461A32E0.6020102@manicmethod.com>
Content-Type: text/plain
Date: Mon, 09 Apr 2007 10:44:41 -0400
Message-Id: <1176129881.15415.95.camel@moss-spartans.epoch.ncsc.mil>
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

Agreed.  Look to the newrole Makefile for an example, where they defined
AUDIT_LOG_PRIV and NAMESPACE_PRIV flags for enabling/disabling specific
features, and then defined a LSPP_PRIV flag that turned them both on.
Thus, you can create AVC=y/n, BOOLEAN=y/n flags for individual feature
selection, and then define EMBEDDED as turning them all off.

This also avoids confusion, as your DISABLE_SEPOL flag turns off
booleans.c presently, but booleans.c doesn't appear to depend on
libsepol.

Other comments:
- I think you can simplify your src/load_policy.c changes, as you only
ever need to define one version of the function (we don't need the
_nosepol static function around at all when using libsepol).  So it just
becomes something like:
#ifdef USE_SEPOL
int selinux_mkload_policy(int preservebools)
{
<your logic>
}
#else
int selinux_mkload_policy(int preservebools)
{
<original logic>
}
#endif
- Your logic for the nosepol case doesn't actually include the policy
version in the pathname at all.  An oversight?
- You don't munmap the policy file on the exit path.
- Coding Style for functions puts the opening bracket on its own line.
- Avoid #ifdefs within function bodies.  Obsoleted if you take the
approach above.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
