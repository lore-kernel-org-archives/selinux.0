Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EC6YWt017874
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 08:06:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9EC6XhS001328
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 12:06:33 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h9EC6XEs001325 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 12:06:33 GMT
Date: Tue, 14 Oct 2003 08:06:53 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: trusted vs untrusted packages
In-Reply-To: <200310141107.53852.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0310140805090.1093-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 Oct 2003, Russell Coker wrote:

> Now this raises some interesting issues.  If a signed package has a program 
> which relies on some other program (and has a dependency), what happens if 
> the dependency is satisfied by an unsigned package?  Installing the unsigned 
> package may not result in the system being fully functional (execution of the 
> file in question may be denied).

This should be like enforcing vs. non-enforcing -- you either want all of
your packages signed (and the above would fail) or not (just generate a
warning).


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
