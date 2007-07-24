Subject: Re: [patch] libselinux:  fix type mismatch in
	string_to_security_class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <ogtodi14r03.fsf@oolong.mitre.org>
References: <1185200517.1998.14.camel@moss-spartans.epoch.ncsc.mil>
	 <ogtodi14r03.fsf@oolong.mitre.org>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 15:05:26 -0400
Message-Id: <1185303926.16598.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-24 at 14:05 -0400, John D. Ramsdell wrote:
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
> > Fix type mismatch in string_to_security_class, produces seg fault on x86_64.
> > For https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249038
> 
> ...
> > -		size_t value;
> > +		unsigned int value;
> ...
> >  
> > -		if (sscanf(buf, "%u", (unsigned int *)&value) != 1)
> > +		if (sscanf(buf, "%u", &value) != 1)
> 
> There is another way to fix this bug.  You can leave the type as
> size_t, but use the C99 z modifier.  GCC supports the z modifier.

Sure, but the actual value is an unsigned int, not a size_t, so this is
the more correct fix.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
