Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HFwQ5w022638
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 11:58:26 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6HFwOHX018375
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 15:58:25 GMT
Message-Id: <20060717155224.060020000@hp.com>
Date: Mon, 17 Jul 2006 11:52:24 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: davem@davemloft.net, sds@epoch.ncsc.mil, jmorris@redhat.com,
        pratt@argus-systems.com
Subject: [PATCH 0/7] Updated patchset w/James' comments
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some changes in the patchset based on James Morris' comments over the weekend, in
addition I rebased the patchset against 2.6.18-rc2.  For those who want/need some
background and missed my posting last week I have pasted the announcement below.

Once again, please consider this patchset for inclusion into the 2.6.19 kernel.

Thanks.

--
I am posting this patchset for consideration and inclusion into the 2.6.19
kernel, it is against 2.6.18-rc1 [now rebased against 2.6.18-rc2].

This patchset introduces NetLabel, a implementation of explicit packet
labeling (i.e. CIPSO), to the Linux kernel.  NetLabel has been designed to
have as minimal an impact on the base networking stack as possible; this
includes both code changes as well as performance.  I, as well as many others
who have posted to various lists on earlier NetLabel patches, believe that an
interoperable form of labeled networking is important for Linux's success in
the Trusted OS arena currently being dominated by commercial UNIX systems.
DaveM, I know you have previously posted that you feel CIPSO does not belong
in the Linux kernel on principle, however, I'm hoping the arguments posted
in response have softened your position ...

Earlier versions of this patchset have been posted to the netdev, SELinux,
LSM and RH-LSPP mailing lists over the past couple of months.  It now contains
several rounds of comments and has been tested on a variety of architectures
by people on the RH-LSPP mailing list over the course of the last several
weeks.

If accepted into the mainline kernel, both HP and myself pledge to maintain
this code.

 - Notes on Performance

This past week there was a thread on the RH-LSPP list where the performance of
the NetLabel patch was measured and discussed using the 2.6.17 kernel.  A copy
of the discussion can be found here:

 * http://www.redhat.com/archives/redhat-lspp/2006-July/msg00063.html

With the conclusion being that performance should not be an issue.

Unfortunately the vanilla 2.6.18-rc1 kernel has problems on the two machines
I use for performance testing so I am not currently able to update the
NetLabel performance numbers for 2.6.18-rc1.

 - Notes on Interoperability Testing

The NetLabel CIPSO implementation has been tested against Trusted Solaris and
HP-UX CMW without problems.

 - Instructions for Testing

For those of you wishing to test this patchset you will need the latest
release of the netlabel_tools tarball found here:

 * http://free.linux.hp.com/~pmoore/projects/linux_cipso

You also may want to make use of the "toy policy module" for SELinux which has
been posted to the RH-LSPP mailing list, the archived message can be found
here:

 * http://www.redhat.com/archives/redhat-lspp/2006-June/msg00243.html

Thanks.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
