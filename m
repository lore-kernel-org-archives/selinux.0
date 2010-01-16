Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0FN7PQC007373
	for <selinux@tycho.nsa.gov>; Fri, 15 Jan 2010 18:07:25 -0500
Received: from pobox.globalherald.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0FNA6bO018226
	for <selinux@tycho.nsa.gov>; Fri, 15 Jan 2010 23:10:06 GMT
Date: Fri, 15 Jan 2010 19:55:08 -0500 (EST)
From: Joshua Kramer <josh@globalherald.net>
To: Richard Bullington-McGuire <richard.bullington-mcguire@threepillarglobal.com>
cc: selinux@tycho.nsa.gov, selinux@lists.fedoraproject.org
Subject: Re: SELinux troubleshooting example
In-Reply-To: <34e141281001151446p4f11c3b9uaf1a57f7fe98312b@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1001151948310.21120@home-av-server.home-av>
References: <34e141281001151446p4f11c3b9uaf1a57f7fe98312b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Richard,

That's a great article you wrote!  I share your sentiment in that I'd 
rather fix SELinux issues than turn it off completely.  In that vein, I 
wrote the following article and followup last year:

http://www.packtpub.com/article/selinux-secured-web-hosting-python-based-web-applications
http://www.globalherald.net/jb01/weblog/21.html

RHEL6 will be even better, as the SELinux libraries included therein will 
allow interesting tricks, such as running different Apache threads under 
different security contexts:

http://code.google.com/p/sepgsql/wiki/Apache_SELinux_plus

Cheers,
-JK

-- 

-----
http://www.globalherald.net/jb01
GlobalHerald.NET, the Smarter Social Network! (tm)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
