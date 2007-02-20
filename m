Subject: Re: policycoreutils/semanage/seobject.py:setransRecords: improper
	string subst
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: kmacmillan@mentalrootkit.com, jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <200702061623.l16GNK3S017381@localhost.localdomain>
References: <200702061623.l16GNK3S017381@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:19:36 -0500
Message-Id: <1171984776.14363.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-06 at 11:23 -0500, Caleb Case wrote:
> A small fix for the wrong number of arguments for python string substitution.
> ---
>  policycoreutils/semanage/seobject.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: selinux-pms-support/policycoreutils/semanage/seobject.py
> ===================================================================
> --- selinux-pms-support.orig/policycoreutils/semanage/seobject.py
> +++ selinux-pms-support/policycoreutils/semanage/seobject.py
> @@ -139,7 +139,7 @@ class setransRecords:
>  			translations = fd.readlines()
>  			fd.close()
>  		except IOError, e:
> -			raise ValueError(_("Unable to open %s: translations not supported on non-MLS machines") % (self.filename, e) )			
> +			raise ValueError(_("Unable to open %s: translations not supported on non-MLS machines") % (self.filename) )
>  			
>  		self.ddict = {}
>  		self.comments = []

Merged to -stable and -trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
