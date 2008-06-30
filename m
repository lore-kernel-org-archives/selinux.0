Subject: Re: rawhide audit2allow problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <10143820806251203g139e16d7pf00566d7c6cd9433@mail.gmail.com>
References: <cadfc0e40806251123md6cebeak9a83cd68559bf55c@mail.gmail.com>
	 <10143820806251203g139e16d7pf00566d7c6cd9433@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 30 Jun 2008 09:17:13 -0400
Message-Id: <1214831833.22447.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-06-25 at 15:03 -0400, Karl MacMillan wrote:
> On Wed, Jun 25, 2008 at 2:23 PM, Xavier Toth <txtoth@gmail.com> wrote:
> > I updated my rawhide box and now I getting the following error:
> >
> > [root@localhost ~]# cat /var/log/audit/audit.log | audit2allow
> > Traceback (most recent call last):
> >  File "/usr/bin/audit2allow", line 344, in <module>
> >    app.main()
> >  File "/usr/bin/audit2allow", line 338, in main
> >    self.__output()
> >  File "/usr/bin/audit2allow", line 314, in __output
> >    g.add_role_types(self.__role_types)
> > AttributeError: PolicyGenerator instance has no attribute 'add_role_types'
> >
> 
> This looks like audit2allow has my recent patch but not sepolgen. Not
> certain how that could happen since they appear to be part of the same
> rpm. Dan - any ideas?

Both the audit2allow and sepolgen diffs have now been merged upstream.
I'm assuming that no changes were made after the posted versions of the
patches; let me know if any further changes were made in the Fedora
packages.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
