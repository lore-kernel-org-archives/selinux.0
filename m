Message-ID: <3F624B45.2050109@diyab.net>
Date: Fri, 12 Sep 2003 18:40:05 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Installation of policy source
References: <1063388343.30627.9.camel@colossus.columbia.tresys.com> <1063388536.19531.185.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1063388536.19531.185.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2003-09-12 at 13:39, Karl MacMillan wrote:
> 
>>With the quickinstall process gone the policy source no longer gets
>>installed under /etc by default and the README doesn't mention the
>>install-src target for the policy Makefile. Since some tools (like our
>>user management tool seuser) and the policy itself depend upon the
>>source for current policy being available at a standard location, it is
>>important for the policy source to get installed. Attached are two
>>patches that address this. The first adds a note to the README about
>>installing the source and the second adds the install-src target to the
>>documentation at the beginning of the policy Makefile.
> 
> 
> If you build and install via rpm, then the policy sources are installed,
> i.e.
> 	rpmbuild -tb policy-1.1.tgz
> 	rpm -ivh /usr/src/redhat/RPMS/noarch/policy*.rpm
> 

That's fine if you use rpms but not everyone does.  I agree that the 
install-src step should be mentioned in the documentation but I don't 
see any reason it needs to be noted in the makefile.  Once you run 
install-src you won't be doing it again after it's installed.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
