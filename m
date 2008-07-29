Subject: Re: Ruby bindings patch for libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <488F2CF8.2010600@redhat.com>
References: <4876284A.5070606@redhat.com>
	 <1217336636.20373.175.camel@moss-spartans.epoch.ncsc.mil>
	 <488F2CF8.2010600@redhat.com>
Content-Type: text/plain
Date: Tue, 29 Jul 2008 11:01:51 -0400
Message-Id: <1217343711.20373.206.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-29 at 10:45 -0400, Daniel J Walsh wrote:
> > Rather than commenting out or #ifdef'ing python binding code, just
> > remove it from this file.
> 
> I left it in t he hopes that someone who knew ruby would come in and fix it.

Better to just strip it and they can always look at the python bindings
later if they want.

> > What are the build dependencies?  Doesn't build for me on F8 or F9 with
> > ruby, ruby-libs and ruby-devel installed.
> 
> Build fine for me on F9 and Rawhide.
> 
> Spec file has:
> 
> BuildRequires: python-devel ruby-devel ruby libsepol-static >=
> %{libsepolver} swig

Ah, ok - now it builds for me.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
