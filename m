Subject: Re: Latest policycoreutils patch
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45001F1A.3080004@redhat.com>
References: <45001F1A.3080004@redhat.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 10:00:05 -0400
Message-Id: <1157724005.21235.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-07 at 09:31 -0400, Daniel J Walsh wrote:
> For some reason this did not go out last week.
> 
> More translations.
> 

Can you send these as separate patches in the future - it would make the
review easier.

> Change all python to use /usr/bin/python -E, to make it a little bit 
> harder to muck with.
> 
> Have newrole ignore sigpipe so it gives correct error message when 
> flooded with 4000 character security context.
> 
> Add -i qualifier to restorecon to tell it to ignore files that do not 
> exist.  This fixes a problem in
> fixfiles -R rpmlint restore
> 
> 
> Which could hand restorecon files that do not exists and restorecon 
> prints ugly warnings.
> 
> restorecond init script description needs line continuation marks to 
> make system-config-services happy.
> 

Acked-by Karl MacMillan <kmacmillan@mentalrootkit.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
