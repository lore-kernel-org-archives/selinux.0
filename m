Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <432FBD08.2050903@cornell.edu>
References: <432FBD08.2050903@cornell.edu>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 15:06:26 -0400
Message-Id: <1127243186.14569.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 03:40 -0400, Ivan Gyurdiev wrote:
> The attached patches replace the boolinfo structure with a record.
> They also fix improper use of DEBUG, which would cause corrupt error 
> messages.

Hi,

How useful is it to wrap these libsepol interfaces with libsemanage?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
