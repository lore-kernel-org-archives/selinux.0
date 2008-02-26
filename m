From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH][RFC] Unify printk messgaes
Date: Wed, 27 Feb 2008 09:08:59 +1100
Cc: selinux@tycho.nsa.gov
References: <Xine.LNX.4.64.0802262049370.10387@us.intercode.com.au> <1204029408.2804.257.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1204029408.2804.257.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802270909.01223.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 26 February 2008 23:36, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> I don't think we can change the avc: prefix for avc messages given the
> impact on userspace tools that search for them.

Changing the userspace tools is easier than re-training all the people who are 
used to grepping for such messages and correcting all the documentation 
that's out there.  The advantage of changing "security:" messages is that 
normally people aren't that interested in them, the major change will be to 
log file analysis scripts which discard them.  "avc:" messages are of 
interest and are documented in many mailing list archives.

Of course this doesn't prevent us from changing the message, but if we are 
going to do so we should probably think carefully about all the messages that 
appear in log files and how they might be improved (do one big break instead 
of lots of medium sized ones).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
