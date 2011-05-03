Subject: Re: libselinux mountpoint changing patch.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
        Lennart Poettering
 <lennart@poettering.net>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <4DC02770.1040406@redhat.com>
References: <4DC01640.9000206@redhat.com>
	 <1304436800.1587.20.camel@moss-pluto>  <4DC02770.1040406@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 May 2011 12:53:05 -0400
Message-ID: <1304441585.1587.25.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-05-03 at 12:04 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 05/03/2011 11:33 AM, Stephen Smalley wrote:
> > As check_mountpoint() sets selinux_mnt, I'd pick a more descriptive
> > name.  Actually, could you perhaps fold the logic into set_selinuxmnt()?
> > That would mean the validation would happen when set_selinuxmnt() gets
> > called by load_policy, which isn't strictly necessary but does no harm.
> > 
> 
> Done
> 
> I have to change set_selinuxmnt to return an int now, though.
> Does this mean we would need an API version bump?  Changing from void
> return to int?

Ah, I missed that.  We don't want to change the ABI, so I guess you
should leave set_selinuxmnt() alone and make this a new function.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
