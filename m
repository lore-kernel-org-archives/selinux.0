Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l92LeSPa021286
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 17:40:28 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l92LeRdd005966
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 21:40:28 GMT
Received: by py-out-1112.google.com with SMTP id u77so8935600pyb
        for <selinux@tycho.nsa.gov>; Tue, 02 Oct 2007 14:39:39 -0700 (PDT)
Message-ID: <f71a82820710021433w1d2998bcs207d55c3cd39c1ba@mail.gmail.com>
Date: Wed, 3 Oct 2007 06:33:30 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: SEPostgresql doesn't work on my targeted machine
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As
http://code.google.com/p/sepgsql/wiki/install_memo_Fedora7
says, I installed SEPostgresql, but can't enjoy myself yet.

My current note-pc has

selinux-policy-2.6.4-42.sepgsql.fc7
selinux-policy-targeted-2.6.4-42.sepgsql.fc7
selinux-policy-devel-2.6.4-42.sepgsql.fc7

checkpolicy-2.0.3-1.fc7

libselinux-2.0.14-4.fc7
libselinux-devel-2.0.14-4.fc7
libselinux-python-2.0.14-4.fc7

libsemanage-2.0.3-4.fc7

libsepol-2.0.3-1.fc7
libsepol-devel2.0.3-1.fc7

policycoreutils-2.0.16-11.fc7
policycoreutils-gui-2.0.16-11.fc7

postgresql-8.2.4-1.fc7
postgresql-server-8.2.4-1.fc7
postgresql-libs-8.2.4-1.fc7

I can't find any sepostgresql module in my
sepgsql kernel.
Why?
should I downgrade any packages?
Possibility or libsemanage?
Am I missing anything?

What version SEPostgresql works properly?
Please tell me.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
