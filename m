Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9QCUZrl031424
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2010 08:30:35 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o9QCUZU2024158
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2010 12:30:35 GMT
Message-ID: <4CC6C9DF.6050709@tresys.com>
Date: Tue, 26 Oct 2010 08:30:23 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Shaz <shazalive@gmail.com>
CC: mohit verma <mohit89mlnc@gmail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Confining Java application with SELinux
References: <AANLkTi=1q+3VqY4it_eCDJ6KE1_57q61_9jgkrH377NK@mail.gmail.com>	<AANLkTi=rnig-t8YiCp7xZUeCoVWNdkjwA0Rx3Lwk6Nd_@mail.gmail.com> <AANLkTinZAT8b-qCfvwZ9iO4z1StXTGSjXWvth0gag7AW@mail.gmail.com>
In-Reply-To: <AANLkTinZAT8b-qCfvwZ9iO4z1StXTGSjXWvth0gag7AW@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/25/10 19:20, Shaz wrote:
> I want to confine a Java application with SELinux policy so I wanted to
> know how I can really do that. Will the application be visible to the
> native platform with SELinux? Or only the Java VM is visible and that we
> use Java ACL to confine the application inside the VM?

You can only confine the JVM.  If there is more than one application in
the JVM, they will not be separable by SELinux.  So if you want
separation between two or more Java applications enforced by SELinux,
they would have to run in separate JVMs.


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
