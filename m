Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p65MBQ7i020209
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2011 18:11:30 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p65MBTXk001667
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2011 22:11:29 GMT
Received: by wyh22 with SMTP id 22so5099918wyh.12
        for <selinux@tycho.nsa.gov>; Tue, 05 Jul 2011 15:11:28 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 5 Jul 2011 17:11:28 -0500
Message-ID: <CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>
Subject: Best base policy to use
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001517592bd0f7a37d04a759c3cc
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001517592bd0f7a37d04a759c3cc
Content-Type: text/plain; charset=ISO-8859-1

So I'm in the process of Upgrading my servers from RHEL5 to RHEL6. On my
RHEL5 system I had to build the reference policy from scratch in order to
prevent users from being able to  transition to init_t through initrc_t.
Basically, I want systems that have to be rebooted in order to restart
certain services, like auditd, or at least be able to split those duties
into different roles. One role can edit a file or install something, but a
different role must restart it. Because life the universe and everything
goes through initrc_t, just about anything on the system running as root can
mess with services. I'd like to highly limit things, and haven't  really
looked at any new developments in selinux for about 4 years. What's the best
way/place to start removing domain transitions and requiring additional
roles.

thanks,
-jj-

--001517592bd0f7a37d04a759c3cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

So I&#39;m in the process of Upgrading my servers from RHEL5 to RHEL6. On m=
y RHEL5 system I had to build the reference policy from scratch in order to=
 prevent users from being able to=A0 transition to init_t through initrc_t.=
 Basically, I want systems that have to be rebooted in order to restart cer=
tain services, like auditd, or at least be able to split those duties into =
different roles. One role can edit a file or install something, but a diffe=
rent role must restart it. Because life the universe and everything goes th=
rough initrc_t, just about anything on the system running as root can mess =
with services. I&#39;d like to highly limit things, and haven&#39;t=A0 real=
ly looked at any new developments in selinux for about 4 years. What&#39;s =
the best way/place to start removing domain transitions and requiring addit=
ional roles. <br>
<br>thanks,<br>-jj-<br>

--001517592bd0f7a37d04a759c3cc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
