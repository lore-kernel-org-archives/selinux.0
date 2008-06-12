Subject: Re: dynamic security class and access vector lookup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40806121205w3381c32fy9aab1aee1cdf97ce@mail.gmail.com>
References: <cadfc0e40806121138x3bb0996asda149528809d4598@mail.gmail.com>
	 <1213296527.17842.266.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40806121205w3381c32fy9aab1aee1cdf97ce@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 15:20:30 -0400
Message-Id: <1213298430.17842.297.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-06-12 at 14:05 -0500, Xavier Toth wrote:
> On Thu, Jun 12, 2008 at 1:48 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > On Thu, 2008-06-12 at 13:38 -0500, Xavier Toth wrote:
> >> I wasn't aware until yesterday that there was an API for looking up
> >> security classes (selinux_set_mapping, the name of which doesn't
> >> strike me as very intuitive). Can I also lookup the access vectors for
> >> a class, if so how?
> >
> > selinux_set_mapping() does that too.  dynamic discovery of classes and
> > permissions was discussed quite a bit on list.  XSELinux uses it, and so
> > does SE-Postgres.
> >
> > --
> > Stephen Smalley
> > National Security Agency
> >
> >
> 
> I see the posting of the patch but no discussion. Yesterday Eamon
> posted an example of setting the mapping of a security class but it
> didn't address perms. I have some python code where I'm calling
> selinux.avc_has_perm_noaudit and have been using hard coded values for
> the security class and perm. I'd like to fix this code but am not sure
> if this or some other capability I'm unaware of will do the trick.

See:
http://marc.info/?l=selinux&m=118114723416269&w=2

Then your code can use your own set of private definitions for class and
permission values that are just indices starting from 1, and the
libselinux avc will map them to the kernel/policy values automatically.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
