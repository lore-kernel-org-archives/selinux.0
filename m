Subject: Re: Latest policycoreutils patch
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@gentoo.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45017F51.80200@gentoo.org>
References: <45001F1A.3080004@redhat.com>  <45017F51.80200@gentoo.org>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 10:55:10 -0400
Message-Id: <1157727310.21235.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-08 at 10:33 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > For some reason this did not go out last week.
> >
> > More translations.
> >
> > Change all python to use /usr/bin/python -E, to make it a little bit 
> > harder to muck with.
> >
> > Have newrole ignore sigpipe so it gives correct error message when 
> > flooded with 4000 character security context.
> >
> > Add -i qualifier to restorecon to tell it to ignore files that do not 
> > exist.  This fixes a problem in
> > fixfiles -R rpmlint restore
> >
> I'm not sure about this. Most other commands don't have a feature like 
> this (if they do its generally -f anyway, like rm -f ) and it seems like 
> fixfiles should be interpreting the error correctly instead of ripping 
> the error passing out of restorecon.

I don't think the feature is objectionable. It is directly analogous to
'rm -f' though (both continue without the flag but change the error
reporting), so changing the flag to -f is fine with me.

> > Which could hand restorecon files that do not exists and restorecon 
> > prints ugly warnings.
> >
> why not a -q then? I think it should still return a proper error code 
> but it doesn't have to spam the 

I think that the meaning of the flag is to change whether or not a
nonexistent file is an error - which is a valid semantic that makes
scripting easier. So not returning an error code or printing a warning
makes sense (which also matches the 'rm -f' behavior).

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
