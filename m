Subject: Re: [SEMANAGE] Bugfixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <43C64D9E.4080009@cornell.edu>
References: <43C64D9E.4080009@cornell.edu>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:53:28 -0500
Message-Id: <1137160408.3445.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-12 at 05:37 -0700, Ivan Gyurdiev wrote:
> Various bugfixes and improvements for recent code:
> 
> - rename del_all -> clear, since I like that better
> - remove requirement to run cache() prior to clear (change spec, and 
> implementation)
>   (and stop running it in join, that's ridiculous)
> - BUGFIX: add clear pointer to activedb backend method table
> 
> - do not test for NULL record after record->split(), split is not 
> allowed to return NULL
> - remove old FIXME from fcontexts_local
> 
> - BUGFIX: clear user_extras (policy) dbase in apply_local_changes() 
> function. Otherwise previous changes are left over, and that's not what 
> we want - we want build from scratch. This is the equivalent of making a 
> new policydb, or the direct_api.c processing that rebuilds the 
> file_contexts file from the one in the package.

Merged the join prereq, implementation, user extra data part 2, and this
patch as of libsemanage 1.5.13.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
