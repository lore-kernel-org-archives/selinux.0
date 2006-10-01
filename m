Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k91Mxxev027955
	for <selinux@tycho.nsa.gov>; Sun, 1 Oct 2006 18:59:59 -0400
Received: from bay0-omc3-s41.bay0.hotmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k91MxNYw007643
	for <selinux@tycho.nsa.gov>; Sun, 1 Oct 2006 22:59:24 GMT
Message-ID: <BAY114-F2E3CC85812D9DF59FB8D2AF1E0@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: 'chcon': possible weakness
Date: Mon, 02 Oct 2006 00:59:55 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I found in the FC5 targeted policy that httpd_t has execute access on files 
of type bin_t...Isn't this an huge security hole? Couldn't one who exploit 
an httpd weakness execute 'chcon' (which has security attributes rwxr-xr-x 
root root system_u:object_r:bin_t), and change the Security Context of a 
file he wants access to?

_________________________________________________________________
Blocca le pop-up pubblicitarie con MSN Toolbar! http://toolbar.msn.it/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
