Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0IECaDg006789
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 09:12:36 -0500
Subject: Re: New Blog on how SELinux blocked Docker container escape.
To: =?UTF-8?B?6Z2i5ZKM5q+F?= <ka-omo@sios.com>
References: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
 <20170114082311.GN12376@tracyreed.org> <87pojqj86o.fsf@elektro.pacujo.net>
 <bc24daad-4944-925f-157c-3dfdc88e253e@redhat.com>
 <CAEKGoSHqxmHMyFVNTvLZcHC4unpONu2O2cq+Y3EZ5=z6=7Ld0A@mail.gmail.com>
Cc: Fedora SELinux Users <selinux@lists.fedoraproject.org>,
 SELinux <selinux@tycho.nsa.gov>, Marko Rauhamaa <marko@pacujo.net>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <8f668ea0-dd25-7f8c-f75d-cee9b9f69e0f@redhat.com>
Date: Wed, 18 Jan 2017 09:12:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAEKGoSHqxmHMyFVNTvLZcHC4unpONu2O2cq+Y3EZ5=z6=7Ld0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 01/18/2017 12:05 AM, 面和毅 wrote:
> Dear Sir,
>
> I'm member of Japan-SOSS SIG(Secure OSS Special
> Interest Group).
> We love SELinux(12years user) and we are promoting SELinux in Japan.
>
> >From technical interesting(we are promoting Docker
> with SELinux), we did PoC for CVE-2016-9962 on Fedora25.
>
> Then we found current SELinux(maybe policy) does not
> mitigate that vulnerability.
>
> We could reproduce that vulnerability with
> - add CAP_SYS_PTRACE to container
> - modified runc because there’s not so much race window on runc.
> then we think it's not so easy in usual situation.
> Also we couldn't reproduce it on CentOS7(latest).
>
> We posted that PoC result on our community blog.
> https://jsosug.github.io/post/omok-selinux-docker-20170118/
>
> Also we wish to argue how can we protect this kind of
> vulnerability by using SELinux.
>
> Kind Regards,
>
> OMO
It mitigates the escape by controlling what can be written and most of
what can be read.
Currently policy allows for some information to be read off of the host
system since the idea
was to allow things like

docker run -ti -v /etc/passwd:/etc/passwd fedora sh

Content in /usr and some content in /etc allowed to be read from inside
of the container.  Content in /var, /home, /root or most other places
where people would store data are blocked.

To work.  I am tightening up the policy to remove the ability to read
content in /etc
