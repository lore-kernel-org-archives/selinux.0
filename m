Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9L4bkaF000322
	for <selinux@tycho.nsa.gov>; Sat, 21 Oct 2006 00:37:46 -0400
Received: from web36610.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9L4b2Fn027385
	for <selinux@tycho.nsa.gov>; Sat, 21 Oct 2006 04:37:02 GMT
Message-ID: <20061021043732.97455.qmail@web36610.mail.mud.yahoo.com>
Date: Fri, 20 Oct 2006 21:37:32 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
To: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <45378681.3000106@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Daniel J Walsh <dwalsh@redhat.com> wrote:

> ...  Since there is 
> an large number of sensitivities a user can log in
> as he will need to 
> key it in.

Existing systems allow the user a default MLS
value that is used (on a terminal) if none is
specified (e.g. just hit ENTER at the label
prompt).


> I though the sshd would happen automatically when
> you login via a secure 
> channel.  IE If I connect at TopSecret, I get
> TopSecret.

This is the usual behavior, but we're talking
about real deployments here, so there will
always be someone who wants (and is unwilling
to use/buy a system that won't allow her) to
long in at multiple labels across a single
level network. For your system to be popular
you need to provide the facility. Just consider
the admin who wants to log in at SystemHigh
to fix the broken network.

> I think gdm will require other features such that I
> launch terminals at 
> different sensitivity levels???
> 
> I think we should separate the TE Context selection
> from the Sensitivity 
> Selection, in order to satisfy the MLS problems.

>From the standpoint of someone who likes MLS
better than TE, I agree, but from the standpoint
of someone who hates to see mixed metaphores
I disagree.


> So it will not work on ptys?  Or are you thinking a
> boolean? I think it 
> will be strange for a user to have the app work
> differently depending on 
> how they logged in, but I guess this is another
> short coming of MLS.

I don't get how this is a shortcoming of MLS.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
