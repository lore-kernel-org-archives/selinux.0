Subject: Re: libsepol - users [ Patch v. 0]
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118682905.24565.118.camel@moss-spartans.epoch.ncsc.mil>
References: <1118342870.30978.12.camel@dhcp83-8.boston.redhat.com>
	 <1118441058.7908.2.camel@dhcp83-8.boston.redhat.com>
	 <1118677251.24565.97.camel@moss-spartans.epoch.ncsc.mil>
	 <1118679035.9356.7.camel@dhcp83-8.boston.redhat.com>
	 <1118682905.24565.118.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 18:59:07 -0400
Message-Id: <1118703548.2604.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-13 at 13:15 -0400, Stephen Smalley wrote:
> On Mon, 2005-06-13 at 12:10 -0400, Ivan Gyurdiev wrote:
> > Yes, I understand the concern - I am not ignoring the issue.
> > I've tried to write it this way for efficiency, but if you prefer I
> > can duplicate the strings.
> 
> I suppose it depends on whether we expect any other users of these
> functions, and whether they are likely to only require such localized
> reference as well.

If I write a function to retrieve data from the config file, and
return it to the user, it would use this user_config structure...

> > Right, I fixed this, and now it actually compiles and runs :)
> 
> Ok, and I presume the static variables were moved to a .c file.

Yes... I mostly have it working... still some bugs to fix,
and must add more functions - set_roles, delete..

>   We
> should likely adjust the libsepol/src/Makefile to be consistent with the
> libselinux one so that we get stricter checking.

How so?

> > So, is genhomedircon wrong in that assumption? Should it be looking
> > at the <username> file instead?
> 
> The <username> or default_contexts would be more accurate, but then you
> have the problem of which default do you want, e.g. login, sshd, xdm,
> etc.  Could differ, e.g. root login via xdm might default to staff while
> root login on console might default to sysadm.

Hmmm... and here I thought this was going to be simple - one file
to deal with :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
