From: Steve Grubb <sgrubb@redhat.com>
To: russell@coker.com.au
Subject: Re: semanage patch
Date: Sat, 15 Apr 2006 09:05:28 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
References: <200604142108.28814.russell@coker.com.au> <1145034536.18244.22.camel@moss-spartans.epoch.ncsc.mil> <200604151349.17126.russell@coker.com.au>
In-Reply-To: <200604151349.17126.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604150905.29038.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 14 April 2006 23:49, Russell Coker wrote:
> It might be worth considering splitting auditctl into two programs, one for
> adding/removing rules and another for the rest.

Auditctl is a focused application that does only one job - configure the 
kernel side of the audit system. It doesn't do anything else.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
