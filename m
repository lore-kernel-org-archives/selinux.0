Message-ID: <50A29C78.2050404@tycho.nsa.gov>
Date: Tue, 13 Nov 2012 14:16:08 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org,
        debian-dpkg@lists.debian.org
Subject: Re: Possible issues with dpkg SELinux support
References: <20121108082623.GA5059@gaara.hadrons.org> <CAB9W1A3cVVSj-PbM73c+vePHt7fVGf8117OXmTrDPf0K0vyYGg@mail.gmail.com> <20121110031932.GA6217@gaara.hadrons.org>
In-Reply-To: <20121110031932.GA6217@gaara.hadrons.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/09/2012 10:19 PM, Guillem Jover wrote:
> Is the "<<none>>" check needed at all? This has bothered me for a
> while, and it's not clear if calling lsetfilecon_raw() with that would
> DTRT, or if selabel_lookup_raw() would never return that to start with.

As you already saw, this check is no longer necessary.

> Should the code be handling selinux_status_updated(), and reopening
> the selabel_handle in such case? If so, how often, per extracted file,
> per package processed (probably this usually happens only after
> upgrading the refpolicy package?), some other time(s)?

I believe rpm does selinux_status_open() at the beginning of the 
transaction and selinux_status_close() at the end of the transaction, 
and during the transaction, checks selinux_status_updated() once per 
package processed to see whether it needs to re-open the selabel handle. 
  This ensures that rpm gets a fresh view of file_contexts if it is 
modified during the transaction by a semodule or semanage command.

> Should the code be ignoring some other SELinux errors or considering
> them warnings when running in non-enforcing mode, or is that already
> handled internally by the SELinux interfaces?

This should generally be done within libselinux rather than in the caller.

> Is ignoring errors from lsetfilecon_raw() enough of a grave issue as
> to warrant a stable dpkg update (can it create security issues, or just
> wrongful or too restrictive unpacks)? (I'd be preparing updates for the
> current Debian stable and the just-being-prepared-stable releases in
> such case.)

It could be a security issue, although obviously no current Debian 
SELinux users were relying on it.

> Also Elena's proposed plugin system did not seem to be directly related
> to SELinux, so I've ended adapting rpm_execcon() almost verbatim to the
> dpkg case. But something that came to mind is if you think it would make
> sense to refactor that function (I've read it's supposed to disappear
> anyway) into something slightly more generic so that it could be used by
> at least both rpm and dpkg (and possibly other package managers or even
> programs invoking helper programs). Something ressembling the adaptation
> that I've made in the attached patch, but in addition passing to it (at
> least) the fallback context type, it could perhaps have a signature
> similar to something like:
>
>    int setexecfilecon(const char *filename, const char *fallback_type);
>
> and be called like:
>
>    rc = setexecfilecon(path, "dpkg_script_t");
>    ...
>    rc = execve(path, argv, envp);
>
> ?

That seems reasonable, except that we'd ideally like to get rid of the 
hardcoded type altogether and get it from a configuration, preferably 
supplied by the policy.  But the problem of course is what to do  before 
the policy package is installed.

> If the attached patch looks fine in principle, I'd ask the Debian
> SELinux folks for some testing (as I've only build tested it), and if
> they need to somehow adapt the Debian SELinux refpolicy.

Looks mostly correct to me, but the error check for lsetfilecon_raw() 
should be:
	if (ret < 0 && errno != EOPNOTSUPP)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
