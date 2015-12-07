Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB7I2D89019117
 for <selinux@tycho.nsa.gov>; Mon, 7 Dec 2015 13:02:13 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 530471A1D8
 for <selinux@tycho.nsa.gov>; Mon,  7 Dec 2015 19:01:58 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id zdTVTHLvLjLu for <selinux@tycho.nsa.gov>;
 Mon,  7 Dec 2015 19:01:54 +0100 (CET)
Received: from [10.20.80.62] (unknown [193.53.238.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 1F5311A070
 for <selinux@tycho.nsa.gov>; Mon,  7 Dec 2015 19:01:54 +0100 (CET)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: chcat is using getlogin() function that sometimes returns null/empty
 string
Message-ID: <5665C991.4030606@debian.org>
Date: Mon, 7 Dec 2015 19:01:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

So apparently gnome-terminal developers have decided to stop updating 
utmp[0] file and this is breaking chcat -Ll with the following error:

Traceback (most recent call last):
   File "/usr/bin/chcat", line 409, in <module>
     sys.exit(listusercats(cmds))
   File "/usr/bin/chcat", line 352, in listusercats
     users.append(os.getlogin())
OSError: [Errno 2] No such file or directory

getlogin(3) manpage suggest to rely on the LOGNAME environment variable, 
so maybe chcat should fallback to this if getlogin() is not returning 
anything?

Cheers,

Laurent Bigonville

[0] https://bugzilla.gnome.org/show_bug.cgi?id=747046
