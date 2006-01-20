Subject: Re: [SEMANAGE] Further bugfixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <43D0383C.8010404@cornell.edu>
References: <43D0383C.8010404@cornell.edu>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 10:21:25 -0500
Message-Id: <1137770485.3648.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-19 at 18:09 -0700, Ivan Gyurdiev wrote:
> Changelog:
> 
> - UI:
>       - fix Usage() for file contexts, rename some other things
>       - document -P --proto option
>       - "Failed to" -> "Could not" for consistency in error messages
> 
> - CLEANUP:
>        - remove statement with no effect in validate_level(), and some 
> unused variables
>        - make pychecker happy - don't shadow "dict", "type", and "range"
>        - rename p variable according to the object - only use p for ports
> 
> - IMPROVEMENTS:
>        - audit rc value for exists funtions, semanage_connect()
>        - free key and object on add/modify/delete
> 
> - BUGFIX:
>         - fix delete if/else bug I introduced with my last patch
> 
> Notes:
> - there's more memory management to be added, particularly disconnect() 
> and handle_destroy() need to be called as Joshua noted, list() probably 
> leaks lots of memory
> - role modifications still don't clear the previous roles
> - -R with multiple roles does not work
> - port ranges do not work

Thanks, merged along with Russell's patch and a separate patch from
Fedora Core CVS tree (which didn't touch semanage, just chcat.8 and
genhomedircon).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
