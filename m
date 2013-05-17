Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4HCi02U029008
	for <selinux@tycho.nsa.gov>; Fri, 17 May 2013 08:44:00 -0400
Received: by mail-ee0-f50.google.com with SMTP id c41so2553960eek.23
        for <selinux@tycho.nsa.gov>; Fri, 17 May 2013 05:44:00 -0700 (PDT)
Date: Fri, 17 May 2013 14:42:50 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Steve Lawrence <slawrence@tresys.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Future of SETools and CIL
Message-ID: <20130517124249.GA21913@siphos.be>
References: <5194E01F.2040505@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5194E01F.2040505@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 16, 2013 at 09:33:19AM -0400, Steve Lawrence wrote:
> It has become clear that SETools has fallen behind userspace in terms of
> features and general maintenance. We would like to get it to the point
> where this is not the case, and to find a way to make sure it does not
> happen again. We think the solution to the maintenance issue is to make
> it more visible by merging the more useful parts of SETools into the
> userspace repo, while deprecating/removing the remaining pieces.
> 
> However, we are well aware of the complexity of SETools, primarily
> libapol, and that upstreaming it without any changes would not solve the
> problems.

Only SETools complex? I find the combination of all libraries and tools
(libselinux, libsemanage, libsepol, sepolgen, policycoreutils, setools,
checkpolicy) not always that obvious to manage. And many of them then try to
have their interfaces supported in other languages (like python or ruby) and use
swig to generate these bindings, which makes it - imo - even less obvious
for troubleshooting. And then you have the complexity of python-2 versus
python-3 that still needs to be sorted out :-(

I'm in favor of all efforts to get the userspace and libraries things well
documented and maintained and using a simple codebase...

> So, we have done a little work behind the scenes to find a way
> to reduce the complexity of libapol. As a first stab at it, we started
> with an older version of libapol that is quite a bit less complex and
> began porting it forward for use with modern userspace, and seeing if it
> would make sense to eventually merge. 

Please take care not to depend on unknown patches only available in fedora.

> Another discussion we would like to have, which may affect the future of
> SETools/apol, is CIL. Is there still interest in CIL? And if so, have
> there been any thoughts on using and migrating to CIL? Is more work
> needed before this can happen? Has anyone put thought into higher level
> languages that could sit on top of CIL? If there is interest, this may
> affect the SETools changes, for example, syntactic policy analysis for
> CIL is likely very different than current policy.

I have been hearing of CIL for a few years, never tried it out. For me, as
one of the SELinux guys for Gentoo Hardened, CIL only comes to play when the
reference policy upon which we base ourselves is available in CIL and/or the
updates of the reference policy are easily migrated to CIL as well.

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
