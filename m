Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4QEXCIM003871
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 10:33:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07A3BC05FFD0
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 14:33:07 +0000 (UTC)
Received: from pl-workstation.usersys.redhat.com (unknown [10.40.2.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B1C17C776
 for <selinux@tycho.nsa.gov>; Fri, 26 May 2017 14:33:06 +0000 (UTC)
Date: Fri, 26 May 2017 16:33:04 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix recently introduced TabError's
Message-ID: <20170526143303.GA7094@pl-workstation.usersys.redhat.com>
References: <20170526140951.5112-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170526140951.5112-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 26, 2017 at 04:09:51PM +0200, Petr Lautrbach wrote:
> Commits a3d2c7a 6a7a5aa introduced inconsistent use of tabs and spaces
> in indentation what makes python3.6 unhappy.
> 

There's another python3 problem with using "print ". I'll resend another
patch which will it together with use of tabs and spaces.

> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsemanage/utils/semanage_migrate_store | 4 ++--
>  python/semanage/seobject.py              | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
> index 9a9fac22..2e6cb278 100755
> --- a/libsemanage/utils/semanage_migrate_store
> +++ b/libsemanage/utils/semanage_migrate_store
> @@ -254,8 +254,8 @@ if __name__ == "__main__":
>  		"policy.kern",
>  		"file_contexts",
>  		"homedir_template",
> -                "pkeys.local",
> -                "ibendports.local"]
> +		"pkeys.local",
> +		"ibendports.local"]
>  
>  
>  	create_dir(newroot_path(), 0o755)
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 61be6198..c97a9f0c 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1321,10 +1321,10 @@ class ibpkeyRecords(semanageRecords):
>          semanageRecords.__init__(self, store)
>  
>      def __genkey(self, pkey, subnet_prefix):
> -	if subnet_prefix == "":
> +        if subnet_prefix == "":
>              raise ValueError(_("Subnet Prefix is required"))
>  
> -	pkeys = pkey.split("-")
> +        pkeys = pkey.split("-")
>          if len(pkeys) == 1:
>              high = low = int(pkeys[0], 0)
>          else:
> @@ -1576,7 +1576,7 @@ class ibendportRecords(semanageRecords):
>          semanageRecords.__init__(self, store)
>  
>      def __genkey(self, ibendport, ibdev_name):
> -	if ibdev_name == "":
> +        if ibdev_name == "":
>              raise ValueError(_("IB device name is required"))
>  
>          port = int(ibendport)
> -- 
> 2.13.0
> 
