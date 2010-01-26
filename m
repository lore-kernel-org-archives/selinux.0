Subject: Allowing MLS->non-MLS and vice versa upon policy reload (Was: Re:
 Building MLS/MCS policy)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <1264528350.19890.74.camel@moss-pluto.epoch.ncsc.mil>
References: <201001261546.o0QFkDMJ023435@vivaldi15.register.it>
	 <1264528350.19890.74.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 26 Jan 2010 14:18:12 -0500
Message-Id: <1264533492.19890.76.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-01-26 at 12:52 -0500, Stephen Smalley wrote:
> Alternatively to spending time on documenting the current limitation, it
> might be more interesting to try removing the restriction from the
> SELinux kernel code and investigating what needs to be done within the
> kernel to enable it to be done safely.  Primarily this would mean:
> - pushing the selinux_mls_enabled flag inside the policydb so that it
> could be per-policydb (this is already the case in libsepol),
> - in the non-MLS to MLS case, ensuring that the MLS fields of the
> context for all existing entries in the sidtab are filled in with a
> suitable default value, likely taken from one of the initial SIDs,
> - in the MLS to non-MLS case, freeing any storage used by the MLS fields
> in the context for all existing entries in the sidtab.

FYI, both of the latter two items would be handled inside of
ss/services.c:convert_context().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
