Subject: Re: [ SEMANAGE 4 ] Order-preserving file dbase
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <436946FB.8060802@cornell.edu>
References: <43694616.3000002@cornell.edu>  <436946FB.8060802@cornell.edu>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 08:32:35 -0500
Message-Id: <1131024755.23420.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-02 at 18:08 -0500, Ivan Gyurdiev wrote:
> Is the policydb order preserving? If I write a policydb, and read it 
> back in, is the linked list of port contexts ordered the same way?

Yes.  More generally, policydb_read/write should be stable.

checkpolicy -M -o policy.20.2 -b policy.20
cmp policy.20 policy.20.2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
