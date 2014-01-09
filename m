Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09Gxge5003782
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 11:59:42 -0500
Received: from web6m.yandex.ru (web6m.yandex.ru [37.140.138.97])
 by forward1m.mail.yandex.net (Yandex) with ESMTP id 2EF661221139
 for <selinux@tycho.nsa.gov>; Thu,  9 Jan 2014 20:59:36 +0400 (MSK)
From: Victor Porton <porton@narod.ru>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <23731389285461@web11j.yandex.ru>
References: <23731389285461@web11j.yandex.ru>
Subject: Re: Restrict to a fixed Internet domain in a sandbox
MIME-Version: 1.0
Message-Id: <160241389286775@web6m.yandex.ru>
Date: Thu, 09 Jan 2014 18:59:35 +0200
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

09.01.2014, 18:39, "Victor Porton" <porton@narod.ru>:
> I remind that sandbox is implemented in Fedora using SELinux.
>
> It would be useful to restrict sandboxed application to connect only to one, programmatically specified Internet domain (just like Java and JavaScript security).
>
> It seems it is impossible with current SELinux.
>
> Could you add necessary features? Please!

You could add a syscall like:

int selinux_restrict_domain(const char *domain);

(We could modify this interface to restrict to a finite list of domains instead of one domain, but personally I don't need this.)

-- 
Victor Porton - http://portonvictor.org
