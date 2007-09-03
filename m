Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l83A6AxS006681
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2007 06:06:10 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l83A68E0025548
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2007 10:06:09 GMT
Received: by rv-out-0910.google.com with SMTP id k15so866131rvb
        for <selinux@tycho.nsa.gov>; Mon, 03 Sep 2007 03:06:08 -0700 (PDT)
Message-ID: <7b740b700709030306i72b7b343q1ddfd229df32586a@mail.gmail.com>
Date: Mon, 3 Sep 2007 15:06:08 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Get source and destination info
In-Reply-To: <20cbb9450709030258m68278aferf1a3ed667979cc04@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9816_12675943.1188813968280"
References: <20cbb9450709021618o42ae8047k10e52e880c97a0a8@mail.gmail.com>
	 <711567.2389.qm@web36603.mail.mud.yahoo.com>
	 <20cbb9450709030258m68278aferf1a3ed667979cc04@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_9816_12675943.1188813968280
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>> Hi,
>>
> >I am trying to figure out what part in the kernel code is the point
> >from where I can get source and destination ip-address, port, security
>> labels (selinux etc) from a packet before I export it to application
> >space for my needs. Any hints?

>Look into the netlabel and xfrm code. In Smack it gets dealt with
>in smack_lsm.c, but Smack only uses netlabel. SELinux spreads the
>handling into a number of files, including hooks.c, netlabel.c, xfrm.c,
>and ss/services.c.

Can anyone explain this to me? Some elaboration and exactness required.


>Casey Schaufler
>casey@schaufler-ca.com


-- 
Shahbaz
Group: http://securityengineering.wordpress.com
Email: shazalive@gmail.com
cell: +92 91 0300 5944647

------=_Part_9816_12675943.1188813968280
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&gt;&gt; Hi,<br>&gt;&gt;<br>&gt; &gt;I am trying to figure out what part in the kernel code is the point<br>&gt; &gt;from where I can get source and destination ip-address, port, security<br>&gt;&gt; labels (selinux etc) from a packet before I export it to application
<br>&gt; &gt;space for my needs. Any hints?<br><br>&gt;Look into the netlabel and xfrm code. In Smack it gets dealt with<br>&gt;in smack_lsm.c, but Smack only uses netlabel. SELinux spreads the<br>&gt;handling into a number of files, including 
hooks.c, netlabel.c, xfrm.c,<br>&gt;and ss/services.c.</div>
<div>&nbsp;</div>
<div>Can anyone explain this to me? Some elaboration and exactness required.<br><br><br>&gt;Casey Schaufler<br>&gt;<a href="mailto:casey@schaufler-ca.com">casey@schaufler-ca.com</a><br><br clear="all"><br>-- <br>Shahbaz<br>
Group: <a href="http://securityengineering.wordpress.com">http://securityengineering.wordpress.com</a><br>Email: <a href="mailto:shazalive@gmail.com">shazalive@gmail.com</a><br>cell: +92 91 0300 5944647 </div>

------=_Part_9816_12675943.1188813968280--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
