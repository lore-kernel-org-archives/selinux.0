Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0TEcjRb011928
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 09:38:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0TEbRVK005670
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 14:37:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0TEbRlx005667
	for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2004 14:37:27 GMT
Subject: Re: Problem with selinux configuration
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Keen <keen@internode.on.net>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <5.1.0.14.2.20040130001522.00f65440@mail.internode.on.net>
References: <40186cf7.274.6f79.443726088@internode.on.net>
	 <40186cf7.274.6f79.443726088@internode.on.net>
	 <5.1.0.14.2.20040130001522.00f65440@mail.internode.on.net>
Content-Type: text/plain
Message-Id: <1075387106.21044.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 09:38:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-29 at 09:24, Keen wrote:
> well i'm not exactly sure what rawhide is? some other rpm dependency? where 
> can i find/get it?

rawhide aka Fedora Core Development is the bleeding edge development
tree for the next release of Fedora Core.

> i'm actually supposed to be researching SELinux for a school project, so 
> it's not for any serious production servers.
> for starters I'd need to at least setup a box for it and then go on from 
> there. I'm using RH9 at the moment since RH is the distro I'm most familiar 
> with, although I may be prepared to jump onto other distros if the need 
> arise. I'm not sure when FC2 would be out, but I suppose my project might 
> be due or might leave me with little time for me to come up with anything?
> 
> Thank you for your replies, they are much appreciated. Please offer any 
> other suggestions if anyone could offer them.

For your purposes, I'd just install Fedora Core 1 (see
http://fedora.redhat.com), and then install the December release of
SELinux from the nsa.gov site.  Your only mistake was starting with RH9
instead of Fedora Core 1, as was noted on the download page.

Note that once you've installed Fedora Core 1, you can also use yum to
upgrade to rawhide/development and grab the 2.6 kernel and
SELinux-related packages from it if you want to use that code rather
than the December release.  But that will require updating various
dependencies as well, such as glibc.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
