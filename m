Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2IKMkx5002792
	for <selinux@tycho.nsa.gov>; Thu, 18 Mar 2010 16:22:46 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2IKNMlp023789
	for <selinux@tycho.nsa.gov>; Thu, 18 Mar 2010 20:23:22 GMT
Message-ID: <4BA28B93.5000002@manicmethod.com>
Date: Thu, 18 Mar 2010 16:22:43 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Not sure if I sent this one out with the others but since it
 has not been updated yet...
References: <4B9A90B3.3050901@redhat.com>
In-Reply-To: <4B9A90B3.3050901@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Fixes libsepol.pc file.

This looks like it was merged in commit 
7420787817c4949276d7947202b49d78eba37c13 along with the libselinux and 
libsemanage pc.in changes. I didn't bump the version though, since it 
wasn't a code change.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
