Subject: Re: setools, version 0.8
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Mauro Chiarugi <vlaovic@libero.it>
Cc: Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <20030411135236.51ed6cff.vlaovic@libero.it>
References: <004901c2ff81$959a32d0$6600a8c0@columbia.tresys.com>
	 <200304111624.43830.russell@coker.com.au>
	 <20030411095457.3eefc135.vlaovic@libero.it>
	 <200304111922.23393.russell@coker.com.au>
	 <20030411135236.51ed6cff.vlaovic@libero.it>
Content-Type: text/plain
Message-Id: <1050065686.3715.16.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 11 Apr 2003 08:54:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-04-11 at 07:52, Mauro Chiarugi wrote:
> Ok, i  downloaded "2.5 LSM-based Security-Enhanced Linux" from
> http://www.nsa.gov/selinux.
> I've seen that there is a version named "2.5 Mainline-based
> Security-Enhanced Linux" too.
> Which version do i have to get?? Which version conains "the latest xattr
> based patches"??

Russell was referring to the 2.5 mainline-based SELinux, but you should
be aware that it is a work in progress and is not yet in a fully
functional state, as noted on its download page.  Hence, you might want
to wait until it matures further, at least until the APIs are accepted
into the mainline kernel and a corresponding userland is developed (e.g.
reworked versions of the patches for login and sshd, and a new version
of newrole).
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
