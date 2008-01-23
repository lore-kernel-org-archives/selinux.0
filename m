Subject: Re: Swig patch for libselinux to stop warning messages and update
	to latest swig
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Todd Miller <Tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4787BCA9.5020000@redhat.com>
References: <47879290.7080004@redhat.com>
	 <6FE441CD9F0C0C479F2D88F959B01588016EE821@exchange.columbia.tresys.com>
	 <4787BCA9.5020000@redhat.com>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 16:03:16 -0500
Message-Id: <1201122196.7025.337.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-01-11 at 13:59 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Todd Miller wrote:
> > Is "security_contextx_t" a typo?
> > 
> >  - todd
> Yes, And I don't think we need that line.  It was added for something
> else I was attempting and no longer do. (obviously.)
> 
> Updated patch.

Merged a fixed version of this patch (still had the extraneous type in
it, but I removed it).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
