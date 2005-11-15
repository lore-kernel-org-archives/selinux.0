Subject: Re: [ SEMANAGE ] Stub pserver backend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <437907D7.8090002@cornell.edu>
References: <437907D7.8090002@cornell.edu>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 06:29:19 -0500
Message-Id: <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-14 at 16:55 -0500, Ivan Gyurdiev wrote:
> The purpose of stubs is to reduce size of future patches, and to point 
> to the right place to add functionality (if people want to help 
> implement it).
> 
> Changes: stub the pserver dbase backend.

I'd prefer to wait until we have a basic working implementation and a
user ready for merging.  Posting stubs or function prototypes to the
list as examples is fine, but I don't see much value in merging them.
It was ok for early development of libsemanage in order to build up
infrastructure and allow early collaboration/feedback, but I'd prefer to
move to merging actual implementations now.  I'd especially like to see
sample users (even just dummy test programs) that allow the code to be
trivially exercised along with the submissions to help put it in
context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
