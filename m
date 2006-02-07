Subject: Re: [PATCH 3/3] libsepol - fix aliased sensitivities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <200602062238.k16McJNq012375@gotham.columbia.tresys.com>
References: <200602062238.k16McJNq012375@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 08:21:56 -0500
Message-Id: <1139318516.2872.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-06 at 17:38 -0500, Kevin Carr wrote:
> This last patch fixes expand.

No patch here, but I don't think it matters, as I think we can just fix
checkpolicy to clone the levels in the first place.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
