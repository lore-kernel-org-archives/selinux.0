Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1NIp1Ka003305
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2009 13:51:01 -0500
Received: from mho-01-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1NIp06U013553
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2009 18:51:00 GMT
Cc: SELinux List <selinux@tycho.nsa.gov>
Message-Id: <A4219691-58AB-4D38-82C9-F4C593018ED9@nall.com>
From: Joe Nall <joe@nall.com>
To: Xavier Toth <txtoth@gmail.com>
In-Reply-To: <cadfc0e40902230944q217ed46ar618dc06ccfa2e9fa@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: semanage fcontext --list doesn't list contexts which include HOME_DIR
Date: Mon, 23 Feb 2009 12:50:58 -0600
References: <cadfc0e40902230944q217ed46ar618dc06ccfa2e9fa@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 23, 2009, at 11:44 AM, Xavier Toth wrote:

> Is there a different option or command I can use to see these?

Is
cat /etc/selinux/mls/contexts/files/file_contexts.homedirs
complete?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
