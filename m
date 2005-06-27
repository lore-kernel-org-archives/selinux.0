Message-ID: <42C022EC.8000701@linuon.com>
Date: Tue, 28 Jun 2005 01:01:48 +0900
From: Junji Kanemaru <linux@linuon.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Joshua Brindle <jbrindle@tresys.com>, alexander-barclay@utulsa.edu,
   Brandon Pollet <brandon@utulsa.edu>, SELinux@tycho.nsa.gov,
   John Hale <john-hale@utulsa.edu>
Subject: Re: XML Based Policy Configuration for SELinux
References: <7D1D591C-7CB7-4FAA-82DF-0CA87BE3372F@utulsa.edu>	 <20050621184940.GA8354@lkcl.net> <1119383982.42b871aef1898@cc.utulsa.edu>	 <20050621212059.GA9434@lkcl.net> <42B8A699.206@tresys.com>	 <20050622004114.GH9859@lkcl.net> <42B8DF16.3060108@tresys.com>	 <20050622053327.GB14480@lkcl.net> <42B94A03.8020508@tresys.com>	 <20050622223842.GH14480@lkcl.net> <1119486152.7677.15.camel@localhost.localdomain>
In-Reply-To: <1119486152.7677.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi guys,

I'm impressed xml based policy discussion here.
Is there XML based policy project home page that you are working on?
The idea, having policy in XML is similar to what we have been discussing
here in Japan.

What we are thinking is:

1) Policy maintainer creates policy source
2) Convert the source to XML and put them into XMLDB using tool
3) Users(regular admins I'd say) pickup and download policy fragments
    what exactly they need from XMLDB with XML query
4) Then convert the XML source to regular policy source and compile
    and apply.

Some people would think it is wasteful, why not having raw policy
source in DB. But I think XML makes things easier for adding, modifing
and deleting some part of policy.

IMO, currently it is very difficult to find dependencies in the policy source
but if we have it in XML it is easier.

-- Junji
Linuon Inc.
Tokyo Japan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
