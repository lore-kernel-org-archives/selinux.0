Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5UCVf0S026603
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 08:31:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5UCVX5e019093
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 12:31:33 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h5UCVX92019090 for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 12:31:33 GMT
Subject: Re: improvements to chcon.c
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <1056781690.14920.81.camel@columbia>
References: <1056781690.14920.81.camel@columbia>
Content-Type: text/plain
Message-Id: <1056976283.1110.748.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Jun 2003 08:31:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-06-28 at 02:28, Colin Walters wrote:
> I found that I almost always just wanted to change one component of a
> security contenxt, not the whole thing.  For example, I wanted to
> recursively change the user of /var/www/verbum.org to "walters", while
> keeping the varied types such as httpd_user_content_t,
> httpd_user_script_exec_t, etc. 
> 
> However chcon didn't really give me an easy way to do this. 
> 
> With the attached patch, I can just say:
> chcon -R -h -u walters /var/www/verbum.org
> 
> This is my first attempt at programming using the SELinux API, so please
> review the changes carefully.  This patch is against the woody patch to
> coreutils.

Thanks for implementing this ability.  However, a couple of notes:
(1) The SELinux API has been overhauled as part of preparing for
mainline Linux 2.5 integration, and the new API is being back ported to
the 2.4-based SELinux (although this back port won't be ready for the
next public release), so the old coreutils patch will soon be obsolete. 
See http://www.nsa.gov/selinux/lk/coreutils-selinux.patch.gz for a
snapshot of the new coreutils patch.  See the PORTING file in
http://www.nsa.gov/selinux/lk/selinux-doc-1.0.tgz for discussion of the
API changes.
(2) The omission of the ability to manipulate individual fields of the
security context from the utility patches was intentional.   The goal is
to minimize and centralize the set of code that has awareness of the
internal structure of the security context so that it can be easily
altered (e.g. adding or removing security attributes) with minimal
impact to the rest of the system.  SELinux seeks to provide policy
flexibility not only in the ability to configure the policy, but also in
the ability to drop in significantly revised or even completely new
security models in place of the example security server.  Hence, it
would be preferable to encapsulate this logic further within a library.
(3) The context_* functions defined by context.h are intended to be used
to easily split up a security context, get or set its individual
components, and reconstitute it into a complete string.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
