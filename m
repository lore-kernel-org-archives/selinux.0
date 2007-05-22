Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4MCemRh007846
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 08:40:48 -0400
Received: from web51509.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4MCekRP015871
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 12:40:46 GMT
Date: Tue, 22 May 2007 05:39:56 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Question on networking accesses
To: Paul Moore <paul.moore@hp.com>, casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705212346.59212.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <827038.22839.qm@web51509.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I guess with SELinux you could think of it as the following:
>
> - process A (subject) writes to socket A1 (object)
> - socket A1 (subject) sends packet to compat_net/SECMARK (object)
>
>    packet traverses the ether (real magic)
>
> - socket B1 (subject) receives the packet via int/ext labels (object)
> - process B (subject) receives the data via socket B1 (object)

I think this is missing the access control decisions. First, the sender has to be
in a domain that allows a connect/sendto, the connection between domains must be
allowed by policy, and the receiver has to be in a domain that allows
listen/recvfrom. This is omitting any DAC restrictions, capability requirements,
and IPTables rules which have first vote on denying the activity. The access
control is mostly at the entry points to the transaction and not on a packet by
packet basis (except perhaps udp where every packet is an entry point to the
transaction).

-Steve


      ____________________________________________________________________________________Shape Yahoo! in your own image.  Join our Network Research Panel today!   http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
