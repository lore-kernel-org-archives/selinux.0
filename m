Subject: Re: Unconfined label
To: Naina Emmanuel <nemmanuel1992@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Vit Mojzis <vmojzis@redhat.com>
References: <CAN=9EoSnUYQoC0SbnrVw+cKxNQFyUG+ekgK4JjRQZgChWjSCnw@mail.gmail.com>
 <CAN=9EoQnJBAqkDGZNnQHxQBotAXd8hKM4Dyxt0H=1qF5AOiVrQ@mail.gmail.com>
 <CAN=9EoS2brmWW2xwMHFqJNQeHOcx+WZzwBhLww+dSTLxyfzXBg@mail.gmail.com>
 <CAN=9EoRCPwXn5QK9xrSenEoJpmEKU2xMkia=9BR5STkLEjW9EQ@mail.gmail.com>
 <CAN=9EoS7bgfv4VPo31Aurx5JXEAUYbe3KBWqJGKx90A7D1rORg@mail.gmail.com>
 <CAN=9EoTd6U0FvZpzZGeeXaCZ3XS=xcX8Y3S2nMMfxViho5zjQw@mail.gmail.com>
 <CAN=9EoRHnWZHMiHsvBxQZna_MPoom1KuGjEgpq0xbUAz1NmbUw@mail.gmail.com>
 <CAN=9EoRNLozdBh0LQufH+7X+z+tbUKcmwfonpCFJVoSHuVCdSA@mail.gmail.com>
 <CAN=9EoSmJ8c+ZqSAUiHt3--3W9R-58JrycDhZQK=ukw0O7h9Mw@mail.gmail.com>
 <CAN=9EoTWjzMHoGA0aQzhhFvFsmYKRMoZy3RkY32-u=fLSFVSFg@mail.gmail.com>
 <CAN=9EoQRrQNu_AjrdwUZJwuXcwO6nVBGRVHSYL=QRGhqcwSMGg@mail.gmail.com>
Cc: masoom alam <masoom.alam@gmail.com>, selinux@tycho.nsa.gov
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <48b38d07-c36d-777d-96ce-974276178c15@redhat.com>
Date: Wed, 14 Dec 2016 08:24:12 -0500
MIME-Version: 1.0
In-Reply-To: <CAN=9EoQRrQNu_AjrdwUZJwuXcwO6nVBGRVHSYL=QRGhqcwSMGg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------C02BFB5929089C511A891860"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------C02BFB5929089C511A891860
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



On 12/14/2016 05:25 AM, Naina Emmanuel wrote:
> sir, I have following questions, I am using Centos 7,selinux in
> Tagrgted Enforced mode, please help
>
> *Q1:* I have made a new user test1 and mapped that to SELINUX
> user *user_u *but when I switch to *test3 *its shows a label
> *unconfined why?*
> [root@localhost ~]# /usr/sbin/useradd -Z user_u test3 && echo test3 |
> passwd --stdin test3
> Changing password for user test3.
> passwd: all authentication tokens updated successfully.
> [root@localhost ~]# su test3
> [test3@localhost root]$ id -Z
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> [test3@localhost root]$
>
su does not go through a full login process.  We only enter user domains
through full login commands.
> *Q2: *When I logout from root and login as *test3 *then its show it's
> mapped label user_t why?
> [test3@localhost ~]$ id -Z
> user_u:user_r:user_t:s0
> [test3@localhost ~]$ 
>
>
See above.
> *Q3: *If an unconfined process is compromised, SELinux does not
> prevent an attacker from gaining access to system resources and
> data...... So how can we restrict any *unconfined *process from
> accessing the docker daemon?
Don't run the process as unconfined if you want it confined.  Also
access to the docker.socket is controlled using DAC,
so an unconfined user running as non root cannot talk to the socket, he
has to become root to talk to it.

http://www.projectatomic.io/blog/2015/08/why-we-dont-let-non-root-users-run-docker-in-centos-fedora-or-rhel/
> Please help in this regard thanks!
>
>
> On 14-Dec-2016 10:37 am, "Naina Emmanuel" <nemmanuel1992@gmail.com
> <mailto:nemmanuel1992@gmail.com>> wrote:
>
>     Good morning,
>     I have a question that unconfined (processes, users , directories)
>     are supposed to be not secured by selinux... and Docker daemon is
>     not accessed by confined user(staff, user) 
>     Q: if selinux by default producing unconfined_t users and root is
>     also unconfined_t then where is the difference lies that root can
>     talk to docker daemon and some user <user123> with same
>     unconfined_t label can't access the docker daemon(creatte or start
>     containers)
>     Q: What these unconfined (user, Sir, processes) can do then? Means
>     what processes or directories unconfined label can access??
>
>     Thanks in advance
>


