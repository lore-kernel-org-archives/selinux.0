Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1IG0Z9p008040
 for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2015 11:00:36 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 6ABA620870
 for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2015 11:00:22 -0500 (EST)
Message-Id: <1424275222.235440.229264653.0B7B44AE@webmail.messagingengine.com>
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1423842219-16327-1-git-send-email-sds@tycho.nsa.gov>
References: <1423842219-16327-1-git-send-email-sds@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: fix audit2why error handling if SELinux is
 disabled.
Date: Wed, 18 Feb 2015 11:00:22 -0500
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Feb 13, 2015, at 10:43 AM, Stephen Smalley wrote:
>
> +		if (!curpolicy) {
> +			/* SELinux disabled, must use -p option. */
> +			snprintf(errormsg, sizeof(errormsg),
> +				 "You must specify the -p option with the path to the policy file.\n");
> +			PyErr_SetString( PyExc_ValueError, errormsg);

Personally I try to avoid using printf without any format strings, because
it's easier to add format string errors later.  Just:

PyErr_SetString(PyExc_ValueError, "You must specify the -p option with the path to the policy file.\n");

?

With or without that change though, the patch looks fine to me.
