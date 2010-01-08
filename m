Subject: Re: [PATCH 13/13] semanage store migration script
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Caleb Case <ccase@tresys.com>, selinux@tycho.nsa.gov, csellers@tresys.com,
        kmacmillan@tresys.com, jbrindle@tresys.com
In-Reply-To: <1262964893.13162.27.camel@moss-pluto.epoch.ncsc.mil>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
	 <1261610760-4724-2-git-send-email-ccase@tresys.com>
	 <1261610760-4724-3-git-send-email-ccase@tresys.com>
	 <1261610760-4724-4-git-send-email-ccase@tresys.com>
	 <1261610760-4724-5-git-send-email-ccase@tresys.com>
	 <1261610760-4724-6-git-send-email-ccase@tresys.com>
	 <1261610760-4724-7-git-send-email-ccase@tresys.com>
	 <1261610760-4724-8-git-send-email-ccase@tresys.com>
	 <1261610760-4724-9-git-send-email-ccase@tresys.com>
	 <1261610760-4724-10-git-send-email-ccase@tresys.com>
	 <1261610760-4724-11-git-send-email-ccase@tresys.com>
	 <1261610760-4724-12-git-send-email-ccase@tresys.com>
	 <1261610760-4724-13-git-send-email-ccase@tresys.com>
	 <1261610760-4724-14-git-send-email-ccase@tresys.com>
	 <1262964893.13162.27.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Jan 2010 15:59:36 -0500
Message-ID: <1262984376.2093.14.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-01-08 at 10:34 -0500, Stephen Smalley wrote: 
> On Wed, 2009-12-23 at 18:26 -0500, Caleb Case wrote:
> > We created a migration script to ease the burden of transition from the
> > old libsemanage store layout to the new. The script will detect all the
> > stores in /etc/selinux using the old layout and convert them to the new
> > layout in /var/lib/selinux. It also allows you to specify the default
> > priority to use with -p and store to operate on with -s. After migration
> > the script by default will leave the old store unchanged, but can be
> > told to remove the old modules directory with -c.
> > 
> > Examples:
> > 
> > # Migrate all stores to the new layout.
> > migrate.py
> > 
> > Migrating from /etc/selinux/targeted/modules/active to /var/lib/selinux/targeted/active
> > Attempting to rebuild policy from /var/lib/selinux
> > 
> > # Migrate only the targeted store.
> > migrate.py -s targeted
> > 
> > Migrating from /etc/selinux/targeted/modules/active to /var/lib/selinux/targeted/active
> > Attempting to rebuild policy from /var/lib/selinux
> > 
> > # Migrate all, but install to priority 150.
> > migrate.py -p 150
> > 
> > Migrating from /etc/selinux/targeted/modules/active to /var/lib/selinux/targeted/active
> > Attempting to rebuild policy from /var/lib/selinux
> 
> I tried the following:
> semanage login -a -s user_u pi
> cp -a /etc/selinux /etc/selinux.orig
> install new userland
> migrate.py
> diff -ru /etc/selinux.orig /etc/selinux
> 
> The seusers entry for "pi" was dropped from the final seusers file in
> the rebuilt policy.
> 

I saw the same thing.  I added a new login, but it does not show up
after the migration with "semanage login -l" even though it is
in /var/lib/selinux/targeted/active/seusers and seusers.final.

booleans, ports, file contexts, and permissive domains all show up after
the migration, but there are some other issues.


1)  For booleans I am getting this error:

# semanage boolean --on git_system_use_cifs
Traceback (most recent call last):
  File "/usr/sbin/semanage", line 460, in <module>
    process_args(sys.argv[1:])
  File "/usr/sbin/semanage", line 407, in process_args
    raise ValueError(_("Invalid command") % " ".join(argv))
TypeError: not all arguments converted during string formatting



2)  Either the priority stuff doesn't work or I am doing something
wrong.  Shouldn't either of the following not display any modules since
they are all at priority 100?

"semodule -p 900 -l" or "semodule -p 900; semodule -l"

Both display all modules.


3)  I can't remove the permissive domain created before the migration
because the default priority level is 400, but the script put everything
at priority 100 and I don't know how to change the priority for
semanage.

# semanage permissive -d httpd_t
libsemanage.semanage_direct_remove_key: Unable to remove module
directory /var/lib/selinux/targeted/tmp/modules/400/permissive_httpd_t.
(No such file or directory).
/usr/sbin/semanage: Could not remove permissive domain httpd_t (remove
failed)


Ports and file contexts addition and removal seems to work fine.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
