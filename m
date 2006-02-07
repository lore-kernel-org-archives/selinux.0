Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k171TwXf016061
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2006 20:29:58 -0500 (EST)
Received: from uproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k171Scnx029967
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 01:28:39 GMT
Received: by uproxy.gmail.com with SMTP id j3so115676ugf
        for <selinux@tycho.nsa.gov>; Mon, 06 Feb 2006 17:29:56 -0800 (PST)
Message-ID: <ef5305790602061729o5b8e0a02p12215cb731e00bd5@mail.gmail.com>
Date: Tue, 7 Feb 2006 14:29:55 +1300
From: Goo GGooo <googgooo@gmail.com>
To: selinux@tycho.nsa.gov
Subject: SElinux from scratch
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I'm about to learn something more about SElinux policies. I read some
fundamentals from James Morris, I found that Fedora comes with
prepared SElinux policies, but I don't know how to start writing my
own policies.

For now my intent is to harden Apache httpd, prevent it from executing
all but permitted binaries, restrict access to some filesystem areas,
etc. I'm running OpenSUSE 10.0 and have found the SElinux-related
packages (sysvinit, pam, ...) and basically I'm ready to create
whatever files in /etc, compile them, load in permissive mode, watch
the syslog, fix the policies, etc. I just don't know where to start...

Can someone point me to such an introduction?

Thanks!

Goo


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
