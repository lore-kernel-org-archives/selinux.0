Subject: Re: PythonSELinux binding problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: rarob@travelinglightfarm.net
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Eric Paris
 <eparis@redhat.com>, Steve Lawrence <slawrence@tresys.com>
In-Reply-To: <847d1fe893f5d55fda3cae11fb1c66df.squirrel@box559.bluehost.com>
References: <847d1fe893f5d55fda3cae11fb1c66df.squirrel@box559.bluehost.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 22 Jul 2011 09:44:53 -0400
Message-ID: <1311342293.20800.15.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-07-21 at 17:33 -0400, rarob@travelinglightfarm.net wrote:
> Hi,
>   I'm using the python selinux bindings to determine if SELinux is
> disable/permissive/enforcing.  The following snippet of code works just
> fine on RH5 and F10 regardless of the SELinux mode, but fails with an
> error on F11/12/13 and RH6 if SELinux is disabled.
> 
> $ python -c 'import selinux ; print selinux.security_getenforce()'
> 
> Under RH5 and F10 I correctly get the -1/0/1 returns for
> disabled/permissive/enforcing, as specified in the man pages for
> 'security_getenforce'.  Under F11/12/13 and RH6 for permissive and
> enforcing I get the correct return values, but if the system is in
> disabled mode instead an OSError is thrown for 'No such file or
> directory'.  I haven't look at the source for the underlying
> security_getenforce() system call, but I suspect is is assuming that the
> /selinux pseudo filesystem is populated (as in permissive/enforcing mode),
> and is not handling the case where that pseudo filesystem is empty.
> 
> For now I've got my python calls wrapped in try/except blocks treating any
> exception as SELinux in disabled mode.
> 
> I wasn't sure where the best place to log this as a bug is, either for the
> libselinux-python package or libselinux itself.

I don't know why this would have ever worked, as security_getenforce()
has always returned -1 with errno ENOENT if there is no selinuxfs mount.
Maybe the older python bindings handled this error condition?  The
correct test for enabled/disabled is selinux.is_selinux_enabled(), and
that should be checked prior to calling security_getenforce().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
