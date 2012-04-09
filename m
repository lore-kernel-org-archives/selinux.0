Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q39HYvTt020745
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2012 13:34:57 -0400
Message-ID: <4F831D42.2080208@manicmethod.com>
Date: Mon, 09 Apr 2012 13:32:50 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: rpcraig <rpcraig@tycho.ncsc.mil>
CC: selinux@tycho.nsa.gov
Subject: Re: libselinux: Provide new labeling backend
References: <4F7F4FD5.30108@tycho.ncsc.mil>
In-Reply-To: <4F7F4FD5.30108@tycho.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

rpcraig wrote:
> I have attached a patch which provides a new labeling backend
> directed at the Android property service keys.

Does this apply to the main selinux repo or the android repo? It appears to be 
the selinux repo but I don't understand what the purpose is since Android uses a 
different libselinux at runtime.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
