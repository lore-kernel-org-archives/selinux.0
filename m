Subject: RE: Access to the postgresql data files
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Igor Borisovsky <igor@datanaut.com>
Cc: Russell Coker <russell@coker.com.au>, fedora-selinux-list@redhat.com,
   SELinux@tycho.nsa.gov
In-Reply-To: <200406070902.i5792ah00920@alexru.adsl.kis.ru>
References: <200406070902.i5792ah00920@alexru.adsl.kis.ru>
Content-Type: text/plain
Message-Id: <1086609577.30328.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 07 Jun 2004 07:59:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-06-07 at 04:59, Igor Borisovsky wrote:
> I used macro full_user_role() for pgsql type.
> Then I corrected policy.conf file manually. So definitions for the new types
> looks like this:
> type pgsql_home_dir_t, file_type, home_dir_type, home_type,
> user_home_dir_type, user_home_type;
> type pgsql_home_t, file_type, home_type, user_home_type;
> (I removed sysadmfile attribute)
> And finally I launched 'make load'. After that /var/lib/pgsql is still
> accessible for sysadm_t.

Did you also disable the unrestricted_admin and unlimitedServices
tunables in tunable.te, as I said in my original reply?

To further elaborate on what Russell said, type attributes can be
associated with types and then used in allow rules (or other rules) to
apply a single rule to the set of all types with that attribute.  Hence,
simply grep'ing policy.conf isn't a reliable means of checking access. 
If you want to perform policy analysis, look at apol from the setools
and setools-gui packages.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
