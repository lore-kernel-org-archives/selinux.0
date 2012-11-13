Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qADKEYDP026320
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2012 15:14:34 -0500
Date: Tue, 13 Nov 2012 21:13:53 +0100
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Cc: selinux-devel@lists.alioth.debian.org, debian-dpkg@lists.debian.org
Subject: Re: Possible issues with dpkg SELinux support
Message-ID: <20121113201353.GA4202@gaara.hadrons.org>
References: <20121108082623.GA5059@gaara.hadrons.org>
 <CAB9W1A3cVVSj-PbM73c+vePHt7fVGf8117OXmTrDPf0K0vyYGg@mail.gmail.com>
 <20121110031932.GA6217@gaara.hadrons.org>
 <50A29C78.2050404@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <50A29C78.2050404@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-11-13 at 14:16:08 -0500, Stephen Smalley wrote:
> On 11/09/2012 10:19 PM, Guillem Jover wrote:
> >Should the code be handling selinux_status_updated(), and reopening
> >the selabel_handle in such case? If so, how often, per extracted file,
> >per package processed (probably this usually happens only after
> >upgrading the refpolicy package?), some other time(s)?
> 
> I believe rpm does selinux_status_open() at the beginning of the
> transaction and selinux_status_close() at the end of the
> transaction, and during the transaction, checks
> selinux_status_updated() once per package processed to see whether
> it needs to re-open the selabel handle.  This ensures that rpm gets
> a fresh view of file_contexts if it is modified during the
> transaction by a semodule or semanage command.

Ok, I'll handle this in the code then.

> >Is ignoring errors from lsetfilecon_raw() enough of a grave issue as
> >to warrant a stable dpkg update (can it create security issues, or just
> >wrongful or too restrictive unpacks)? (I'd be preparing updates for the
> >current Debian stable and the just-being-prepared-stable releases in
> >such case.)
> 
> It could be a security issue, although obviously no current Debian
> SELinux users were relying on it.

Right, but I'd assume the users might just not know this could happen,
so as this might be a security issue, I think I'll be preparing those
updates.

> >Also Elena's proposed plugin system did not seem to be directly related
> >to SELinux, so I've ended adapting rpm_execcon() almost verbatim to the
> >dpkg case. But something that came to mind is if you think it would make
> >sense to refactor that function (I've read it's supposed to disappear
> >anyway) into something slightly more generic so that it could be used by
> >at least both rpm and dpkg (and possibly other package managers or even
> >programs invoking helper programs). Something ressembling the adaptation
> >that I've made in the attached patch, but in addition passing to it (at
> >least) the fallback context type, it could perhaps have a signature
> >similar to something like:
> >
> >   int setexecfilecon(const char *filename, const char *fallback_type);
> >
> >and be called like:
> >
> >   rc = setexecfilecon(path, "dpkg_script_t");
> >   ...
> >   rc = execve(path, argv, envp);
> >
> >?
> 
> That seems reasonable, except that we'd ideally like to get rid of
> the hardcoded type altogether and get it from a configuration,
> preferably supplied by the policy.  But the problem of course is
> what to do  before the policy package is installed.

And the type would be applied based on the filename? That makes sense,
but what about scripts stored on a db that need to be written into
temporary files before executing them (as I think rpm is doing right
now)? And the pre-policy bootstrapping problem is tricky indeed. So
while the hardcoded type might not be pretty, it's at least hardcoded
on the caller, which seems better than on the function itself. :)
Any better ideas?

> >If the attached patch looks fine in principle, I'd ask the Debian
> >SELinux folks for some testing (as I've only build tested it), and if
> >they need to somehow adapt the Debian SELinux refpolicy.
> 
> Looks mostly correct to me, but the error check for
> lsetfilecon_raw() should be:
> 	if (ret < 0 && errno != EOPNOTSUPP)

Hmm, I got the ENOTSUP error from the lsetfilecon(3) man page, also
that's the error code that makes sense given its description of “not
supported”, while EOPNOTSUPP is “operation not supported on socket”,
although on Linux it does not make a difference as they are aliased
to the same value. In any case checking now the code it seems it's
implemented in means of lsetxattr(2) which is also documented as
returning ENOTSUP. Grepping though the libselinux code there's the
*getfilecon functions which seems to be setting EOPNOTSUPP, maybe
that's why you mentioned it? It might be a good idea to change those
to ENOTSUP, if only for pedantry? :)

And thanks for the answers and review.

regards,
guillem


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
