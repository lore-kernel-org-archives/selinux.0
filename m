Subject: Re: Installation of policy source
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Dave Caplan <dac@tresys.com>,
   Frank Mayer <mayerf@tresys.com>
Cc: Diyab <diyab@diyab.net>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1063639604.13311.138.camel@moss-spartans.epoch.ncsc.mil>
References: <1063388343.30627.9.camel@colossus.columbia.tresys.com>
	 <1063388536.19531.185.camel@moss-spartans.epoch.ncsc.mil>
	 <3F624B45.2050109@diyab.net>
	 <1063636005.13311.98.camel@moss-spartans.epoch.ncsc.mil>
	 <1063639184.30627.38.camel@colossus.columbia.tresys.com>
	 <1063639604.13311.138.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1063641853.30627.53.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Mon, 15 Sep 2003 12:04:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-09-15 at 11:26, Stephen Smalley wrote:
> On Mon, 2003-09-15 at 11:19, Karl MacMillan wrote:
> > I think it would be clearer if the tarball creation was explicitly
> > mentioned. Below is a modified patch that does that. Other than that
> > this certainly meets my initial goals.
> 
> The expectation was that people using the rpm-based approach had
> directly downloaded the individual tarballs from the NSA site, e.g. wget
> http://www.nsa.gov/selinux/archives/policy-1.1.tgz.  However, I suppose
> that this isn't a good assumption, as the patched SRPMS will have
> problems building unless you've installed libselinux via rpm, since
> rpm won't know about libselinux if you install it the old-fashioned way.
>
> Unless I'm missing something, your revised instructions won't work;
> rpmbuild will fail as it expects the tarball and directory name to
> include the version suffix.  I've attached a README patch relative to my
> prior one and a little script that can be used to build the tarballs in
> the desired form from the selinux-usr tree.

You are absolutely correct about my instructions- the initial
instructions that I did moved the directories to *-1.1 and made the
tarballs from there. Unfortunately, I then tested to see if the version
numbers were needed and was able to successfully do the builds without
moving the directories first because the original tarballs I made were
sitting there, leading me to think that the version numbers weren't
needed. I think that this clearly demonstrates that the explicit
documentation and your build script is a good thing :)

I tested the build script and it worked fine on my machine.

Thanks,

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
