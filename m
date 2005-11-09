Subject: Re: [ SETSEBOOL ] Cleanup patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <437181BA.6000806@cornell.edu>
References: <437181BA.6000806@cornell.edu>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 08:53:23 -0500
Message-Id: <1131544403.20591.476.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-08 at 23:57 -0500, Ivan Gyurdiev wrote:
> Error handling is different for libselinux interaction depending on -P. 
> Fix that by adding a new helper function. Also add a newline and change 
> some error messages. Recover the handle.h header #include (I don't think 
> we should rely on the boolean headers to include it).

thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
