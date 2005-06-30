Subject: Re: Groups in the alternative user solution
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, kmacmillan@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <20050630155440.68314.qmail@web31602.mail.mud.yahoo.com>
References: <20050630155440.68314.qmail@web31602.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 12:06:28 -0400
Message-Id: <1120147588.1519.15.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > I didn't understand the reasoning there either,
> > particularly as we
> > aren't dealing with the effective GID but the entire
> > authorized group
> > list for the user since we are only doing this once
> > at login/su time.
> 
> I hope this has clarified the group vs.
> group list confusion.

Yes, I understand how it would work.
What's not clear is why you want to match on group
list as opposed to matching on group membership alone.
How is that helpful to the sysadmin - seems awfully 
fragile. What happens to this file if I add the user 
to another group?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
