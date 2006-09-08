Message-ID: <45017F51.80200@gentoo.org>
Date: Fri, 08 Sep 2006 10:33:53 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <45001F1A.3080004@redhat.com>
In-Reply-To: <45001F1A.3080004@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> For some reason this did not go out last week.
>
> More translations.
>
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
I'm not sure about this. Most other commands don't have a feature like 
this (if they do its generally -f anyway, like rm -f ) and it seems like 
fixfiles should be interpreting the error correctly instead of ripping 
the error passing out of restorecon.
> Which could hand restorecon files that do not exists and restorecon 
> prints ugly warnings.
>
why not a -q then? I think it should still return a proper error code 
but it doesn't have to spam the console

> restorecond init script description needs line continuation marks to 
> make system-config-services happy.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
