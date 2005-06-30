Subject: Re: Groups in the alternative user solution
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: casey@schaufler-ca.com, kmacmillan@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1120138022.32561.12.camel@celtics.boston.redhat.com>
References: <1119980076.4806.23.camel@celtics.boston.redhat.com>
	 <1119987846.22225.222.camel@moss-spartans.epoch.ncsc.mil>
	 <1119988230.7417.6.camel@celtics.boston.redhat.com>
	 <1120055713.3553.105.camel@moss-spartans.epoch.ncsc.mil>
	 <1120057525.17121.23.camel@celtics.boston.redhat.com>
	 <1120059525.3553.137.camel@moss-spartans.epoch.ncsc.mil>
	 <1120138022.32561.12.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:46:07 -0400
Message-Id: <1120139167.11798.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-30 at 09:27 -0400, Ivan Gyurdiev wrote:
> What about Casey's suggestion in this thread:
> 
> > 
> >     root:*:sysadm
> >     fred:wheel:wand
> >     *:wheel:staff
> >     *:*:normal
> > 
> > Fred would be in "wand" if only in group wheel,
> > in "normal" if in groups wheel and dev. Fun.
> 
> Not sure I understand... 
> So if Fred is in more groups other than wheel, 
> he maps to normal? What's the rationale for that?

I didn't understand the reasoning there either, particularly as we
aren't dealing with the effective GID but the entire authorized group
list for the user since we are only doing this once at login/su time.

> Controlling information disclosure? Does that * 
> take precedence to fred? What about conflicts? 
> This seems complicated..

I was originally thinking more along the lines of just selecting the
first matching entry (order-dependent), and group match just required
membership in the listed group, not an exact match (if you are going to
support group-based matching).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
