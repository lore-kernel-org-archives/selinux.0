Subject: Re: Installation of policy source
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1063388343.30627.9.camel@colossus.columbia.tresys.com>
References: <1063388343.30627.9.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1063388536.19531.185.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 12 Sep 2003 13:42:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-09-12 at 13:39, Karl MacMillan wrote:
> With the quickinstall process gone the policy source no longer gets
> installed under /etc by default and the README doesn't mention the
> install-src target for the policy Makefile. Since some tools (like our
> user management tool seuser) and the policy itself depend upon the
> source for current policy being available at a standard location, it is
> important for the policy source to get installed. Attached are two
> patches that address this. The first adds a note to the README about
> installing the source and the second adds the install-src target to the
> documentation at the beginning of the policy Makefile.

If you build and install via rpm, then the policy sources are installed,
i.e.
	rpmbuild -tb policy-1.1.tgz
	rpm -ivh /usr/src/redhat/RPMS/noarch/policy*.rpm

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
