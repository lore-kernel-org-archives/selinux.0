Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8PFhfiH008303
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 11:43:41 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m8PFhbPD027709
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 15:43:41 GMT
Message-ID: <48DBB1A2.7050908@manicmethod.com>
Date: Thu, 25 Sep 2008 11:43:31 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: checkmodule: duplicate declaration of type/attribute problem
References: <cadfc0e40809250808q1dcfcd94n2c2fa496a485b790@mail.gmail.com>
In-Reply-To: <cadfc0e40809250808q1dcfcd94n2c2fa496a485b790@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> The attribute in question is inside a gen_require of a template and I
> have looked at the tmp file to verify that there is only one
> declaration. Is this a misleading error message or a compiler bug? Any
> suggestions on how to deal with this problem?
> 
> Ted

What version of checkpolicy and libsepol?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
