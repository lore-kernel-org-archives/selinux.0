Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6KGkOfp019250
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 12:46:24 -0400
Received: from smtpq2.tb.mail.iss.as9143.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6KGlChp026453
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 16:47:12 GMT
From: "Remmolt G. Zwartsenberg" <remmolt@zwartsenberg.eu>
To: "'Christopher Pardy'" <cpardy@redhat.com>
Cc: <selinux@tycho.nsa.gov>
References: <4A648075.3090402@redhat.com>
Subject: RE: adding human understandable, and translatable description support to selinux
Date: Mon, 20 Jul 2009 19:04:50 +0200
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAHIjB2PXQghIlQQiFm+xEwPCgAAAEAAAAKNMyUeOW2pIuEu62kh7rNEBAAAAAA==@zwartsenberg.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01CA096C.F5C7F240"
In-Reply-To: <4A648075.3090402@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01CA096C.F5C7F240
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Christopher,

I do have some x-windows, Apple OS-X Tiger and Microsoft Gui Runlibs in our
32 and 64 bit widget repository.

According to the General's opinion, Colonels have no say in this. Another
thing is the needs of the Quartermaster, who has her own issues in keeping
the cockroaches out of the pantries and field kitchens.

Do we need a license to practise this art? Or do we discuss ballistics with
kim young il's spouse. I remember at the Hubble Spacewebcam, we could not
mount '/' NFS as the root file system. 

Yours sincerely,

Remmolt G. Zwartsenberg <remmolt@zwartsenberg.eu>

Rocket Science Budgetteer

 

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Christopher Pardy
Sent: maandag 20 juli 2009 16:34
To: selinux@tycho.nsa.gov
Subject: adding human understandable, and translatable description support
to selinux

I'm currently working on improving the gui tools for managing selinux(the
ones that ship with fedora). One of the things that has already come up is a
need for more plain English descriptions of various policy components.
Currently this capability exists in the policy.xml for booleans however this
file is not rebuilt at policy compile time so changes and even the
installation of modules is not reflected in this. I'd like to propose that a
documentation section be added to each policy directory,
"/etc/selinux/<policyname>/docs/". This would contain locale specific
documentation files that would store information in key-value pairs. ie:
{users.guest_u:"A guest user who can only (etc)"}. An interface to this
store would be built for libselinux and support for setting and getting
documentation would be added to some of the command line tools or given it's
own tool. Additionally a method would need to be created for policy authors
to define descriptions in there policy (similar to
 the policy.xml method)
Before I get started on this I wanted to see what the general opinion on
both the need and the best implementation would be. So what do you guys
think?

Christopher Pardy <cpardy@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

------=_NextPart_000_0000_01CA096C.F5C7F240--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
