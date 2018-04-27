To: Troels Arvin <troels.arvin@gmail.com>, selinux@tycho.nsa.gov
References: <CAJ9kUZ=afxguhDWvttDf6ws-wH=dNcvTT_5s1XU8b-xD7b9-kw@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d893d3fd-b5cf-f959-7de2-3adbedd773f4@tycho.nsa.gov>
Date: Fri, 27 Apr 2018 10:31:45 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ9kUZ=afxguhDWvttDf6ws-wH=dNcvTT_5s1XU8b-xD7b9-kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: Loopback TCP connection
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/27/2018 10:23 AM, Troels Arvin wrote:
> Hello,
> 
> RHEL/CentOS 7.4 was rather disastrous for Tomcat users, because lots of things which used to work suddenly broke, due to a new SELinux policy for Tomcat. RHEL 7.5 has fixed most of it, because a number of commits allowed Tomcat to connect to database systems and other things:
> 
> https://github.com/fedora-selinux/selinux-policy-contrib/commit/cf1ac899006bed35c10c08a76adbbf8ce6e68443
> https://github.com/fedora-selinux/selinux-policy-contrib/commit/e67f46aec82a897218c879e5c92e6921407b9074
> ...
> 
> But I still have a Tomcat app which has run into SELinux-denials. The app needs to send mails, so it tries to connect to port 25. I see a number of ways this could be handled, but I would prefer the following combination:
> 
>  - adjust the policy, so that by default, Tomcat can allow to
>    port 25/tcp on the loopback interface
> 
>  - and add a boolean which allows Tomcat to connect to any port 25/tcp,
>    maybe something along the lines of
>    corenet_tcp_loopback_connect_smtp(tomcat_domain)
> 
> Before I create a Bugzilla case about this for Fedora/Red Hat, I have some questions:
>  - Is it possible to selectively allow an application to connect to something on the loopback-interface?
>  - Is the above proposal a good one, or am I overlooking something?

See:
https://github.com/SELinuxProject/selinux-kernel/issues/21
https://bugzilla.redhat.com/show_bug.cgi?id=1168044
