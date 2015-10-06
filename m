Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t96Itfqr026909
 for <selinux@tycho.nsa.gov>; Tue, 6 Oct 2015 14:55:41 -0400
Received: by wiclk2 with SMTP id lk2so172723507wic.1
 for <selinux@tycho.nsa.gov>; Tue, 06 Oct 2015 11:55:38 -0700 (PDT)
Subject: Re: [RFC PATCH v2 5/5] selinux: introduce kdbus access controls
To: Paul Moore <pmoore@redhat.com>, linux-security-module@vger.kernel.org
References: <20151005203358.32023.88592.stgit@localhost>
 <20151005204137.32023.7198.stgit@localhost>
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Message-ID: <56141925.5050004@m4x.org>
Date: Tue, 6 Oct 2015 20:55:33 +0200
MIME-Version: 1.0
In-Reply-To: <20151005204137.32023.7198.stgit@localhost>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/05/2015 10:41 PM, Paul Moore wrote:
> Add the SELinux access control implementation for the new kdbus LSM
> hooks using the new kdbus object class and the following permissions:
> 
[[SNIP]]
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index eccd61b..31e4435 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -153,5 +153,9 @@ struct security_class_mapping secclass_map[] = {
>  	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
>  	{ "binder", { "impersonate", "call", "set_context_mgr", "transfer",
>  		      NULL } },
> +	{ "kdbus", { "impersonate", "fakecreds", "fakepids", "owner",
> +		     "privileged", "activator", "monitor", "policy_holder",
> +		     "connect", "own", "talk", "see", "see_name",
> +		     "see_notification" } },
>  	{ NULL }
>    };

Hello,
Out of curiosity, why is the new list of permissions not
NULL-terminated?  As far as I can tell, as the field "perms" of struct
security_class_mapping is a fixed-size vector, it doesn't matter here
(the C compiler would always pad with NULL pointers), but then I am
wondering why all the other lists of perms are NULL-terminated in
classmap.h.

Thanks,

Nicolas
