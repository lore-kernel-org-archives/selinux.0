Subject: Re: Alternative user management approach
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Brian T. Sniffen" <bsniffen@mitre.org>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <d284qbn8w5a.fsf@jon-strange.mitre.org>
References: <200506241602.j5OG2Gqc016513@gotham.columbia.tresys.com>
	 <d284qbn8w5a.fsf@jon-strange.mitre.org>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 14:21:15 -0400
Message-Id: <1119637275.12865.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 14:09 -0400, Brian T. Sniffen wrote:
> "Karl MacMillan" <kmacmillan@tresys.com> writes:
> 
> > This makes the SELinux user more what we are calling a 'user
> > role'. For example, the policy could create 3 user roles with
> > different role authorizations (which become 'role capabilities'):
> 
> This seems like a great innovation.  But it does inherit one problem
> of generic user_u: there's no longer any MAC separating users.  If I'm
> a normal user, my shell has exactly the same security context as your
> shell---right?

Yes, but SELinux doesn't isolate those shells even if they have
different SELinux user identities if they have the same role and domain.
In fact, you only get real isolation in SELinux between domains (or MLS
levels, if using MLS).  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
