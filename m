From: Steve Grubb <sgrubb@redhat.com>
To: russell@coker.com.au
Subject: Re: missing avc message field names
Date: Thu, 1 Feb 2007 06:40:11 -0500
Cc: Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        James Antill <jantill@redhat.com>, linux-audit@redhat.com,
        ewalsh@tycho.nsa.gov, selinux@tycho.nsa.gov
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com> <45C02948.9090607@tresys.com> <200702010959.41511.russell@coker.com.au>
In-Reply-To: <200702010959.41511.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702010640.12158.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 31 January 2007 17:59, Russell Coker wrote:
> Maybe there should be an option to have auditd write a binary log file as
> well as either a text log file or logging via syslog?

This should  be possible. The audit event dispatcher typically has had a 
plugin that relays audit events to syslog. It will likely be a little while 
before there are binary formatted logs. I guess my message is really that you 
might not want to assume that the site will have text based logs for user 
support. Text logs are not being deprecated. Its that there will be more 
options soon.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