--------------C02BFB5929089C511A891860
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 12/14/2016 05:25 AM, Naina Emmanuel
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAN=9EoQRrQNu_AjrdwUZJwuXcwO6nVBGRVHSYL=QRGhqcwSMGg@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div dir="auto">sir, I have following questions, I am using
          Centos 7,selinux in Tagrgted Enforced mode, please help</div>
        <div dir="auto"><br>
          <div><b>Q1:</b> I have made a new user test1 and mapped that
            to SELINUX user <b>user_u </b>but when I switch to <b>test3 </b>its
            shows a label <b>unconfined why?</b></div>
          <div>
            <div>[root@localhost ~]# /usr/sbin/useradd -Z user_u test3
              &amp;&amp; echo test3 | passwd --stdin test3</div>
            <div>Changing password for user test3.</div>
            <div>passwd: all authentication tokens updated successfully.</div>
            <div>[root@localhost ~]# su test3</div>
            <div>[test3@localhost root]$ id -Z</div>
            <div>unconfined_u:unconfined_r:<wbr>unconfined_t:s0-s0:c0.c1023</div>
            <div>[test3@localhost root]$</div>
          </div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    su does not go through a full login process.  We only enter user
    domains through full login commands.<br>
    <blockquote
cite="mid:CAN=9EoQRrQNu_AjrdwUZJwuXcwO6nVBGRVHSYL=QRGhqcwSMGg@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div dir="auto">
          <div><b>Q2: </b>When I logout from root and login as <b>test3 </b>then
            its show it's mapped label user_t why?</div>
          <div>
            <div>[test3@localhost ~]$ id -Z</div>
            <div>user_u:user_r:user_t:s0</div>
            <div>[test3@localhost ~]$ </div>
          </div>
          <div><br>
          </div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    See above.<br>
    <blockquote
cite="mid:CAN=9EoQRrQNu_AjrdwUZJwuXcwO6nVBGRVHSYL=QRGhqcwSMGg@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div dir="auto">
          <div><b>Q3: </b><span style="background-color:transparent;color:rgb(0,0,0);font-family:arial;font-size:14.6667px;white-space:pre-wrap">If an unconfined process is compromised, SELinux does not prevent an attacker from gaining access to system resources and data...... So how can we restrict any <b>unconfined </b>process from accessing the docker daemon?</span></div>
          <div><span style="background-color:transparent;color:rgb(0,0,0);font-family:arial;font-size:14.6667px;white-space:pre-wrap">
</span></div>
          <div><span style="background-color:transparent;color:rgb(0,0,0);font-family:arial;font-size:14.6667px;white-space:pre-wrap">
</span></div>
        </div>
      </div>
    </blockquote>
    Don't run the process as unconfined if you want it confined.  Also
    access to the docker.socket is controlled using DAC, <br>
    so an unconfined user running as non root cannot talk to the socket,
    he has to become root to talk to it.<br>
    <br>
<a class="moz-txt-link-freetext" href="http://www.projectatomic.io/blog/2015/08/why-we-dont-let-non-root-users-run-docker-in-centos-fedora-or-rhel/">http://www.projectatomic.io/blog/2015/08/why-we-dont-let-non-root-users-run-docker-in-centos-fedora-or-rhel/</a><br>
    <blockquote
cite="mid:CAN=9EoQRrQNu_AjrdwUZJwuXcwO6nVBGRVHSYL=QRGhqcwSMGg@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div dir="auto">
          <div><span style="background-color:transparent;color:rgb(0,0,0);font-family:arial;font-size:14.6667px;white-space:pre-wrap">Please help in this regard thanks!</span></div>
          <div><span style="background-color:transparent;color:rgb(0,0,0);font-family:arial;font-size:14.6667px;white-space:pre-wrap">
</span></div>
          <div><br>
          </div>
        </div>
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On 14-Dec-2016 10:37 am, "Naina
            Emmanuel" &lt;<a moz-do-not-send="true"
              href="mailto:nemmanuel1992@gmail.com" target="_blank">nemmanuel1992@gmail.com</a>&gt;
            wrote:<br type="attribution">
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div dir="auto">Good morning,
                <div dir="auto">I have a question that unconfined
                  (processes, users , directories) are supposed to be
                  not secured by selinux... and Docker daemon is not
                  accessed by confined user(staff, user) </div>
                <div dir="auto">Q: if selinux by default producing
                  unconfined_t users and root is also unconfined_t then
                  where is the difference lies that root can talk to
                  docker daemon and some user &lt;user123&gt; with same
                  unconfined_t label can't access the docker
                  daemon(creatte or start containers)</div>
                <div dir="auto">Q: What these unconfined (user, Sir,
                  processes) can do then? Means what processes or
                  directories unconfined label can access??</div>
                <div dir="auto"><br>
                </div>
                <div dir="auto">Thanks in advance</div>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------C02BFB5929089C511A891860--
