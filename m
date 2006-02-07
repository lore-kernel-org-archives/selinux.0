Subject: Re: [PATCH 1/3] libsepol - fix aliased sensitivities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <200602062221.k16MLUNq011736@gotham.columbia.tresys.com>
References: <200602062221.k16MLUNq011736@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 08:01:46 -0500
Message-Id: <1139317306.2872.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-06 at 17:21 -0500, Kevin Carr wrote:
> While testing MLS features in apol we realized a few problems with aliased
> sensitivities in libsepol.  This first patch fixes a double free in
> sens_destroy().

No, the correct solution is to avoid the aliasing in the checkpolicy
code.  That is what we have been doing for other similar cases;
policydb_read in libsepol and the kernel doesn't do any such aliasing,
and neither should checkpolicy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
