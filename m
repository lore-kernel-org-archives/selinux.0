Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4GGn4PG010135
 for <selinux@tycho.nsa.gov>; Tue, 16 May 2017 12:49:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so10189589pfe.0
 for <selinux@tycho.nsa.gov>; Tue, 16 May 2017 09:48:41 -0700 (PDT)
Date: Wed, 17 May 2017 00:48:35 +0800
From: Jason Zaman <jason@perfinion.com>
To: Dan Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH v1 8/9] semanage: Update semanage to allow runtime
 labeling of ibendports
Message-ID: <20170516164835.GA9284@meriadoc.perfinion.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-9-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494880961-73481-9-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 15, 2017 at 11:42:40PM +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Update libsepol and libsemanage to work with ibendport records. Add local
> storage for new and modified ibendport records in ibendports.local.
> Update semanage to parse the ibendport command options to add, modify,
> and delete them.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> 
> ---
> v1:
> Jason Zaman:
> - Use SETools directly to query types in seobject.py
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 41b0aca..037c9ae 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1565,6 +1565,245 @@ class ibpkeyRecords(semanageRecords):
>                  rec += ", %s" % p
>              print rec
>  
> +class ibendportRecords(semanageRecords):
> +    try:
> +        q = setools.TypeQuery(setools.SELinuxPolicy(sepolicy.get_installed_policy()), attrs=["ibendport_type"])
> +        valid_types = sorted(str(t) for t in q.results())

Super minor nit pick here: set() (or even frozenset()) is probably
better than sorted() since you appear to only just check membership.

I probably wouldnt bother updating unless there is a v2 for some other
reason.

And if want it on this or an updated version:
Acked-by: Jason Zaman <jason@perfinion.com>

-- Jason
