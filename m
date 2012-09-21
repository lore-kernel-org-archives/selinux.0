Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8L8kGaE005685
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2012 04:46:16 -0400
Received: by vchn11 with SMTP id n11so4212382vch.12
        for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2012 01:46:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120920163132.GA24398@mail.hallyn.com>
References: <1347545325.15047.34.camel@moss-pluto.epoch.ncsc.mil>
	<5051FB6A.8040106@redhat.com>
	<20120915022200.GB6438@mail.hallyn.com>
	<1347975902.29192.17.camel@moss-pluto.epoch.ncsc.mil>
	<5058A22E.7010407@redhat.com>
	<1347988800.31966.58.camel@moss-pluto.epoch.ncsc.mil>
	<20120920163132.GA24398@mail.hallyn.com>
Date: Fri, 21 Sep 2012 10:46:14 +0200
Message-ID: <CAPzO=Nw7vE6Q9ncy-vWauQCzTsEBzj75ExREg0j+B-r637+SzA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Allow test domains to read /etc/passwd
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=20cf307ca332cab6e904ca324581
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf307ca332cab6e904ca324581
Content-Type: text/plain; charset=ISO-8859-1

On Sep 20, 2012 6:34 PM, "Serge E. Hallyn" <serge@hallyn.com> wrote:
> Thanks, applied.

Can we please get auth_read_passwd defined in refpolicy then? If anything,
have it grant read access to etc_t. Otherwise tests in other distributions
but fedora will fail.

--20cf307ca332cab6e904ca324581
Content-Type: text/html; charset=ISO-8859-1

<p><br>
On Sep 20, 2012 6:34 PM, &quot;Serge E. Hallyn&quot; &lt;<a href="mailto:serge@hallyn.com">serge@hallyn.com</a>&gt; wrote:<br>
&gt; Thanks, applied.</p>
<p>Can we please get auth_read_passwd defined in refpolicy then? If anything, have it grant read access to etc_t. Otherwise tests in other distributions but fedora will fail.<br>
</p>

--20cf307ca332cab6e904ca324581--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
