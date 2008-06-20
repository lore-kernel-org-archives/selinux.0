Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5KGa6QE031917
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 12:36:06 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5KGa1No000371
	for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 16:36:05 GMT
Received: by fg-out-1718.google.com with SMTP id 16so658589fgg.40
        for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2008 09:36:01 -0700 (PDT)
Message-ID: <cadfc0e40806200936x4c7ceb4aneaaccd09c9061ac8@mail.gmail.com>
Date: Fri, 20 Jun 2008 11:36:01 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mail List" <selinux@tycho.nsa.gov>
Subject: x client policy interfaces
Cc: "Eamon Walsh" <ewalsh@tycho.nsa.gov>, "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been looking at the xserver_common_x_domain_template and AVCs
coming out of X applications and thinking it would be good to have
finer grained interfaces that could be used to build policy for the
wide variety of GUI apps. X extensions and selection are a couple of
area that caught my eye can you think of others.

Example:

########################################
## <summary>
##	Allow an X client to use an X extension
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed use an X extension.
##	</summary>
## </param>
## <param name="xextension prefix">
##	<summary>
##	Prefix for the X extension (screensaver, output, etc ...).
##	</summary>
## </param>
#
interface(`xserver_use_xextension',`
	gen_require(`
                class x_extension { use getattr };
		type $2_xext_t;
	')

        allow $1 $2_xext_t:x_extension { use getattr };
')

########################################
## <summary>
##	Allow an X client to use the screensaver X extension
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed use an X extension.
##	</summary>
## </param>
#
interface(`xserver_use_screensaver_xextension',`
	gen_require(`
                class x_extension { use getattr };
		type screensaver_xext_t;
	')

        xclient_use_xextension($1, screensaver)
')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
