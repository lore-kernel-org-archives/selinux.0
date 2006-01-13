Subject: Re: [SEMANAGE] Disallow overlap of local port ranges
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43C785BE.10300@cornell.edu>
References: <43C785BE.10300@cornell.edu>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:53:50 -0500
Message-Id: <1137160430.3445.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-13 at 03:49 -0700, Ivan Gyurdiev wrote:
> Hi, this patch disallows overlapping port ranges in the local store, in 
> the form of a commit validate run, where the ports are sorted and tested 
> for overlap. The patch will not allow any kind of overlap, not just 
> complete shadow. This was a feature requested by Joshua, since relying 
> on the add() order for precedence seemed non-intuitive. Also, I'm not 
> sure how useful overlapping ranges are to the local store - they seem 
> more useful in the base policy where you want to set a default range of 
> ports.

Merged as of libsemanage 1.5.14.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
