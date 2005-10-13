Subject: Re: [ SEPOL ] [ SEMANAGE ] Debug v3, some database things
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <434E38C2.9030602@cornell.edu>
References: <434CC592.70001@cornell.edu>
	 <1129132332.3308.288.camel@moss-spartans.epoch.ncsc.mil>
	 <434D35B1.7060409@cornell.edu>
	 <1129133080.3308.294.camel@moss-spartans.epoch.ncsc.mil>
	 <434D3D33.90104@cornell.edu>  <434E38C2.9030602@cornell.edu>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 13:11:16 -0400
Message-Id: <1129223476.26188.244.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-13 at 06:36 -0400, Ivan Gyurdiev wrote:
> ...resending patch again...

Ok, merged along with fix patch and corresponding update to
policycoreutils (semodule) for the removal of semanage_strerror.
I left the remaining portion of the meta note comment in handle.h
intact, only pruning the part about strerror.  There were two rejects
against the current tree, but I merged by hand.

Merged as of libsepol 1.9.16, libsemanage 1.3.12, policycoreutils
1.27.8.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
