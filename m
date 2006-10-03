Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93Nd41e030442
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 19:39:04 -0400
Received: from web36606.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k93NcTlM003195
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 23:38:29 GMT
Message-ID: <20061003233848.21938.qmail@web36606.mail.mud.yahoo.com>
Date: Tue, 3 Oct 2006 16:38:48 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
To: Linda Knippers <linda.knippers@hp.com>, Joshua Brindle <method@gentoo.org>
Cc: paul.moore@hp.com, Joy Latten <latten@austin.ibm.com>,
        redhat-lspp@redhat.com, vyekkirala@TrustedCS.com, jmorris@namei.org,
        selinux@tycho.nsa.gov, eparis@parisplace.org,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <4522EB42.9070502@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Linda Knippers <linda.knippers@hp.com> wrote:


> It has a requirement to be able to audit all
> modifications of the
> values of security attributes, so we can audit a
> bunch of syscalls
> that do that (chmod, chown, setxattr, ...). 
> Relabeling files
> would definitely count and be covered.  There's also
> a requirement about
> auditing changes to the way data is
> imported/exported, so this is where
> the networking stuff comes in.  I don't know about
> domain transitions.

I think you would have trouble arguing that
a domain transition is not a change in the
security state of the system. For the evaluations
I worked auditing was required for any change
to uids, gids, capabilities, sensitivity,
integrity, or any other security relevent
attribute.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
