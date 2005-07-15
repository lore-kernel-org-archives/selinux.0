Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6F5TwgA008699
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 01:29:58 -0400 (EDT)
Received: from zproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6F5PhBp013357
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 05:25:43 GMT
Received: by zproxy.gmail.com with SMTP id 9so317436nzo
        for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 22:26:28 -0700 (PDT)
Message-ID: <856763c80507142226142e4159@mail.gmail.com>
Date: Thu, 14 Jul 2005 22:26:28 -0700
From: Alexander Kabanov <shurikk@gmail.com>
Reply-To: Alexander Kabanov <shurikk@gmail.com>
To: selinux@tycho.nsa.gov
Subject: apache virtualhost and selinux
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I'm new to SELinux, would like to solve the following
problem (not sure I can do this with SELinux)

so, here is the description:

- httpd (apache, let say it has some modules like mod_perl, mod_php,
mod_jk etc.)
- virtual hosts like
 /path/host1
 /path/host2
 etc.

is there a way to contol access of  /path/host1/script1.php to
/path/host2 files using SELinux policies?

suexec (works for CGI scripts only not for similar to mod_php modules)
is know solution, is it possible to implement this with SELinux
policies?

Thanks

-Alex


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
