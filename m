Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7PEqrLa024587
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 10:52:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7PEqqfF000394
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 14:52:52 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
        by jazzband.ncsc.mil  with ESMTP id h7PEqqHd000389 for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 14:52:52 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7PEqpdu020159
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 10:52:51 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h7PEqpFE020157
	for selinux@tycho.nsa.gov; Mon, 25 Aug 2003 10:52:51 -0400
Subject: Re: initrd vs initramfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Brian May <bam@snoopy.apana.org.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20030824235114.GA2962@snoopy.apana.org.au>
References: <20030824235114.GA2962@snoopy.apana.org.au>
Content-Type: text/plain
Message-Id: <1061822074.28086.434.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 25 Aug 2003 10:34:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-08-24 at 19:51, Brian May wrote:
> According to README from selinux-doc:
> 
> 4) The initial policy load has been moved into userspace, and is
> performed from an initrd (see the BUILDING AND INSTALLING
> instructions below).  We will likely migrate to using initramfs in the
> future for the initial policy.
> 
> Can anybody tell me the difference between the initrd system
> and the initramfs system?
> 
> So far the only answer I have got is that they are the same. The
> above text would imply that they are not the same though.
> 
> Sorry if this appears to be off-topic for this mailing list.

See Documentation/early-userspace/README in the linux-2.6.0-test4 tree.
The points of interest for us were:
1) The root filesystem image is linked into the kernel image, so a
tighter coupling of a kernel and its initial policy is possible,
2) The image is unpacked very early in the initialization process, so
the initial policy load could potentially be moved earlier, although
this would require further changes to the base kernel.

We aren't pursuing a migration to initramfs at the moment, although it
remains an area of interest in the future.  The existing initrd support
is sufficient for the initial policy load currently, and works for both
the 2.4-based and 2.6-based SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
