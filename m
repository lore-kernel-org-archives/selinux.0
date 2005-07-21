Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6L07HgA021811
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 20:07:17 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6L0219b028278
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 00:02:01 GMT
Date: Thu, 21 Jul 2005 01:02:43 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Ulrich Drepper'" <drepper@redhat.com>, selinux@tycho.nsa.gov,
   dwalsh@redhat.com
Subject: Re: SElinux nss/nscd service
Message-ID: <20050721000243.GA9713@lkcl.net>
References: <1121794572.4780.15.camel@celtics.boston.redhat.com> <200507191825.j6JIPsvx013481@gotham.columbia.tresys.com> <20050719215424.GA8851@lkcl.net> <1121815377.15541.15.camel@localhost.localdomain> <20050720095524.GK8851@lkcl.net> <1121857492.24646.21.camel@localhost.localdomain> <20050720113015.GO8851@lkcl.net> <1121885541.29587.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121885541.29587.19.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 20, 2005 at 02:52:21PM -0400, Ivan Gyurdiev wrote:

> Ok. Why was winbindd created? 
 
 :)

 for several reasons.

 1) to hide the awful mess of NT-style MSRPC-based function calls
    behind a drastically simplified API that basically involved sending
    uint8 opcode, char* username, char* this, char* that down a
    unix domain socket.

 2) to cache NT user and group information (e.g. group membership)
    for a period of several minutes (definable by the config file)
    due to the horribly large number of MSRPC-based function calls

    (rpcclient in samba tng implements Lsa, Samr _undocumented_
     win32 function calls...)

 3) to provide (and then hide - from those programs utilising the API!)
    a one-to-one _persistent_ mapping between NT users&groups
    and unix users&groups.

 so.

 the most crucial question to consider:

 - is the functionality behind the selinux "classes" likely to be
   complex or require cacheing of any kind?

 if the answer is a most definite "no" then yes, i agree with you:
 providing a daemon similar to winbindd isn't justifiable.

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
