Subject: Re: mv and cp behavior.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1098115678.6101.30.camel@decepticon.boston.redhat.com>
References: <41712EEF.9090402@redhat.com>
	 <1098105487.27895.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1098115678.6101.30.camel@decepticon.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1098119648.27895.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 13:14:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-18 at 12:07, Colin Walters wrote:
> I raised this issue a while back.  I don't think it makes sense for me
> to update file_contexts for /var/www/myblog because I am not acting as a
> security administrator, although I do also have access to that role on
> the machine.  I'm using SELinux's ability to let a normal staff_r user
> relabel individual files as e.g. httpd_staff_script_exec_t.  The
> security administrator should not have to be involved in maintaining
> file_contexts for my discretionary control over my web content.

Ok, but if you were able to use chcon to set the type in the first
place, then you presumably are able to use it after moving files there
in Dan's example scenario.

> Fundamentally I still think that file_contexts should only be used to
> initialize the system; thereafter xattrs should be canonical.  However,
> if you recall I proposed an additional "user" xattr such as
> "user.selinux.customized" that would be set explicitly by tools like
> chcon so that an administrator could easily tell which labels had been
> deliberately changed.  We'd then have an option like '-f' to
> restorecon/setfiles to override that attribute, otherwise they would not
> relabel the file. 

I still don't like using the user namespace for that purpose.  I'd
prefer an attribute in the security namespace, with corresponding DAC
and MAC checks applied to the ability to set it or remove it.

> Alternatively perhaps setfiles/restorecon and the policy could become
> aware of "type classes"; e.g. httpd_staff_content_t,
> httpd_staff_script_ro_t, httpd_staff_script_exec_t would all be in the
> same class, and thus would not be relabeled from one member of the class
> to another by default by restorecon/setfiles.

Yes, this seems to be a common suggestion; alternatives for file
contexts.

> Not all users have access necessary to invoke matchpathcon.  And I still
> don't like using file_contexts for anything other than system
> initialization.

True, under strict policy.  But the installed file_contexts
configuration is already being used for other purposes, e.g. rpm, udev,
restorecon invocations from scripts and rpm %post scriptlets.

> Dan and I talked about this for a bit today, and one problem he brought
> up with mv doing prompting is that it has a large potential to break
> scripts.  
> 
> For Dan's scenario 1), I just don't see any good solutions right now.
> At least short of changing every script and program that invokes 'mv' to
> do 'mv -f'.  I guess you could argue they're already buggy since mv can
> potentially prompt in the DAC case too though...

I suppose it would be interesting to see how many of these mv's are
crossing type boundaries anyway...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
