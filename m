Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <432FBD08.2050903@cornell.edu>
References: <432FBD08.2050903@cornell.edu>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 10:41:08 -0400
Message-Id: <1127313668.2550.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 03:40 -0400, Ivan Gyurdiev wrote:
> The attached patches replace the boolinfo structure with a record.
> They also fix improper use of DEBUG, which would cause corrupt error 
> messages.

I've merged these patches for now, although I'm still not clear yet on
whether the relaying of records/interfaces from libsepol to libsemanage
is desirable/necessary.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
