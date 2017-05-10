Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4ALLLMJ004531
 for <selinux@tycho.nsa.gov>; Wed, 10 May 2017 17:21:21 -0400
Received: by mail-wm0-f51.google.com with SMTP id m123so13929263wma.0
 for <selinux@tycho.nsa.gov>; Wed, 10 May 2017 14:21:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494421112.24408.1.camel@tycho.nsa.gov>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <23de1ae5-c3ef-9c31-be15-4b9cde74157d@tycho.nsa.gov>
 <CAHC9VhSD_Ydp9JCHUZmW7zW05mgMkwHV1m_LSc8KT2EvqTk_VQ@mail.gmail.com>
 <1494362396.2184.2.camel@tycho.nsa.gov>
 <CAHC9VhTV_+04pMhNO+CsgiFDA0yuPDuW1oZSZis+VBxhutOr5A@mail.gmail.com>
 <1494421112.24408.1.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 May 2017 17:21:07 -0400
Message-ID: <CAHC9VhSu6aZK9ZDbALa7JqA=+KGiXOPf4dXfYe0iyCPvCaHhXA@mail.gmail.com>
Subject: Re: Policy capabilities: when to use and complications with using
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Carter <jwcart2@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 Joshua Brindle <brindle@quarksecurity.com>,
 Chris PeBenito <pebenito@ieee.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 10, 2017 at 8:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> I'm not proposing introducing policy capabilities for those commits
> retroactively; I don't think that would be productive now that they are
> already in upstream kernels and policies.  I just wanted to determine
> whether or not we think similar changes in the future should be wrapped
> with policy capabilities.
>
> If so, then I think that motivates lighter weight policy capabilities,
> as otherwise for each of these changes (and others too - e.g. probably
> the prlimit change) we would have been in the same position as with
> extended_socket_class, i.e. waiting for a release of libsepol that
> defines the new policy capability, requiring refpolicy to add a
> dependency on that specific libsepol version before it could be enabled
> by default, waiting for Fedora to update to that version, etc.

That's fine with me.  As I said earlier, I'm not opposed, I just
wanted to make sure this is a definite "must have".

-- 
paul moore
www.paul-moore.com
