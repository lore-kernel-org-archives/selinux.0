Subject: Re: [ SEMANAGE ] More dbase things
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4357D018.1000306@cornell.edu>
References: <4356F1B3.3060000@cornell.edu>
	 <1129820743.2375.396.camel@moss-spartans.epoch.ncsc.mil>
	 <4357D018.1000306@cornell.edu>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 13:58:42 -0400
Message-Id: <1129831122.2375.455.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-20 at 13:12 -0400, Ivan Gyurdiev wrote:
> > Let's get that theory turned into practice RSN...
> >   
> Allright, fine... let's add some more things.
> 
> Attach patch:
> - stubs dbase function set()
> - adds dbase function get_rtable(), and uses it to complete the merge 
> function in policy components
> - moves if0-ed code for merge and commit in the right place. and adds 
> attach/detach
> - adds error messages into dbase_policydb_cache
> - changes error code for all stubs from STATUS_SUCCESS to STATUS_ERR, so 
> that client won't crash, expecting that the function succeeded.
> 
> -----
> I can now begin to test functionality, and fix bugs (and implement 
> functions one by one, and add error messages).

Ok, merged (libsemanage 1.3.30) along with a couple of fixes for leaks
in the already existing libsemanage code (my fault).

BTW, you could simplify your dbase_policydb_cache() function to use
sepol_policydb_read() rather than sepol_policydb_from_image(); that
avoids the need to mmap it.  You just fopen() the file and associate the
FILE with a sepol_policy_file.  You can see similar policy file setup
for reading module packages in semanage_load_module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
