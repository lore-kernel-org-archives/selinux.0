Subject: Re: Man pages translation (Russian) policycoreutils and reference
	policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrey Markelov <andrey@markelov.net>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <20080108012439.7ce2ec99.andrey@markelov.net>
References: <20071229145711.b16ceab7.andrey@markelov.net>
	 <1199737002.2944.257.camel@moss-spartans.epoch.ncsc.mil>
	 <20080108012439.7ce2ec99.andrey@markelov.net>
Content-Type: text/plain; charset=utf-8
Date: Tue, 08 Jan 2008 07:49:59 -0500
Message-Id: <1199796599.2944.268.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-01-08 at 01:24 +0300, Andrey Markelov wrote:
> It could be placed into in man/COUNTRY_CODE_ISO3166/man1...man8 like in rpm packages.
> For example in mc (http://www.ibiblio.org/mc/) and rpm (http://www.rpm.org/)
> source tarballs Russian (and some other) man pages is present.

Currently the policycoreutils man pages are colocated with the
individual programs in the individual program subdirectories in the
source tree, e.g.
policycoreutils/newrole/newrole.1
policycoreutils/semanage/semanage.8
policycoreutils/semodule/semodule.8

I suppose we could change that, but we'd have to rearrange the source
tree, update the makefiles, etc.

> On Mon, 07 Jan 2008 15:16:42 -0500
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > 
> > On Sat, 2007-12-29 at 14:57 +0300, Andrey Markelov wrote:
> > > Hello!
> > > 
> > > I have translated all man pages from policycoreutils and from reference policy to Russian language.
> > > Now all of thous is in Rawhide/Fedora 8 (selinux-policy and policycoreutils RPMs).
> > > Is it possible to include Russian translations in main stream of NSA’s package policycoreutils
> > > and reference policy package of Tresys?
> > > I hope it will be useful for security specialists who work with other distributions than Fedora.
> > > Here is archives of man pages in attachment. My next goal for translation is libselinux.
> > 
> > We only provide source tarballs - not sure how we would package up
> > multiple translations for the man pages. 
> > 
> > -- 
> > Stephen Smalley
> > National Security Agency
> > 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
