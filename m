Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <1139501636.10222.11.camel@localhost>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139501636.10222.11.camel@localhost>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 12:29:46 -0500
Message-Id: <1139506186.2872.211.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-09 at 10:13 -0600, Timothy R. Chavez wrote:
> > You also need to verify the policy serial number.
> 
> Ah, thanks.

Not clear actually - the context structs and integer index values for
the components need to be tagged with a policy serial number if exported
outside of the security server, but the SID itself remains stable across
policy reloads; only the context struct contents are remapped.  If
invalidated, subsequent lookup of the SID will be remapped to the
unlabeled SID's context.

> I think it'd be the simplest solution, but I was a bit weary about
> adding a string param... I thought using an integer might be the path of
> least resistance :)

Yes, a SID makes sense here and avoids the allocation/lifecycle pain of
strings or generic security blobs.

> Actually, security_task_getsid() does exist (or did exist last time I
> updated the viro/audit-2.6 git tree).

It doesn't do what you think it does.   Look at the inline documentation
for it in security.h.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
