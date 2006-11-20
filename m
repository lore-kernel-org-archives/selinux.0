Subject: Re: anyway to reverse a dontaudit rule?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joy Latten <latten@austin.ibm.com>, redhat-lspp@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <455B8F79.4020504@mentalrootkit.com>
References: <1163616448.17737.368.camel@faith.austin.ibm.com>
	 <455B8F79.4020504@mentalrootkit.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 13:59:09 -0500
Message-Id: <1164049149.13758.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-15 at 17:06 -0500, Karl MacMillan wrote:
> Joy Latten wrote:
> > Is there a way to reverse a dontaudit rule without having to
> > modify and recompile base policy? 
> > I need to see the audit message to help determine what permissions
> > are being denied for a particular application.
> > 
> 
> No - that is why the enableaudit.pp base policy is provided in 
> /usr/share/selinux/[policyname]/enableaudit.pp. Install that with:
> 
> semodule -b path_to_enableaudit
> 
> and you should see all denials.

...that would have been suppressed by dontaudit rules in the base
module.  But not dontaudit rules in non-base modules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
