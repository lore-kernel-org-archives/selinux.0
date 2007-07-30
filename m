Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6UJPGBG013344
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 15:25:16 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6UJPFT4022329
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 19:25:16 GMT
Received: by rv-out-0910.google.com with SMTP id k15so396214rvb
        for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 12:25:15 -0700 (PDT)
Message-ID: <7b740b700707301225q4aa45498yb61f12af17be0d95@mail.gmail.com>
Date: Tue, 31 Jul 2007 00:25:15 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: selinux@tycho.nsa.gov
Subject: PMS and SELinux
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6008_30618202.1185823515242"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_6008_30618202.1185823515242
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I would like to ask a few questions from the experts regarding some
implementations. I am working on a survey on selinux rsbac and grsecurity.
Got some from mailing lists but need more. References will be appreciated..
They are the following:


   1. What is a security aware application. What functionality it can
   provide? Has this functionality been provide in the other competitors.
   2. Where are sids implemented. I have heard that they are history now.
   How are they opaque to object managers?
   3. What difference has PMS brought to selinux. Do we have such in
   other implementations?
   4. How is PMS implemented? Any technical documents? Is it a secure
   application using the extended api?
   5. How and where is AVC implemented?
   6. Is there any good logging facility apart from regular denial? I
   have heard rsbac and grsecurity has better logging facilities.
   7. SELinux uses syscall interception. Is it through LSM? How does
   rsbac and grsecurity manage this?
   8. Of the topic but how does grsecurity implement acls and rbac. Is
   rbac used through the acls or a seperate module?
   9. How can we best judge the network controls of rsbac and grsecurity
   w.r.t. implementation, usability and functionality?

I will be glad to put the names of responders in my survey document's
acknowledgements.

Thank you.
Shaz.

------=_Part_6008_30618202.1185823515242
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I would like to ask a few questions from the experts regarding some implementations. I am working on a survey on selinux rsbac and grsecurity. Got some from mailing lists but need more. References will be appreciated.. They are the following:
</div>
<div>&nbsp;</div>
<ol>
<li>What is a security aware application. What functionality it can provide? Has this functionality been provide in the other competitors.</li>
<li>Where are sids implemented. I have heard that they are history now. How are they opaque to object managers?</li>
<li>What difference has PMS brought to selinux. Do we have such in other implementations?</li>
<li>How is PMS implemented? Any technical documents? Is it a secure application using the extended api?</li>
<li>How and where is AVC implemented?</li>
<li>Is there any good logging facility apart from regular denial? I have heard rsbac and grsecurity has better logging facilities.</li>
<li>SELinux uses syscall interception. Is it through LSM? How does rsbac and grsecurity manage this?</li>
<li>Of the topic but how does grsecurity implement acls and rbac. Is rbac used through the acls or a seperate module?</li>
<li>How can we best judge the network controls of rsbac and grsecurity w.r.t. implementation,&nbsp;usability and functionality?</li></ol>
<div>I will be glad to put the names of responders in my survey document&#39;s acknowledgements.</div>
<div>&nbsp;</div>
<div>Thank you.</div>
<div>Shaz.</div>

------=_Part_6008_30618202.1185823515242--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
