Subject: Re: Summary of Informal SELinux Meeting on May 6, 2004
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Karl MacMillan <kmacmillan@tresys.com>, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Fedora SELinux support list for users & developers.'" <fedora-selinux-list@redhat.com>
In-Reply-To: <200406041803.23026.russell@coker.com.au>
References: <200406022032.i52KWuSf003348@gotham.columbia.tresys.com>
	 <20040603195738.GE3856@lkcl.net>  <200406041803.23026.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1086348685.19959.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Jun 2004 07:31:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-04 at 04:03, Russell Coker wrote:
> On Fri, 4 Jun 2004 05:57, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> >  all in the same single monolithic daemon that bound itself
> >  to several different ports and several different unix domain
> >  sockets, you wouldn't seriously consider saying that "this
> >  hybrid is a trusted application" would you?
> 
> "trusted" in this context does not mean "the code is great and we can totally 
> trust it", but rather "due to the design of the system we have no choice but 
> to trust it as it can totally break the security if it has a problem".

Further point of clarification:  It only has to be trusted to maintain
separation of data for the security contexts it is allowed to access,
e.g. it might be allowed to access data from multiple user roles and
maintain their separation without being allowed to access administrator
or system files.  So the trust is not absolute; the OS is still
enforcing some degree of confinement over the application.

I think Frank Mayer of Tresys has previously suggested using
"trustworthy" vs. "trusted" to distinguish the cases noted by Russell.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
