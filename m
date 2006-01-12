Subject: Re: Document about object classes and permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@gwu.edu>
Cc: James Morris <jmorris@namei.org>, SELinux@tycho.nsa.gov
In-Reply-To: <20060112110424.18f8203d.ynakam@gwu.edu>
References: <7ed98a07edb73e.7edb73e7ed98a0@gwu.edu>
	 <Pine.LNX.4.63.0601081001440.31099@excalibur.intercode>
	 <20060112110424.18f8203d.ynakam@gwu.edu>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 11:27:05 -0500
Message-Id: <1137083225.3445.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-12 at 11:04 -0500, Yuichi Nakamura wrote:
> On Sun, 08 Jan 2006 10:02:17 -0500 (EST)
> James Morris wrote:
> > > I've finished writing document about meaning of permissions.
> > The audit permissions are for the mainline CAPP audit system, not Laus.
> Thank you for comment. fixed.
> 
> But I am not understanding relationship between CAPP audit system and LauS.
> LauS is component of CAPP audit system?

No, there were two independent audit implementations for Linux; LAuS was
the first, but was not suitable for the mainline kernel and was never
upstreamed.  The mainline Linux 2.6 kernel audit system was created
later and used a different approach.  The SELinux controls are only for
the mainline kernel's audit system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
