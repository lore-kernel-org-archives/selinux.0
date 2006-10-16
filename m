Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>,
        <sds@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Mon, 16 Oct 2006 13:29:55 -0500
Message-ID: <000501c6f151$147d5180$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1161019581.26428.18.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > >
> > > > allow apache_t  httpd_ipsec_t:association { polmatch };
> > > >
<snip>
>
> The above rule clearly shows a relationship between a domain(socket?)
> and a SPD entry.  It does not show a relationship between a packet and
> an association.

This relationship is implicit in that a packet from apache_t can only
use an association labeled apache_t. This would be currently shown in the
SELinux policy itself as:

allow apache_t apache_t:association { sendto };

We did talk about moving this "implicit" relationship into the kernel itself
essentially eliminating the association indirection for SAs.

>
> When analyzing policy, the labeling is ignored until the very
> end where
> you verify that the labeling fits the policy.   If you don't know what
> is in the SPD, you can not know which packets can go over the
> association by looking at the above rule.

Can you please explain this in terms of file_contexts in case I am missing
something here (you seem to be saying in the above para that: If you don't
know what's in the file_contexts db, you can not know which procs can write
to which files).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
