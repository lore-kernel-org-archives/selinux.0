Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA20hqXZ001909
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 19:43:52 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA20gVCC015840
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 00:42:31 GMT
Date: Mon, 1 Nov 2004 19:43:41 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Chad Hanson <chanson@TrustedCS.com>
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions - a seteuid parallel
In-Reply-To: <36282A1733C57546BE392885C06185924D91F1@chaos.tcs.tcs-sec.com>
Message-ID: <Xine.LNX.4.44.0411011939350.6248-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 1 Nov 2004, Chad Hanson wrote:

> The alternatives are to overprivilege the application which is not
> acceptable or to rewrite all of the applications before they can be used on
> this new platform. The latter is goal which can and should be achieved or
> time. Applications can streamlined and reorganized to fit into the modular
> framework and of cooperating applications.

All the more reason to make dynamic transitions an optional feature, so 
even MLS systems can eventually switch it off.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
