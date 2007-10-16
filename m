Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9G4WqPm006660
	for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 00:32:53 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l9G4Wqco007940
	for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 04:32:52 GMT
Message-ID: <47143EDB.7040906@manicmethod.com>
Date: Tue, 16 Oct 2007 00:32:27 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: selinux@tycho.nsa.gov
Subject: Re: newrole authentication
References: <FB39F4E77226B448BC1388D3BE4E00CD0236CA79@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD0236CA79@blums0008.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
> Will someone point me to information or send me an example on how to set
> up newrole so that is does not ask for a password, so that it can by
> used like this within software "newrole -l s1 -- -c <cmd>"?
>   
newrole is designed to be a human interface and therefore to ask for a 
password, perhaps you are looking for runcon?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
