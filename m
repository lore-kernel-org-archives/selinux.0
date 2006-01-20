Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 10:20:13 -0500
Message-Id: <1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-19 at 16:45 -0500, Joshua Brindle wrote:
> - make the bottom level Makefile propagate install-pywrap target
> - make install-pywrap target in libselinux depend on pywrap
> 
> 
> It appears that the last commit didn't have make swigify run in
> libsemanage so the generated swig wrappers were out of date, the ones in
> this patch include my changes as well as the last ones.

Merged the pywrap Makefile changes and regenerated the wrappers for the
prior changes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
