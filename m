Subject: Re: [ SEPOL 3 ] Improve/fix sepol_user_set_roles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <4365FA41.8010302@cornell.edu>
References: <4365FA41.8010302@cornell.edu>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 11:11:11 -0500
Message-Id: <1130775071.22731.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-31 at 06:04 -0500, Ivan Gyurdiev wrote:
> - fix set_roles to properly handle num_roles = 0
> - simplify a bit...

Merged all 5 patches (record interfaces, dbase flush, common database,
record bugfixes, set roles) as of libsepol 1.9.34 and libsemanage
1.3.39.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
