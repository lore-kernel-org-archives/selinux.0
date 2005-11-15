Subject: Re: [ SEPOL ] Add sepol_policydb_mls_enabled, organize map file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <437909EC.9080600@cornell.edu>
References: <43765D20.9070200@cornell.edu>  <43765F0C.7020805@cornell.edu>
	 <1131976846.5415.51.camel@moss-spartans.epoch.ncsc.mil>
	 <437909EC.9080600@cornell.edu>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 08:25:25 -0500
Message-Id: <1132061125.5415.340.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-14 at 17:04 -0500, Ivan Gyurdiev wrote:
> > Yes, I noticed that as well when I looked at this issue last week.  Note
> > however that we don't need an expanded policy for this test; we can
> > simply check the MLS-enabled status of the base module.  So possibly an
> > interface similar to sepol_module_package_info() could be added to
> > obtain the MLS-enabled status from the base module package, and then
> > that flag could be passed along to those parsers.
> >   
> Ok, so what about this patch? Is it merged or rejected?
> I can write another one to query the mls field without reading the whole 
> policy...

Ok, I've merged the module function and map file cleanup, without the
new interface, as of libsepol 1.9.40.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
