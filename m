Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QFYsCt019307
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 11:34:54 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8QFYLqH009363
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 15:34:22 GMT
Received: by nf-out-0910.google.com with SMTP id q29so243952nfc
        for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 08:34:53 -0700 (PDT)
Message-ID: <f71a82820609260834k1c885675se75ad4ad82fe0dac@mail.gmail.com>
Date: Wed, 27 Sep 2006 00:34:52 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: About Negation Special Operator
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

I have a question on writing a modular policy.
When I want to allow someting like,

allow domain { exec_type -sbin_t } : file execute;

module test_policy 1.0.0;

require {
	attribute domain;
	type sbin_t;
	class file execute;
}
allow domain { exec_type -sbin_t } : file execute;

will suffice or should I add every exec_type
in require brace?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
