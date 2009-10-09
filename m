Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n99MVLus005045
	for <selinux@tycho.nsa.gov>; Fri, 9 Oct 2009 18:31:21 -0400
Received: from e32.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n99MWxvC025225
	for <selinux@tycho.nsa.gov>; Fri, 9 Oct 2009 22:33:00 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n99MQOPX027876
	for <selinux@tycho.nsa.gov>; Fri, 9 Oct 2009 16:26:24 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n99MVC5Q186288
	for <selinux@tycho.nsa.gov>; Fri, 9 Oct 2009 16:31:14 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n99MVBlI021882
	for <selinux@tycho.nsa.gov>; Fri, 9 Oct 2009 16:31:12 -0600
Date: Fri, 9 Oct 2009 17:31:11 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 4/4] cr: add selinux support (v6)
Message-ID: <20091009223111.GA7951@us.ibm.com>
References: <20091009205552.GA5778@us.ibm.com> <20091009205731.GC5823@us.ibm.com> <4ACFA7F1.6060209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ACFA7F1.6060209@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Daniel J Walsh (dwalsh@redhat.com):
> On 10/09/2009 04:57 PM, Serge E. Hallyn wrote:
> I think you need to be careful with this.  We do not want the process to
> start with the same MCS Label as when it stopped in case some other virtual
> machine has grabbed the MCS Label.  When the image is taken down it should
> give up probably give up its labels and allow the system to relabel to a
> known state.  When it starts the image again, new labels should be selected
> and set on disk and the process resumed with the new label.

With this patchset, the default behavior remains to simply run the
restarted task in whatever context is calculated by the usual TE
rules (i.e. current context unless the type of the 'restart' program
was an entry type to some domain and a domain transition was requested
or automatic).  The request to restore checkpointed labels is done with
a special flag.

What you actually are suggesting is the ability to make fine-grained
changes to some of the checkpointed labels, but to still restore
the checkpointed labels (with changes).  I think it is pretty
generally accepted that such things should be done by editing the
checkpoint image in userspace.  A pretty simple program could
run through the image looking for CKPT_HDR_SEC fields and
change the MCS labels where appropriate.

I haven't written such a program (or used MCS), but if you like
I'll certainly write it and I suspect Oren would be happy to have
it in user-cr/ (where the checkpoint and restart programs live) as
an example of how to make such substitutions generally.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
