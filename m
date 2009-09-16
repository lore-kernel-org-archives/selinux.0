Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8GEtHc5025454
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 10:55:17 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8GEsYxi028632
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 14:54:34 GMT
Message-ID: <4AB0FC53.1040905@manicmethod.com>
Date: Wed, 16 Sep 2009 10:55:15 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Chad Sellers <cdselle@tycho.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I think I sent this patch before,  it is the upgrade patch.
References: <4AAA99B0.4040901@redhat.com>
In-Reply-To: <4AAA99B0.4040901@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Daniel J Walsh wrote:
> Basically it makes semodule -u file.pp, install file.pp if it does not exist.  This matches the rpm syntax, and allows us too update/install many packages with a transaction without know whether the package is updated or installed.
>
> Currently we can only do a -i which could hammer a newwer version.
>
>    

Acked-By: Joshua Brindle <method@manicmethod.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
