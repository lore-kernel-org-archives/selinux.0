Subject: Re: [ SEPOL ] Fix user record memory leak
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4357DB72.4090004@cornell.edu>
References: <4357DB72.4090004@cornell.edu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 10:09:38 -0400
Message-Id: <1129903778.27663.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-20 at 14:01 -0400, Ivan Gyurdiev wrote:
> Patch fixes a memory leak discovered by valgrind.

Merged as of libsepol 1.9.24.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
