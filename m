Subject: Re: [SEPOL] Remove defrole from sepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <437EBD3A.7090606@cornell.edu>
References: <437EBD3A.7090606@cornell.edu>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 14:27:36 -0500
Message-Id: <1133206056.348.220.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-11-19 at 00:50 -0500, Ivan Gyurdiev wrote:
> This patch removes defrole from sepol, because it does not belong there, 
> and it's just plain wrong. The default role is not preserved in the 
> binary policy - therefore it can only exist in semanage (unless we 
> change the policy format to contain it). This simplifies user_record.c.
> 
> It also updates del_role to have a void return type, as it can no longer 
> fail.
> 
> Now we need to add the labeling prefix back into semanage somehow.

Merged as of libsepol 1.9.41 and libsemanage 1.3.58.

handle is still present in def_role interface.  Not sure whether you
want it dropped from both sepol and semanage interfaces or just the
sepol interface, even though it is void in both (non-error reporting?).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
