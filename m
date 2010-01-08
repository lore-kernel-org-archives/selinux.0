Subject: Re: [PATCH 13/13] semanage store migration script
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: selinux@tycho.nsa.gov, csellers@tresys.com, kmacmillan@tresys.com,
        jwcart2@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <1261610760-4724-14-git-send-email-ccase@tresys.com>
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
Content-Type: text/plain
Date: Fri, 08 Jan 2010 10:34:53 -0500
Message-Id: <1262964893.13162.27.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-12-23 at 18:26 -0500, Caleb Case wrote:
> We created a migration script to ease the burden of transition from the
> old libsemanage store layout to the new. The script will detect all the
> stores in /etc/selinux using the old layout and convert them to the new
> layout in /var/lib/selinux. It also allows you to specify the default
> priority to use with -p and store to operate on with -s. After migration
> the script by default will leave the old store unchanged, but can be
> told to remove the old modules directory with -c.
> 
> Examples:
> 
> # Migrate all stores to the new layout.
> migrate.py
> 
> Migrating from /etc/selinux/targeted/modules/active to /var/lib/selinux/targeted/active
> Attempting to rebuild policy from /var/lib/selinux
> 
> # Migrate only the targeted store.
> migrate.py -s targeted
> 
> Migrating from /etc/selinux/targeted/modules/active to /var/lib/selinux/targeted/active
> Attempting to rebuild policy from /var/lib/selinux
> 
> # Migrate all, but install to priority 150.
> migrate.py -p 150
> 
> Migrating from /etc/selinux/targeted/modules/active to /var/lib/selinux/targeted/active
> Attempting to rebuild policy from /var/lib/selinux

I tried the following:
semanage login -a -s user_u pi
cp -a /etc/selinux /etc/selinux.orig
install new userland
migrate.py
diff -ru /etc/selinux.orig /etc/selinux

The seusers entry for "pi" was dropped from the final seusers file in
the rebuilt policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
