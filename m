Subject: Re: fixfiles: broken option processing?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Marshall Miller <mmiller@tresys.com>,
        "Todd C. Miller" <tmiller@tresys.com>
In-Reply-To: <20080208082922.GA26640@bobek.pm.i.cz>
References: <20080206154957.GA28647@bobek.pm.i.cz>
	 <1202419683.27371.306.camel@moss-spartans.epoch.ncsc.mil>
	 <20080208082922.GA26640@bobek.pm.i.cz>
Content-Type: text/plain; charset=utf-8
Date: Fri, 08 Feb 2008 11:19:21 -0500
Message-Id: <1202487561.27371.390.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-08 at 09:29 +0100, Václav Ovsík wrote:
> On Thu, Feb 07, 2008 at 04:28:03PM -0500, Stephen Smalley wrote:
> > Hmm..the shifting of arguments was introduced in r2699 from Dan Walsh
> > (cc'd), diff is below.  Also relevant are r2736, r2750 and r2760.
> > 
> > I'd agree that we don't want to break existing usage, but I'm not sure
> > what the least intrusive and cleanest fix is.
> 
> Ok. What about this patch :)
> 
> The interpreter is changed to /bin/bash.  There are bashisms (getopts,
> PIPESTATUS...), so this can't be interpreted by /bin/sh.

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
