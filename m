Subject: Re: Added is_context_configurable function
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <41E2FEF4.5070604@redhat.com>
References: <41E2FEF4.5070604@redhat.com>
Content-Type: text/plain
Message-Id: <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 11 Jan 2005 10:22:14 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-10 at 17:17, Daniel J Walsh wrote:
> This patch defines two functions.
> 
> is_context_configurable(scontext) 
> This returns if if the context is in the 
> /etc/selinux/*/contexts/configurable_contexts file.
> 0 If not and -1 on error.
> 
> Internally this calls get_configurable_context_list which returns a 
> contextarray of the contexts of that file.
> 
> I have also patched the policy makefile to populate that file, but 
> looking for all contexts marked as configurable.
> 
> Now I would like to use this function in restorecon/setfiles, so that by 
> default they will leave configurable contexts alone.

I think that in prior discussions of this functionality, we had
discussed allowing an optional list of alternative contexts at the end
of each entry in the file_contexts configuration, and having
setfiles/restorecon not change the context if the file already had any
context in that list, but still set the context to the first context
listed if the file lacked any context at all (e.g. initial labeling). 
I'm not sure I see the benefit of marking the types with an attribute in
the policy since you aren't defining any rules based on that attribute
or providing a separate configuration file from file_contexts.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
