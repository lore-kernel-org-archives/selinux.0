Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n84DrPML032226
	for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2009 09:53:25 -0400
Received: from e36.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n84DseGl002872
	for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2009 13:54:41 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n84DpXbS025691
	for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2009 07:51:33 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n84Dr1e0123212
	for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2009 07:53:03 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n84Dr0jr012839
	for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2009 07:53:01 -0600
Date: Fri, 4 Sep 2009 08:46:11 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [RFC PATCH 2/2] cr: debug security_checkpoint_header and
	security_may_restart
Message-ID: <20090904134611.GA11508@us.ibm.com>
References: <20090903222824.GB27377@us.ibm.com> <20090903222853.GA27556@us.ibm.com> <4AA0A3AE.9040106@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AA0A3AE.9040106@schaufler-ca.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Casey Schaufler (casey@schaufler-ca.com):
> Serge E. Hallyn wrote:
> > This patch, for debugging only, introduces a silly admin-controlled
> > 'policy version' for smack.  By default the version is 1.  An
> > admin (with CAP_MAC_ADMIN) can change it by echoing a new value
> > into /smack/version.
> >   
> 
> The scheme you have suggested is just one step off of completely
> acceptable for real. More detail below, but if you make the "version"
> a string instead of a number I'm happy with it. In particular, a
> string that would itself be a valid Smack label makes everything
> really simple.

Presumably at many sites the version will be a unique string not
used as a label anywhere else.  That's ok?

> It would take me a few days, but if you're not in a real hurry or
> you're lazier than I am (yeah, right) I could provide a patch that
> does it. Or, if I haven't been completely incomprehensible, you
> could do a revision.

Heh, I'm in no hurry.  I'll mark this to do midway next week, if
you haven't gotten around to it first.  Thanks!

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
