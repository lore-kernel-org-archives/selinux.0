Subject: Re: Semanage/libsemanage seems to be broken.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43EBDC77.5000503@cornell.edu>
References: <43EBCED7.3040305@redhat.com> <43EBD634.1000708@cornell.edu>
	 <43EBDC77.5000503@cornell.edu>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 10:33:05 -0500
Message-Id: <1139844785.14253.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-09 at 19:21 -0500, Ivan Gyurdiev wrote:
> The attached patch should fix the problem - it treats seusers and 
> users_extra as optional sections. If they are not present, the 
> corresponding dbase is cleared. File contexts appear to be requred (no 
> len == 0 check).

Merged as of libsemanage 1.5.22.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
