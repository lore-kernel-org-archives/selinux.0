Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAANZ9Sf006889
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:35:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAANYjBb015840
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 23:34:45 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id hAANYj4o015837
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 23:34:45 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id hAANZ8M20047
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:35:08 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id hAANZ7624041
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:35:07 -0500
Received: from thoron.boston.redhat.com (thoron.boston.redhat.com [172.16.65.238])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id hAANZ4DJ013069
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:35:06 -0500
Date: Mon, 10 Nov 2003 18:35:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Re: Do we break POSIX?
In-Reply-To: <Xine.LNX.4.44.0311101653490.5261-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0311101830520.5670-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Also, here is the relevant quote from IEEE Std 1003.1:

  Implementations may support additional errors not included in this list, 
  may generate errors included in this list under circumstances other than 
  those described here, or may contain extensions or limitations that 
  prevent some errors from occurring. The ERRORS section on each reference 
  page specifies whether an error shall be returned, or whether it may be 
  returned. Implementations shall not generate a different error number 
  from the ones described here for error conditions described in this volume of 
  IEEE Std 1003.1-2001, but may generate additional errors unless 
  explicitly disallowed for a particular function.



- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
