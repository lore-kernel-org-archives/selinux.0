Subject: Re: [ SEMANAGE ] Completely split database per backend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, kmacmillan@tresys.com
In-Reply-To: <4341B8B8.2040608@cornell.edu>
References: <200510031420.j93EKZYs015323@gotham.columbia.tresys.com>
	 <1128352181.26285.108.camel@moss-spartans.epoch.ncsc.mil>
	 <43416D71.8030000@cornell.edu>
	 <1128363102.26285.186.camel@moss-spartans.epoch.ncsc.mil>
	 <43417C50.90306@cornell.edu>
	 <1128367296.26285.224.camel@moss-spartans.epoch.ncsc.mil>
	 <43418AFA.6070600@cornell.edu>  <4341B8B8.2040608@cornell.edu>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 10:57:52 -0400
Message-Id: <1128437872.26285.404.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-03 at 19:03 -0400, Ivan Gyurdiev wrote:
> This patch, does what we discussed off list:
> 
> - completely separates database per backend (all the functions are to be 
> implemented in the backend) - this involves pretty much all of 
> database.c into database_file.c. Caching things are now into the file 
> backend only, and I've dropped the cacheable stuff for simplicity.
> 
> - removes database.c. The backend now takes over the role of the 
> database (and is renamed dbase_t). The thing that associates the 
> database with its method table is still needed, but I've renamed it to 
> dbase_config_t (I'm sorry I keep renaming things, but that's what 
> happens when I need to redesign - hopefully there will be less need for 
> that in the future). I've also dropped its init function, and I just 
> store it as part of the handle (as opposed to storing a pointer), which 
> is simpler.
> 
> - fixes some bugs

Thanks, merged (along with the others as of libsemanage 1.3.8, depends
on libsepol 1.9.10).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
