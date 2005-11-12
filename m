From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Should this be a dontaudit or an allow in targeted.
Date: Sat, 12 Nov 2005 20:49:29 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
References: <43663282.8030707@redhat.com> <1130774532.22731.118.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1130774532.22731.118.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200511122049.40859.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 01 November 2005 03:02, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On a related note, it has been suggested (on lspp) that we might need
> dontaudit/auditallow rules based on MLS level.  Is that true, or can we
> just leverage the existing TE-based rules to control such auditing based
> on type (which typically gives us finer granularity anyway)?

It seems sensible to have audit controlled on the same basis as access.  So 
for any criteria on which access can be allowed/denied it should be possible 
to base audit decisions on the same criteria.

auditconstrain/mlsauditconstrain?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
