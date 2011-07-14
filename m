Subject: Re: As we move to systemd, we are loosing some functionality from
 init scripts.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Matthew Ife <deleriux@airattack-central.com>,
        SELinux
 <selinux@tycho.nsa.gov>
In-Reply-To: <4E1DD9A7.80007@redhat.com>
References: <4E1CB8A5.2010707@redhat.com>
	 <1310577633.19434.6.camel@home.localdomain>  <4E1DD9A7.80007@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Jul 2011 08:51:55 -0400
Message-ID: <1310647915.28361.2.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-07-13 at 13:45 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 07/13/2011 01:20 PM, Matthew Ife wrote:
> > I dont think that will work. According to my strace systemd performs
> > the work completely on behalf of the user when calling systemctl.
> > 
> > It might be more elegant to solve the problem in software.. ideally
> > with some selinux object manager for systemd that systemctl can be 
> > intercepted with.
> > 
> > Say classes of target and service and permissions like start, stop 
> > reload, restart etc.
> > 
> > That could take a while to implement though.
> > 
> Right, I was thinking of something simpler, Have systemd become an
> object manager but only have it check the services file.  That way we
> just put a label on the services file and have systemd check if the user
> context is allowed to "PROCESS" "EXECUTE" or some other access method on
> the services file.

Don't reuse the kernel classes/permissions please.  I know we've done
that in e.g. crond in the past, but it conflates their purpose; define
new classes/perms for this purpose instead.  Also be sure to use the
newer interfaces for userspace object managers ala XSELinux so that you
use dynamic class/perm mapping.  We still need the older userspace
object managers to be updated in that regard.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
