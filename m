Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95Mlhs7006236
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 18:47:43 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95MkUqJ010518
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 22:46:31 GMT
Date: Thu, 5 Oct 2006 17:47:34 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linda Knippers <linda.knippers@hp.com>, Joshua Brindle <method@gentoo.org>,
        paul.moore@hp.com, selinux@tycho.nsa.gov, redhat-lspp@redhat.com,
        vyekkirala@TrustedCS.com, jmorris@namei.org,
        Joy Latten <latten@austin.ibm.com>, eparis@parisplace.org,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
Message-ID: <20061005224734.GA28520@w-m-p.com>
References: <4522EB42.9070502@hp.com> <20061003233848.21938.qmail@web36606.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061003233848.21938.qmail@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 03, 2006 at 04:38:48PM -0700, Casey Schaufler wrote:
> --- Linda Knippers <linda.knippers@hp.com> wrote:
> > It has a requirement to be able to audit all modifications of the
> > values of security attributes, so we can audit a bunch of syscalls
> > that do that (chmod, chown, setxattr, ...).  Relabeling files would
> > definitely count and be covered.  There's also a requirement about
> > auditing changes to the way data is imported/exported, so this is
> > where the networking stuff comes in.  I don't know about domain
> > transitions.
> 
> I think you would have trouble arguing that a domain transition is not
> a change in the security state of the system. For the evaluations I
> worked auditing was required for any change to uids, gids,
> capabilities, sensitivity, integrity, or any other security relevent
> attribute.

Yes, it is a change in the process security state.

Domain transitions are auditable already - dynamic transitions through
the auditallow rules on /proc/$PID/attr/*, and automatic transitions by
putting filesystem watches on the *_exec_t binaries you're interested in.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
