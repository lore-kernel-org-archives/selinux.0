Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1RJT1Rb008560
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 14:29:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1RJROlK029091
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 19:27:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1RJROOX029088
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 19:27:24 GMT
Subject: Re: Proposed patch to policy file_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <403E52AD.5090103@redhat.com>
References: <403E52AD.5090103@redhat.com>
Content-Type: text/plain
Message-Id: <1077910132.26543.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 27 Feb 2004 14:28:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-02-26 at 15:10, Daniel J Walsh wrote:
> --- policy-1.6/file_contexts/homedir.homedir	2004-02-26 14:57:07.079392137 -0500
> +++ policy-1.6/file_contexts/homedir	2004-02-26 14:56:33.529232470 -0500
> @@ -0,0 +1,14 @@
> +define(`home_dir',`
> +$2			-d	system_u:object_r:home_root_t
> +ifelse($3,`',`
> +$2/[^/]+		-d	system_u:object_r:$1_home_dir_t
> +$2/[^/]+/.+			system_u:object_r:$1_home_t
> +$2/\.journal			<<none>>
> +$2/lost\+found(/.*)?		system_u:object_r:lost_found_t
> +', `
> +$2/$3/[^/]+		-d	system_u:object_r:$1_home_dir_t
> +$2/$3/[^/]+/.+			system_u:object_r:$1_home_t
> +$2/$3/\.journal			<<none>>
> +$2/$3/lost\+found(/.*)?		system_u:object_r:lost_found_t
> +')
> +')

I doubt you want to move the \.journal and lost\+found entries into
these macros, as they are only applicable to the root directory of each
filesystem, not individual home directories.  Should this file be called
homedir.fc rather than just homedir?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
