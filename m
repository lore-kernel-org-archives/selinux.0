Subject: Re: [ SEMANAGE ] Implement dbase_file_set, fix memleak
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43601468.60508@cornell.edu>
References: <43601468.60508@cornell.edu>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 09:49:09 -0400
Message-Id: <1130420949.18805.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-26 at 19:42 -0400, Ivan Gyurdiev wrote:
> Changes:
> - implement dbase_file_set
> - fix a memory leak in dbase_file_modify that I've been trying to find - 
> there are no more leaks that I know of

Merged both patches (query APIs, dbase_file_set) as of libsemanage
1.3.36.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
