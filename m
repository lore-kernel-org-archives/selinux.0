From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] collect security labels on user processes generating audit messages
Date: Thu, 16 Feb 2006 10:35:15 -0500
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@namei.org>
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com> <200602160956.20357.sgrubb@redhat.com> <1140103740.12655.79.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1140103740.12655.79.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602161035.15321.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 16 February 2006 10:29, Stephen Smalley wrote:
> Except for what other code should do about NULL pointers in output.  If
> they defer it to vsnprintf, they will end up with <NULL> in the output.
> So should Tim's code be checking for !ctx and outputting (null) there as
> well?

Yes, I think that would be consistent will all the other audit code.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
