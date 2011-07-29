Subject: Re: Fwd: How to extract file context patterns from selinux module
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Karel Srot <ksrot@redhat.com>,
        Steve
 Lawrence <slawrence@tresys.com>
In-Reply-To: <4E32CD7F.9000902@redhat.com>
References: <1311941001.7994.4.camel@dhcp-30-102.brq.redhat.com>
	 <4E32A24A.4000503@redhat.com> <1311946147.12720.26.camel@moss-pluto>
	 <4E32CD7F.9000902@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Jul 2011 12:04:40 -0400
Message-ID: <1311955480.12720.36.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-07-29 at 11:10 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 07/29/2011 09:29 AM, Stephen Smalley wrote:
> > On Fri, 2011-07-29 at 08:06 -0400, Daniel J Walsh wrote:
> >> Hi, could you please help me with following problem? I would like
> >> to extract context patterns from a selinux module. I know there are
> >> placed at the end of the module but I don't know (and didn't find)
> >> the module structure. Therefore I don't know how to parse them (if
> >> there are any in the module).
> >> 
> >> Thank you in advance Karel Srot
> >> 
> >> $ tail abrt.pp var/cache/abrt-di(/.*)?
> >> system_u:object_r:abrt_var_cache_t:s0 /var/log/abrt-logger		--
> >> system_u:object_r:abrt_var_log_t:s0 /var/run/abrt\.pid			--
> >> system_u:object_r:abrt_var_run_t:s0 /var/run/abrtd?\.lock		--
> >> system_u:object_r:abrt_var_run_t:s0 /var/run/abrtd?\.socket		-s
> >> system_u:object_r:abrt_var_run_t:s0 /var/run/abrt(/.*)?
> >> system_u:object_r:abrt_var_run_t:s0 ...
> > 
> > I created this program a while ago to support unpacking the .mod
> > file from the .pp file, and just extended it to optionally unpack the
> > .fc file as well.  If people find it useful, we could perhaps add it
> > to policycoreutils.
> > 
> > $ gcc -lsepol -o semodule_unpackage semodule_unpackage.c $ bunzip2 -c
> > /usr/share/selinux/targeted/apache.pp.bz2 > apache.pp $
> > semodule_unpackage apache.pp apache.mod apache.fc $ cat apache.fc
> > 
> 
> 
> The real goal should be to get back to te file?

Can't do that exactly, but checkpolicy/test/dismod.c is an approximation
given the .mod file.  So you could write something similar to dismod.c
that just dumps all of the information rather than being interactive.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
