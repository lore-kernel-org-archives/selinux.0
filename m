Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l710CKcO022176
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 20:12:20 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l710CJDj009287
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 00:12:19 GMT
Received: by rv-out-0910.google.com with SMTP id k15so28025rvb
        for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 17:12:19 -0700 (PDT)
Message-ID: <7b740b700707311712n3c695740gb540b88412596a5a@mail.gmail.com>
Date: Wed, 1 Aug 2007 05:12:18 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: selinux@tycho.nsa.gov
Subject: selinux rsbac and grsecurity internels
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would like to ask a few questions from the experts regarding some
implementations. I am working on a survey on selinux rsbac and
grsecurity. Got some from mailing lists but need more. References will
be appreciated.. They are the following:

1. What is a security aware application. What functionality it can
provide? Has this functionality been provide in the other competitors.

2. Where are sids implemented. I have heard that they are history now.
How are they opaque to object managers?

3. What difference has PMS brought to selinux. Do we have such in
other implementations?

4. How is PMS implemented? Any technical documents? Is it a secure
application using the extended api?

5. How and where is AVC implemented?

6.Is there any good logging facility apart from regular denial? I have
heard rsbac and grsecurity has better logging facilities.

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

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
