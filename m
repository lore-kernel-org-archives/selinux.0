Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5LD5QrT000774
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 09:05:26 -0400 (EDT)
Received: from mail.idtweb.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5LD5ENg012764
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 13:05:14 GMT
Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'John D. Ramsdell'" <ramsdell@mitre.org>, <selinux@tycho.nsa.gov>
Cc: <selinux-dev@tresys.com>
Subject: RE: Fedora Core 2 setools RPM
Date: Mon, 21 Jun 2004 09:04:22 -0400
Message-ID: <003f01c45790$6a3cc090$4d0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <ogtllil1085.fsf@mitre.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> If Tresys is not completely sure that the libapol API is stable, they
> may want to only release a static library for now.  Changing the API
> used by a static library means that compilations may fail, but
> existing binaries will be not be effected by the change.  Changing the
> API used by a shared library means that existing binaries may fail.
> Tresys should commit itself to an API provided by a shared library
> only after careful thought. 
> 
> John

We are positive that the API is not stable, and guarantee that it will change a
lot between releases.  We're still in a highly exploratory development cycle; so
feel free to use the libraries but understand they are evolving based upon our
needs.  For example, significant work is proceeding now to enhance the library
to support a semantic policy diff tool we're building, as well as a means to
model and batch information flow analyses. 

With that said, we have 2.5 years invested in this code, and for our own sanity
we try to keep old interfaces syntactically the same between versions, and add
new ones as necessary.  The headers are not structured well for strong modular
isolation of the libraries, so be careful.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
