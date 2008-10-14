Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9ECJj1n028033
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 08:19:45 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9ECJjep029220
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 12:19:45 GMT
Message-ID: <48F48E51.7080109@redhat.com>
Date: Tue, 14 Oct 2008 08:19:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Subject: Re: [refpolicy] newrole without even knowing
References: <dd18b0c30810131504h67a496e7h2247b3bf487d04ec@mail.gmail.com>
In-Reply-To: <dd18b0c30810131504h67a496e7h2247b3bf487d04ec@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Justin Mattock wrote:
> Hello; is there an application that I can use for
> newrole, so I dont have to open a terminal?
> i.g. running firefox I have to open a terminal
> type newrole -r *_r  <passwd> and then firefox
> to run. Idealistically I would like to just click on any icon
> and have them already configured with its role.
> I've tried in the menu configuration newrole -r *_r && firefox
> but I receive nothing.
> Any ideas would be appreciated.
> regards;
> 
runcon?  Or write policy to transition automatically.  You can also do
stuff with sudo.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
