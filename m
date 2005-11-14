Subject: Re: [ SEPOL ] Add sepol_policydb_mls_enabled, organize map file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43765F0C.7020805@cornell.edu>
References: <43765D20.9070200@cornell.edu>  <43765F0C.7020805@cornell.edu>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 09:00:46 -0500
Message-Id: <1131976846.5415.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-11-12 at 16:30 -0500, Ivan Gyurdiev wrote:
> Ivan Gyurdiev wrote:
> > Changes:
> >
> > - adds new function to check if policydb is mls enabled (target is 
> > libsemanage: user/seuser/context parsers)
> ...but see... this isn't as trivial as it looks, because those parsers 
> don't have access to a policydb currently. There is no policydb object 
> available until commit time, where one is created.

Yes, I noticed that as well when I looked at this issue last week.  Note
however that we don't need an expanded policy for this test; we can
simply check the MLS-enabled status of the base module.  So possibly an
interface similar to sepol_module_package_info() could be added to
obtain the MLS-enabled status from the base module package, and then
that flag could be passed along to those parsers.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
