Subject: Re: [PATCH] mls in modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1128374052.26285.283.camel@moss-spartans.epoch.ncsc.mil>
References: <1128112952.22583.25.camel@twoface.columbia.tresys.com>
	 <1128353485.26285.119.camel@moss-spartans.epoch.ncsc.mil>
	 <434165E3.5050804@tresys.com>
	 <1128374052.26285.283.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 07:56:54 -0400
Message-Id: <1128427014.26285.315.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-03 at 17:14 -0400, Stephen Smalley wrote:
> On Mon, 2005-10-03 at 13:09 -0400, Joshua Brindle wrote:
> > Yes, I got a little overzealous with the initialization, go ahead and 
> > remove these.
> 
> Ok, merged the rest of the patch.

BTW, this brings up another issue on the MLS support in
checkpolicy/checkmodule, namely whether we should obsolete the explicit
-M options (continue allowing them for compatibility, but no longer
require them) and just have them implicitly enable MLS support when they
find a MLS section in the policy.  At least for checkpolicy and the base
module (default for checkmodule).  For non-base modules, I suppose that
there is no way for checkmodule to infer whether it should enable MLS
without having a copy of the base module readily available as well.
Although MLS has no meaning for non-base modules presently, right, since
they can't support MLS user records?
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
