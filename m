Subject: Re: [SEMANAGE] Fix fcontext comparator
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43BE9B0D.409@cornell.edu>
References: <43BE9B0D.409@cornell.edu>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 09:12:06 -0500
Message-Id: <1136815926.19934.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-06 at 11:30 -0500, Ivan Gyurdiev wrote:
> The comparator for fcontext is wrong.
> This should fix the problem Dan is having with the fcontext exists 
> function - let me know if it works.

Merged as of libsemanage 1.5.11.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
