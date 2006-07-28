Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6SHweuO000699
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 13:58:40 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6SHwarf008823
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 17:58:36 GMT
Message-ID: <44CA504C.6030207@hp.com>
Date: Fri, 28 Jul 2006 13:58:36 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
Subject: Re: [PATCH 2/7] NetLabel: core network changes
References: <20060717155224.060020000@hp.com> <20060717155822.315389000@hp.com> <20060728112426.GE14627@postel.suug.ch>
In-Reply-To: <20060728112426.GE14627@postel.suug.ch>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas Graf wrote:
> * paul.moore@hp.com <paul.moore@hp.com> 2006-07-17 11:52
> 
>>+ * NetLabel makes use of the Generic NETLINK mechanism as a transport layer to
>>+ * send messages between kernel and user space.  The general format of a
>>+ * NetLabel message is shown below:
>>+ *
>>+ *  +-----------------+-------------------+--------- --- -- -
>>+ *  | struct nlmsghdr | struct genlmsghdr | payload
>>+ *  +-----------------+-------------------+--------- --- -- -
>>+ *
>>+ * The 'nlmsghdr' and 'genlmsghdr' structs should be dealt with like normal.
>>+ * The payload is dependent on the subsystem specified in the
>>+ * 'nlmsghdr->nlmsg_type' and should be defined below, supporting functions
>>+ * should be defined in the corresponding net/netlabel/netlabel_<subsys>.h|c
>>+ * file.  All of the fields in the NetLabel payload should be aligned using
>>+ * the alignment functions provided.
>>+ *
>>+ */
>>+
>>+/*
>>+ * NetLabel NETLINK protocol
>>+ */
>>+
> 
> Is there a reason for not using any of the existing netlink and
> genetlink interfaces in any of your patches? It's all duplicated
> code.

I'm  a little confused by your comment, could you be a bit more
specific?  Are you basing your comment strictly on the text above?  If
so, the problem may be my poor excuse for documentation rather then my
poor excuse for implementation :)

I am using the generic netlink interface, in what I believe to be a
"correct" fashion - please correct me if I'm wrong.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
