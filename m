Subject: Re: [ SEMANAGE ] Stub kernel booleans API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <437903B8.4040701@cornell.edu>
References: <437903B8.4040701@cornell.edu>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 06:25:42 -0500
Message-Id: <1132053942.5415.277.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-14 at 16:38 -0500, Ivan Gyurdiev wrote:
> I'm not sure if I'll be layering those on top of dbase... maybe..

I don't think "kernel" is what you want here, as the real distinction is
between persistent local modifications to booleans and
runtime/active/current modifications to booleans.  The booleans
themselves may be kernel or userspace policy constructs in either case.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
