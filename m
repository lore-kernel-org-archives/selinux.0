Message-Id: <1493240908.1837173.957437120.416E6DD8@webmail.messagingengine.com>
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Date: Wed, 26 Apr 2017 17:08:28 -0400
Subject: Re: is_selinux_enabled() always returns 0 after
 selinux_set_policy_root()
In-Reply-To: <1493239388.1829342.957407608.3C297B30@webmail.messagingengine.com>
References: <1493237420.1820719.957368808.08E54C5A@webmail.messagingengine.com>
 <1493238298.32540.13.camel@tycho.nsa.gov>
 <1493239388.1829342.957407608.3C297B30@webmail.messagingengine.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On Wed, Apr 26, 2017, at 04:43 PM, Colin Walters wrote:
> On Wed, Apr 26, 2017, at 04:24 PM, Stephen Smalley wrote:
> >
> > Your analysis and proposed fix sound correct to me.  I blame Dan ;)
> 
> Thanks.  I tested the patch and confirmed it fixed ostree as it stands today,
> but I'm going to change ostree to cache the result of `is_selinux_enabled()`
> itself to work around this, since for our use cases it should never really
> change dynamically.

Although as I was working on the workaround, which I just put up as:
https://github.com/ostreedev/ostree/pull/815

I was thinking about this a bit more and I realized (maybe) why
Dan added that call.  

Right now (ignoring #ifdef ANDROID):
int is_selinux_enabled()
{
return (selinux_mnt && has_selinux_config);
}

And conceptually "has_selinux_config" derives from the policy root.
But in practice it doesn't today - that variable is also only initialized
in the constructor.   Should it?  I'm not sure.

The way libostree uses the policy root is basically for the regexp labeling
database.   We're using `is_selinux_enabled()` to determine whether
or not we should call `setfscreatecon()`. 

Eh.  My inclination is not think too much more about this.  The patch
is unlikely to break anything, it does fix a bug, and I'm not aware of a
case where someone would be using e.g. a host system with SELinux
fully disabled to do anything related to ostree, so we don't
need to care about trying to disentangle those cases.  Hopefully!
