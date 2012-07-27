Message-ID: <1343408458.17570.69.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Could we set them as "mlstrustedsubject"?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <bill.c.roberts@gmail.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        "Craig, Robert P."
 <rpcraig@tycho.ncsc.mil>
Date: Fri, 27 Jul 2012 13:00:58 -0400
In-Reply-To: <1343399960.17570.52.camel@moss-pluto.epoch.ncsc.mil>
References: 
	<CAO-4OdGJhr3H7Q8uJz0JWgEekHqo=K8gS3aU_si__f4y5dzPxQ@mail.gmail.com>
	 <1343399960.17570.52.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 10:39 -0400, Stephen Smalley wrote:
> On Thu, 2012-07-26 at 14:25 -0700, Haiqing Jiang wrote:
> > Hi, all
> > 
> > 
> > Currently I am testing Android CTS in SEAndroid. I find several
> > denials are related to MLS constraints. The key-signed apps, like
> > "platform_app", "release_app",
> > "browser_app", "shared_app" and "media_app", need to open
> > app_data_file. But because of MLS, they cannot do that. So, could we
> > sign them as mlstrusted? 
> > Currently only daemons are set "mlstrustedsubject". Do you have any
> > ideas? Or the better solutions to solve the denials? 
> 
> This would mean that SELinux would no longer be enforcing per-app
> process and file isolation for the platform (where by platform, I mean
> any of the apps signed by build keys, i.e. platform|release|shared|
> media) apps.  You would be back to relying on DAC for per-app separation
> among the platform apps.
> 
> Further, I don't think that this change alone would solve the general
> problem, as the platform app data files will still be labeled with
> per-app categories and thus I expect you'll see the same problems arise
> for the third party apps trying to access files created by the platform
> apps (passed to them by open file descriptor for private files or by
> pathname for shared prefs over Binder IPC).
> 
> So I think in addition to making them mlstrustedsubjects, we would need
> to introduce a new file type for the platform app data files, make that
> type a mlstrustedobject, assign that type to the platform apps in
> seapp_contexts, and remove levelFromUid=true from those entries.  That
> still means that SELinux will no longer be enforcing per-app isolation
> for the platform apps, only for third party apps, but now the third
> party apps can be allowed to read/write files created by the platform
> apps and passed to them over Binder IPC.  Attached is a patch that
> demonstrates this approach.  It only defines a single new file type for
> all of the platform apps; we could alternatively introduce a separate
> type per domain, but that only makes sense if they don't end up needing
> access to each other's data types.  Truly testing this patch requires
> testing some third party apps, not just the platform apps, as you won't
> see any MLS restrictions come into play now without third party apps.

I've applied this patch to our sepolicy tree, but we can revert it or
change it if we decide it isn't the best solution.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
