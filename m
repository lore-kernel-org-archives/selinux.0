Subject: Re: Added is_context_configurable function
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <41E43784.2060406@redhat.com>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
	 <41E43784.2060406@redhat.com>
Content-Type: text/plain
Message-Id: <1105475738.20566.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 11 Jan 2005 15:35:38 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-11 at 15:31, Daniel J Walsh wrote:
> Using your method for every file he puts under /var/www/html now needs 
> him to write some special rule into file_context file?
> I don't like the usability of that.

No, you just add contexts to the end of the existing entries in
apache.fc where you want to support alternatives.  Only case where you
need a new entry is if you want to allow alternatives for a smaller set
than is presently covered by some pathname regex.

> I was going to put in a -F qualifier which would allow you to override 
> the configurable_types.  Also
> using -v -v will show you all files with configurable types
> 
> restorecon -R -v /var
> Quietly leave configurables
> 
> restorecon -R -v -v /var
> Would leave configurable entries but report them
> 
> restorecon -F -R -v /var
> Will work like current restorecon works.

configurable -> customizable or alternatives

In practice, I would expect that admins will only use the default form
(i.e. leave them intact and not report them) unless they encounter some
other policy error, and that could prove fatal, e.g. if some sensitive
file becomes mislabeled and accessible to untrusted processes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
