Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5MGQJ8D017153
	for <selinux@tycho.nsa.gov>; Sat, 22 Jun 2013 12:26:19 -0400
Received: by mail-ea0-f169.google.com with SMTP id h15so5331293eak.28
        for <selinux@tycho.nsa.gov>; Sat, 22 Jun 2013 09:26:17 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id c44sm15455741eeb.8.2013.06.22.09.19.06
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 09:19:07 -0700 (PDT)
Date: Sat, 22 Jun 2013 18:17:11 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: pcre 8.33 changes restorecon behavior
Message-ID: <20130622161711.GA2010@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi guys

Since libpcre 8.33, the behavior of restorecon is different. Take the
context for /sbin for instance:

Before libpcre 8.33:
  # matchpathcon /sbin
  /sbin	system_u:object_r:bin_t:s0

With and after libpcre 8.33:
  # matchpathcon /sbin
  /sbin	<<none>>

As a result, trying to reset the label fails:

# restorecon -Fv /sbin
restorecon:  Warning no default label for /sbin

Is this a bug in libpcre or are we using it differently? According to
Alphat-PC, it is due to rev 1313 of libpcre:
http://vcs.pcre.org/viewvc?view=revision&revision=1313

Thanks to Alphat-PC for reporting and debugging it at
https://bugs.gentoo.org/show_bug.cgi?id=471718

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
