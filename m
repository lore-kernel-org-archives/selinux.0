Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LISig9022147
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 14:28:45 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LIRk9P003735
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 18:27:46 GMT
Message-ID: <4512D9DA.4030608@hp.com>
Date: Thu, 21 Sep 2006 14:28:42 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org, sds@epoch.ncsc.mil,
        jmorris@redhat.com, tgraf@suug.ch
Subject: Re: [PATCH 1/6] NetLabel: correct improper handling of non-NetLabel
 peer contexts
References: <20060921165703.251871000@hp.com> <20060921170335.013411000@hp.com> <Pine.LNX.4.64.0609211406030.7534@d.namei>
In-Reply-To: <Pine.LNX.4.64.0609211406030.7534@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 21 Sep 2006, paul.moore@hp.com wrote:
> 
> 
>>Fix a problem where NetLabel would always set the value of 
>>sk_security_struct->peer_sid in selinux_netlbl_sock_graft() to the context of
>>the socket, causing problems when users would query the context of the
>>connection.  This patch fixes this so that the value in
>>sk_security_struct->peer_sid is only set when the connection is NetLabel based,
>>otherwise the value is untouched.
> 
> I'll let Thomas comment on the Netlink changes, as he's been working with 
> you on them.

Hey, third times the charm right?

 ;)

> These changes otherwise seem ok.  How much testing has this had with and 
> without Netlabel enabled?

Joshua Brindle started a thread on the SELinux list which uncovered at
least two problems that I am aware of, one with NetLabel overriding the
peer's context and one with IPsec labeling returning the context from
the wrong SA (I may have the details of this wrong, Venkat posted about
this in the same thread).  This patch correct the NetLabel problem and
was tested using the simple reproducer provided by Joshua; I tested both
on a NetLabel'd and non-NetLabel'd connection and the results were
correct.  I have also tested this patch with the getpeercon() enabled
version of xinetd in FC/Rawhide; when configured to use labeled
connections and used with NetLabel the daemon is spawned with the
correct MLS label, when configured to use labeled connections and
NetLabel is not used xinetd reports an error because getpeercon()
returns an error (desired behavior as there is no network label present
for the connection).

If there is some other test you would like to see run let me know and
I'll give it a shot and report the results.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
