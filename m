Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KBnvrT003041
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 07:49:57 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KBnF4v001818
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 11:49:16 GMT
Subject: Re: conflict between libselinux and libsepol
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1092972342.29540.35.camel@nexus.verbum.private>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Aug 2004 07:48:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-19 at 23:25, Colin Walters wrote:
> On Thu, 2004-08-19 at 15:01 -0400, Stephen Smalley wrote:
> 
> > The core checkpolicy logic has been moved into libsepol, a library for binary
> > policy manipulation.  
> 
> There appears to be a conflict between the headers from this and
> libselinux, so an application can't presently include both (I am working
> on a patch to setfiles which needs this).  Specifically, "struct
> av_decision" is defined in both selinux/selinux.h and
> sepol/flask_types.h.
> 
> Perhaps libselinux should be modified to depend on libsepol, and include
> the definition from flask_types.h in selinux.h?

I'd rather keep them independent, as they serve different purposes
(types for the binary policy vs. types for the SELinux API) and may
diverge over time.  Simplest fix would be to add a distinguishing prefix
to the sepol types to avoid namespace conflicts.  But I'm a bit curious
about why setfiles would need libsepol at all, as it normally does not
have anything to do with binary policies.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
