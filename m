Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98IP8rT024263
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 14:25:09 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98INwBk017086
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 18:23:59 GMT
Date: Fri, 8 Oct 2004 19:36:01 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: fuse + setfilecon - need some userspace / libselinux1 assistance
Message-ID: <20041008183601.GR5551@lkcl.net>
References: <20040928140351.GA12119@lkcl.net> <1097258612.16641.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1097258612.16641.227.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

stephen, hi,

i must apologise because a lot of this is out-of-date: i managed to at
least get something working, even if it's badly hacked together with
sellotape.

the one outstanding question that _is_ still relevant is the
one about security/selinux/hooks.c treating a vfs's "-512"
error code response [please try later] as an error.

why, well just in case some other [more mainstream] filesystem
e.g. a selinuxed version of nfs does the same sort of thing
[responds to a vfs_xxxx() call or a vfs_getxattr() call with
-512 and actually expects hooks.c _to_ try later]

l.

On Fri, Oct 08, 2004 at 02:03:32PM -0400, Stephen Smalley wrote:

> On Tue, 2004-09-28 at 10:03, Luke Kenneth Casson Leighton wrote:
> > why?  well, because a setxattr("security.selinux", <somegarbage>)
> > operation is performed!
> > 
> > as i found out, that is banned, esp. as the userspace program is run as
> > getfsuid() to the user.
> 
> Sorry, do you mean that you ran into DAC denials due to lack of search
> permission to the necessary directories?  setxattr itself doesn't impose
> any uid-based restrictions on security.selinux; that is all controlled
> based on security contexts.
> 
> > consequently, i looked around and found the util "setfilecon" which uses
> > setfilecon().
> 
> setfilecon(path, context) just calls setxattr(path, security.selinux,
> context, len, 0).  Nothing magic there.
> > 
> > to my surprise, i found that the argv[] arguments were simply ...
> > typecast from a char* to a security_context_t.
> > 
> > surely... that's rather unexpected behaviour that could, in the
> > future, break applications?
> 
> The fact that security contexts are strings is fairly established.  We
> do need to introduce a level of indirection in translation for human
> consumption for proper MLS support, unfortunately.
> 
> > will the setfilecon operation occur _as_ the user specified under the
> > setfsuid() uid?
> > 
> > or will the setfilecon operation be actioned as root?
> > 
> > i believe it to be really important that the answer is
> > "the setfilecon() is done as the setfsuid() uid"!
> 
> As far as the path lookup is concerned, the usual DAC restrictions are
> applied, and are based on fsuid as usual.  But the setting of the
> security context is not uid-based at all.
> 
> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
