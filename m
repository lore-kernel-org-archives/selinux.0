MIME-Version: 1.0
In-Reply-To: <CAN=9EoTWjzMHoGA0aQzhhFvFsmYKRMoZy3RkY32-u=fLSFVSFg@mail.gmail.com>
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
From: Naina Emmanuel <nemmanuel1992@gmail.com>
Date: Wed, 14 Dec 2016 02:25:34 -0800
Message-ID: <CAN=9EoQRrQNu_AjrdwUZJwuXcwO6nVBGRVHSYL=QRGhqcwSMGg@mail.gmail.com>
Subject: Re: Unconfined label
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
 Vit Mojzis <vmojzis@redhat.com>
Cc: masoom alam <masoom.alam@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a114e486cdf14a305439bc123
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114e486cdf14a305439bc123
Content-Type: text/plain; charset=UTF-8

sir, I have following questions, I am using Centos 7,selinux in Tagrgted
Enforced mode, please help

*Q1:* I have made a new user test1 and mapped that to SELINUX user *user_u *but
when I switch to *test3 *its shows a label *unconfined why?*
[root@localhost ~]# /usr/sbin/useradd -Z user_u test3 && echo test3 |
passwd --stdin test3
Changing password for user test3.
passwd: all authentication tokens updated successfully.
[root@localhost ~]# su test3
[test3@localhost root]$ id -Z
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
[test3@localhost root]$

*Q2: *When I logout from root and login as *test3 *then its show it's
mapped label user_t why?
[test3@localhost ~]$ id -Z
user_u:user_r:user_t:s0
[test3@localhost ~]$


*Q3: *If an unconfined process is compromised, SELinux does not prevent an
attacker from gaining access to system resources and data...... So how can
we restrict any *unconfined *process from accessing the docker daemon?


Please help in this regard thanks!



On 14-Dec-2016 10:37 am, "Naina Emmanuel" <nemmanuel1992@gmail.com> wrote:

> Good morning,
> I have a question that unconfined (processes, users , directories) are
> supposed to be not secured by selinux... and Docker daemon is not accessed
> by confined user(staff, user)
> Q: if selinux by default producing unconfined_t users and root is also
> unconfined_t then where is the difference lies that root can talk to docker
> daemon and some user <user123> with same unconfined_t label can't access
> the docker daemon(creatte or start containers)
> Q: What these unconfined (user, Sir, processes) can do then? Means what
> processes or directories unconfined label can access??
>
> Thanks in advance
>

--001a114e486cdf14a305439bc123
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto">sir, I have following questions, I am us=
ing Centos 7,selinux in Tagrgted Enforced mode, please help</div><div dir=
=3D"auto"><br><div><b>Q1:</b> I have made a new user test1 and mapped that =
to SELINUX user=C2=A0<b>user_u </b>but when I switch to <b>test3=C2=A0</b>i=
ts shows a label <b>unconfined why?</b></div><div><div>[root@localhost ~]# =
/usr/sbin/useradd -Z user_u test3 &amp;&amp; echo test3 | passwd --stdin te=
st3</div><div>Changing password for user test3.</div><div>passwd: all authe=
ntication tokens updated successfully.</div><div>[root@localhost ~]# su tes=
t3</div><div>[test3@localhost root]$ id -Z</div><div>unconfined_u:unconfine=
d_r:<wbr>unconfined_t:s0-s0:c0.c1023</div><div>[test3@localhost root]$</div=
></div><div><br></div><div><b>Q2: </b>When I logout from root and login as =
<b>test3=C2=A0</b>then its show it&#39;s mapped label user_t why?</div><div=
><div>[test3@localhost ~]$ id -Z</div><div>user_u:user_r:user_t:s0</div><di=
v>[test3@localhost ~]$=C2=A0</div></div><div><br></div><div><br></div><div>=
<b>Q3:=C2=A0</b><span style=3D"background-color:transparent;color:rgb(0,0,0=
);font-family:arial;font-size:14.6667px;white-space:pre-wrap">If an unconfi=
ned process is compromised, SELinux does not prevent an attacker from gaini=
ng access to system resources and data...... So how can we restrict any <b>=
unconfined </b>process from accessing the docker daemon?</span></div><div><=
span style=3D"background-color:transparent;color:rgb(0,0,0);font-family:ari=
al;font-size:14.6667px;white-space:pre-wrap"><br></span></div><div><span st=
yle=3D"background-color:transparent;color:rgb(0,0,0);font-family:arial;font=
-size:14.6667px;white-space:pre-wrap"><br></span></div><div><span style=3D"=
background-color:transparent;color:rgb(0,0,0);font-family:arial;font-size:1=
4.6667px;white-space:pre-wrap">Please help in this regard thanks!</span></d=
iv><div><span style=3D"background-color:transparent;color:rgb(0,0,0);font-f=
amily:arial;font-size:14.6667px;white-space:pre-wrap"><br></span></div><div=
><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 14-Dec-2016 10:37 am, &quot;Naina Emmanuel&quot; &lt;<a href=3D"mailto:n=
emmanuel1992@gmail.com" target=3D"_blank">nemmanuel1992@gmail.com</a>&gt; w=
rote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"auto">Good morning,<div dir=3D"auto">I have a question tha=
t unconfined (processes, users , directories) are supposed to be not secure=
d by selinux... and Docker daemon is not accessed by confined user(staff, u=
ser)=C2=A0</div><div dir=3D"auto">Q: if selinux by default producing unconf=
ined_t users and root is also unconfined_t then where is the difference lie=
s that root can talk to docker daemon and some user &lt;user123&gt; with sa=
me unconfined_t label can&#39;t access the docker daemon(creatte or start c=
ontainers)</div><div dir=3D"auto">Q: What these unconfined (user, Sir, proc=
esses) can do then? Means what processes or directories unconfined label ca=
n access??</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks in adv=
ance</div></div>
</blockquote></div></div>
</div>

--001a114e486cdf14a305439bc123--
