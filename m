Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GIl3x9018838
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 14:47:03 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GIl2Ad016737
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 18:47:02 GMT
Received: by rv-out-0910.google.com with SMTP id k15so248919rvb
        for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 11:47:01 -0700 (PDT)
Message-ID: <7b740b700708161147q1ce955d4ha64320547ac81663@mail.gmail.com>
Date: Thu, 16 Aug 2007 23:47:01 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: selinux@tycho.nsa.gov
Subject: TE for networked resources
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_25652_32148037.1187290021273"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_25652_32148037.1187290021273
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I was curious while reading Brindle et al paper on enhancing selinux policy
for network domain that do we really need TE for these remote resources.
Can't we just do with IBAC and RBAC? We can let the local subjects handle
the TE with their own types with respect to the IBAC and RBAC of remote
subject. This might be what they call equivalence mechanism. The problems
associated with TE are too tough for selinux and current network controls to
handle. The solutions will cost too much.

Is there any progress on this work. Let me know because I have also working
on this and might be able to assist.

-- 
Shaz

------=_Part_25652_32148037.1187290021273
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I was curious while reading Brindle et al paper on enhancing selinux policy for network domain that do we really need TE for these remote resources. Can&#39;t we just do with IBAC and RBAC? We can let the local subjects handle the TE with their own types with respect&nbsp;to the IBAC and RBAC of remote subject. This might be what they call equivalence mechanism. The problems associated with TE are too tough for selinux&nbsp;and current network controls&nbsp;to handle. The solutions will cost too much.
</div>
<div>&nbsp;</div>
<div>Is there any progress on this work. Let me know because I&nbsp;have also working on this and might be able to assist.<br clear="all"><br>-- <br>Shaz</div>

------=_Part_25652_32148037.1187290021273--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
