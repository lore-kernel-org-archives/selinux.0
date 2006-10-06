Subject: Re: [RFC PATCH] newrole suid breakdown
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Steve Grubb <sgrubb@redhat.com>, Michael C Thompson <thompsmc@us.ibm.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
In-Reply-To: <45268D9A.3060207@redhat.com>
References: <452432FA.1060009@us.ibm.com>
	 <200610051748.06669.sgrubb@redhat.com>
	 <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
	 <200610061134.27916.sgrubb@redhat.com>
	 <1160151252.12253.144.camel@moss-spartans.epoch.ncsc.mil>
	 <45268D9A.3060207@redhat.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 13:13:29 -0400
Message-Id: <1160154809.20202.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 13:08 -0400, Daniel J Walsh wrote:
> > Well, I would certainly be glad to see such support restored and
> > expanded (e.g. to include gdm).  But there was resistance to that from
> > RH in the past.
> >   
> This causes problems with Root apps that use su to transition to a 
> different uid, which prompted the creation of runuser, and end up with 
> the app frozen waiting for the file context to be chosen.    Since su no 
> longer uses pam_selinux this is less of a problem.  Also the multiple 
> flag sometimes returned login domains that made no sense.  I would not 
> have a problem with adding it back, but I would prefer it turned off by 
> default.  So MLS/Strict people could turn it on, but targeted would 
> leave it off.

We'd need similar support in sshd, and possibly in gdm (although that is
likely out of scope for LSPP itself).  There was an old gdm patch a long
time ago for selinux that allowed context selection there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
