Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9QCDJlb030075
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2010 08:13:23 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o9PNKn04010211
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 23:20:49 GMT
Received: by wwb34 with SMTP id 34so4156929wwb.30
        for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 16:20:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=rnig-t8YiCp7xZUeCoVWNdkjwA0Rx3Lwk6Nd_@mail.gmail.com>
References: <AANLkTi=1q+3VqY4it_eCDJ6KE1_57q61_9jgkrH377NK@mail.gmail.com>
	<AANLkTi=rnig-t8YiCp7xZUeCoVWNdkjwA0Rx3Lwk6Nd_@mail.gmail.com>
Date: Tue, 26 Oct 2010 04:20:48 +0500
Message-ID: <AANLkTinZAT8b-qCfvwZ9iO4z1StXTGSjXWvth0gag7AW@mail.gmail.com>
Subject: Re: Confining Java application with SELinux
From: Shaz <shazalive@gmail.com>
To: mohit verma <mohit89mlnc@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=20cf30025d741818a50493793ecb
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf30025d741818a50493793ecb
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 25, 2010 at 11:14 PM, mohit verma <mohit89mlnc@gmail.com> wrote:

> shaz ,will u please explain ur idea in more detail?
>
>
I want to confine a Java application with SELinux policy so I wanted to know
how I can really do that. Will the application be visible to the native
platform with SELinux? Or only the Java VM is visible and that we use Java
ACL to confine the application inside the VM?

Thanks.

-- 
Shahbaz Khan
Assist. R&D Engineer

http://shazkhan.wordpress.com/
http://pk.linkedin.com/pub/shahbaz-khan/20/116/b49
http://imsciences.edu.pk/serg/
http://csrdu.org/
+92-91-332-9915828

--20cf30025d741818a50493793ecb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Oct 25, 2010 at 11:14 PM, mohit =
verma <span dir=3D"ltr">&lt;<a href=3D"mailto:mohit89mlnc@gmail.com">mohit8=
9mlnc@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 20=
4); padding-left: 1ex;">
shaz ,will u please explain ur idea in more detail?<div><div></div><div cla=
ss=3D"h5"><br clear=3D"all"></div></div></blockquote></div><br>I want to co=
nfine a Java application with SELinux policy so I wanted to know how I can =
really do that. Will the application be visible to the native platform with=
 SELinux? Or only the Java VM is visible and that we use Java ACL to confin=
e the application inside the VM?<br>
<br>Thanks.<br><br>-- <br>Shahbaz Khan<br>Assist. R&amp;D Engineer<br><br><=
a href=3D"http://shazkhan.wordpress.com/" target=3D"_blank">http://shazkhan=
.wordpress.com/</a><br><a href=3D"http://pk.linkedin.com/pub/shahbaz-khan/2=
0/116/b49" target=3D"_blank">http://pk.linkedin.com/pub/shahbaz-khan/20/116=
/b49</a><br>
<a href=3D"http://imsciences.edu.pk/serg/" target=3D"_blank">http://imscien=
ces.edu.pk/serg/</a><br><a href=3D"http://csrdu.org/" target=3D"_blank">htt=
p://csrdu.org/</a><br>+92-91-332-9915828<br><br>

--20cf30025d741818a50493793ecb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
