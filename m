Subject: Re: Groups in the alternative user solution
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: kmacmillan@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1119980076.4806.23.camel@celtics.boston.redhat.com>
References: <1119980076.4806.23.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 15:44:06 -0400
Message-Id: <1119987846.22225.222.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-06-28 at 13:34 -0400, Ivan Gyurdiev wrote:
> So, how will groups work.
> 
> In particular,
> 
> a user belongs to multiple groups, each of which
> may have a selinux user mapping, in addition to
> the user herself possibly having a corresponding
> selinux user. Also, there's the default mapping.
> 
> - How should the selection work?
> - What would be the useradd interface for mapping
> a user to a selinux user?
> - What would be the interface for mapping a group
> to a selinux user?

I'd actually suggest that we not try to map Unix/Linux groups to SELinux
users at all, and require explicit Linux user -> SELinux user mappings.
Unix groups and SELinux user identities serve very different purposes,
and I can't see a good reason to link them together (and definite danger
in doing so).  Better to require them to manage that mapping
separately.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
