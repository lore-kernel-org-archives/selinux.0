Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3MLOtk3007296
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 17:24:55 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n3MLOsoj017121
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 21:24:54 GMT
Date: Wed, 22 Apr 2009 17:24:53 -0400
Subject: Re: sepolgen typo fix
From: Chad Sellers <csellers@tresys.com>
To: Marshall Miller <mmiller@tresys.com>, <selinux@tycho.nsa.gov>
Message-ID: <C6150365.A6A77%csellers@tresys.com>
In-Reply-To: <1238528520.18182.338.camel@hostmachine.tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/31/09 3:42 PM, "Marshall Miller" <mmiller@tresys.com> wrote:

> Commit b3b3f8186ed6d56c48c4e0f997d6e6b3fd90be37 attempted to fix a bug,
> but didn't.  The following patch should do it.
> 
> 
> Marshall Miller
> 
> ---
> diff --git a/sepolgen/src/sepolgen/access.py
> b/sepolgen/src/sepolgen/access.py
> index 6de919a..71121d7 100644
> --- a/sepolgen/src/sepolgen/access.py
> +++ b/sepolgen/src/sepolgen/access.py
> @@ -313,7 +313,7 @@ class RoleTypeSet:
>  
>      def __len__(self):
>          """Return the unique number of role allow statements."""
> -        return len(self.role_type.keys())
> +        return len(self.role_types.keys())
>  
>      def add(self, role, type):
>          if self.role_types.has_key(role):
> 
Looks fine.

Acked-by: Chad Sellers <csellers@tresys.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
