Subject: Re: Summary of Informal SELinux Meeting on May 6, 2004
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Karl MacMillan <kmacmillan@tresys.com>, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Fedora SELinux support list for users & developers.'" <fedora-selinux-list@redhat.com>
In-Reply-To: <200406042142.27120.russell@coker.com.au>
References: <200406022032.i52KWuSf003348@gotham.columbia.tresys.com>
	 <200406041803.23026.russell@coker.com.au>
	 <1086348685.19959.19.camel@moss-spartans.epoch.ncsc.mil>
	 <200406042142.27120.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1086349716.19959.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Jun 2004 07:48:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-04 at 07:42, Russell Coker wrote:
> That use of the word "trustworthy" seems reasonable.  But as long as the word 
> "trusted" is used in it's current manner in terms of computer security there 
> will be confusion.
> 
> Any suggestions of a term we can use as a synonym for the current use of 
> "trusted" to reduce confusion?

We typically refer to such applications as userspace policy enforcers or
userspace object managers (terminology from the Flask architecture),
reflecting the fact that they are enforcing policy over their own
abstractions/objects.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
